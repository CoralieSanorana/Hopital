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
Vector<Unite> L-unite = new Vector<>();

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
        return;
    }

    L_unite = fonction.get_as_unite_v(con);

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

        int quantite = 1;
        if (quantiteStr != null && !quantiteStr.trim().isEmpty()) {
            try {
                quantite = Integer.parseInt(quantiteStr.trim());
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
            return;
        }
        double pu = 0.0;
        if(medoc.getUnite().equals(unite_choisi)){
            pu = medoc.getPv();
        } else{
            
        }
        double prixTotal = quantite * medoc.getPv();
        String unite_inserer = "";

        String idLigne = idOrdonnance + "-" + String.format("%03d", compteurLigne++);
        MedOrdonnanceFille ligne = new MedOrdonnanceFille(
            idMedoc,                   
            posologie,                 
            idOrdonnance,              
            idLigne,                   
            11,                       
            "",                       
            prixTotal,                
            "",                        
            quantite,                   
            unite_inserer,         
            "",                         
            pu,                        
            quantite,                  
            0.0                      
        );

        fonction.insert_ordonnance_fille(ligne, con);
    }
    con.commit();
    success = true;
    response.sendRedirect("ordonnances.jsp");

} catch (Exception e) {
    try { con.rollback(); } catch (SQLException ex) { throw ex; }
    e.printStackTrace();
    String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
    response.sendRedirect("home.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
} finally {
    if (con != null) {
        try {
            con.setAutoCommit(true); 
            con.close();
        } catch (SQLException ex) {
            throw ex;
        }
    }
}

%>