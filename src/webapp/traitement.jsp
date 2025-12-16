<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="database.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
Connection con = null;
Function fonction = new Function();
boolean success = false;
Vector<Unite> L_unite = new Vector<>();

String med = request.getParameter("medecin");
String patient = request.getParameter("patient");
String[] selectedMedocIds = request.getParameterValues("selectedMedoc");

Med_Ordonnance ordonnance = new Med_Ordonnance();
ordonnance.setIdmedecin(med);
try {
    con = VanialaConnection.getConnection();
    con.setAutoCommit(false);

    if (med == null || med.trim().isEmpty()) {
        response.sendRedirect("home.jsp?error=" + URLEncoder.encode("Veuillez sélectionner un médecin", "UTF-8"));
        return;
    }
    if (patient == null || patient.trim().isEmpty()) {
        response.sendRedirect("home.jsp?error=" + URLEncoder.encode("Veuillez sélectionner un patient", "UTF-8"));
        return;
    }
    if (selectedMedocIds == null || selectedMedocIds.length == 0) {
        response.sendRedirect("home.jsp?error=" + URLEncoder.encode("Aucun médicament sélectionné", "UTF-8"));
        return;
    }
    Vector<Medicament> medicaments = fonction.get_medicaments(con);
    int prochainNumero = medicaments.size() + 1;
    
    String idConsultation = "CONS" + String.format("%06d", prochainNumero);
      ordonnance.setId_consultation(idConsultation);
      ordonnance.setDaty(null);                    
      ordonnance.setNb_jours("");                     
      ordonnance.setDate_debut(null);
      ordonnance.setDate_fin(null);
      ordonnance.setType("");                          
      ordonnance.setEtat(1);                           
      ordonnance.setObservation_s(patient);         
    
    String idOrdonnance = fonction.insert_ordonnance(ordonnance, con);  
    if (idOrdonnance == null) {
        throw new Exception("Échec insertion ordonnance principale");
    }

    L_unite = fonction.get_as_unite_v(con);
    double Mtotal = 0.0;
    int compteurLigne = 1;
    for (String idMedoc : selectedMedocIds) {
        Medicament medoc = null;
        int indice = 0;
        for(int i = 0;  i < medicaments.size(); i++){
            if(medicaments.get(i).getId().equals(idMedoc)){
                medoc = medicaments.get(i);
                indice = i;
                break;
            }
        }

        String quantiteStr = request.getParameter("quantite_" + indice);
        String posologie = request.getParameter("desc_" + indice);
        String unite = request.getParameter("unite_" + indice);
        Unite unite_choisi = null;

        double quantite = 1;
        if (quantiteStr != null && !quantiteStr.trim().isEmpty()) {
            try {
                quantite = Double.parseDouble(quantiteStr.trim());
                if (quantite <= 0) quantite = 1;
            } catch (NumberFormatException e) {
                quantite = 1;
            }
        }

        if (posologie == null) posologie = "";
        
        for(Unite u: L_unite){
            if(u.getId().equals(unite)){
                unite_choisi = u;
                break;
            }
        }
        if(unite_choisi == null){
            throw new Exception("Aucun Unite choisi !!");
        }
        // qte diviser en 2
        int qteInt = (int) quantite;
        double qteDouble = (double) (quantite - qteInt);

        double pu = 0.0;
        int etat_equi = 0;

        if(medoc.getUnite().equals(unite)){
            pu = medoc.getPv();
            double prixTotal = quantite * pu;
            Mtotal += prixTotal;
            String idLigne = idOrdonnance + "-" + String.format("%03d", compteurLigne++);
            MedOrdonnanceFille ligne1 = new MedOrdonnanceFille(
                idMedoc,                   
                posologie,                 
                idOrdonnance,              
                idLigne,                   
                11,                       
                "",                       
                prixTotal,                
                "",                        
                1,                   
                unite,         
                "",                         
                pu,                        
                quantite,                  
                0.0                      
            );

        fonction.insert_ordonnance_fille(ligne1, con);
        } else{
            Equivalence equi = fonction.get_equivalence(con,unite);
            if(equi == null){
                throw new Exception("Aucun equivalence ne correspond a l'unite choisi !!");
            }
            pu = equi.getPv();
            etat_equi = equi.getEtat();
            double prixTotal = 0.0;

            if(etat_equi == 0){             // divisible
                double qte_d = qteDouble * equi.getQuantite();
                prixTotal = (pu * qteInt) + (medoc.getPv() * qte_d);
            } else if(etat_equi == 1){      // pas divisible
                prixTotal = pu * quantite;
            }
            Mtotal += prixTotal;

            String idLigne = idOrdonnance + "-" + String.format("%03d", compteurLigne++);
            MedOrdonnanceFille ligne2 = new MedOrdonnanceFille(
                idMedoc,                   
                posologie,                 
                idOrdonnance,              
                idLigne,                   
                11,                       
                "",                       
                prixTotal,                
                "",                        
                1,                   
                unite,         
                "",                         
                pu,                        
                quantite,                  
                0.0                      
            );
            fonction.insert_ordonnance_fille(ligne2, con);
        }
    }
    Ordonnance_complet ORDMere = fonction.get_1ordonnance_complet(con,idOrdonnance);
    long now = System.currentTimeMillis();
    String idNv = "ORD"+Mtotal+""+ORDMere.getDaty()+"" + String.format("%012d", now % 10000L);
    if(fonction.update_ordonnance(con,idNv,idOrdonnance)){
        Vector<MedOrdonnanceFille> ordonnanceFille = fonction.get_medordonnances_fille(idOrdonnance,con);
        for(MedOrdonnanceFille odf: ordonnanceFille){
            odf.setIdOrdonnance(idNv);
            out.println(
                "UPDATE ODF id=" + odf.getId() +
                " oldOrd=" + idOrdonnance +
                " newOrd=" + odf.getIdOrdonnance()
            );
            if(!fonction.update_ordonnanceF(con, odf)){
                throw new Exception("Erreur lors de Update ODF "+odf.getId());
            } 
        }
    }

    con.commit();
    success = true;
    response.sendRedirect("ordonnances.jsp");

} catch (Exception e) {
    try { con.rollback(); } catch (Exception ex) { throw ex; }
    e.printStackTrace();
    String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
    response.sendRedirect("home.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
} finally {
    if (con != null) {
        try {
            con.setAutoCommit(true); 
            con.close();
        } catch (Exception ex) {
            throw ex;
        }
    }
}

%>