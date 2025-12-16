<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="database.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
Connection con = null;
Function fonction = new Function();
boolean success = false;

String code = request.getParameter("code");
String idOdF = request.getParameter("idOdF");
String id_ordonnance = request.getParameter("id_ordonnance");

if (code == null || code.trim().isEmpty()) {
    response.sendRedirect("facture.jsp?id_ordonnance=" + 
        (id_ordonnance != null ? id_ordonnance : "") + 
        "&error=" + URLEncoder.encode("Aucun code donné", "UTF-8"));
    return;
}

if (idOdF == null || idOdF.trim().isEmpty()) {
    response.sendRedirect("facture.jsp?id_ordonnance=" + 
        (id_ordonnance != null ? id_ordonnance : "") + 
        "&error=" + URLEncoder.encode("Aucune ordonnance fille sélectionnée", "UTF-8"));
    return;
}

if (id_ordonnance == null || id_ordonnance.trim().isEmpty()) {
    response.sendRedirect("facture.jsp?error=" + URLEncoder.encode("Aucune ordonnance sélectionnée", "UTF-8"));
    return;
}

try {
    con = VanialaConnection.getConnection();
    con.setAutoCommit(false);

    if ("1".equals(code)) {  // delete
        success = fonction.delete_ordonnanceF(con,idOdF);
        if(success){
            con.commit();
            response.sendRedirect("facture.jsp?id_ordonnance="+id_ordonnance);        
        } else{
            con.rollback();
            response.sendRedirect("facture.jsp?id_ordonnance="+id_ordonnance+"&error=Delete Non effectuer");          
        }

    } else if ("2".equals(code)) {  // update
        String quantiteStr = request.getParameter("quantite");
        if (quantiteStr == null || quantiteStr.trim().isEmpty()) {
            response.sendRedirect("facture.jsp?id_ordonnance="+id_ordonnance+"&error=" + 
                URLEncoder.encode("Quantité manquante", "UTF-8"));
            return;
        }
        int quantite = Integer.parseInt(quantiteStr);
        String unite = request.getParameter("unite");
        
        Unite u1 = fonction.get_1unite(unite);
        double pu = 0;

        String medocUnite = request.getParameter("medocUnite");
        double medocPu = Double.parseDouble(request.getParameter("medocPu"));
        
        /*
        out.println("Code "+code);
        out.println("Id OD "+id_ordonnance);
        out.println("Id ODF "+idOdF);
        out.println("Quantite "+quantite);
        out.println("Unite "+unite);
        out.println("odfUnite" +odfUnite);
        out.println("odfPu " +odfPu);
        out.println("medocUnite " +medocUnite);
        out.println("medocPu " +medocPu);
        */

        if(unite.equals(medocUnite)){
            pu = medocPu;
        } else{
            Equivalence eq = fonction.get_equivalence(unite);
            if(eq == null){
                con.rollback();
                response.sendRedirect("facture.jsp?id_ordonnance="+id_ordonnance+"&error=Equivalence non trouver pour unite "+unite);          
            }
            pu = eq.getPv();                            
        }
        
        double prix = pu * quantite;

        MedOrdonnanceFille odf = new MedOrdonnanceFille();
        odf.setId(idOdF);
        odf.setIdOrdonnance(id_ordonnance);
        odf.setQuantite(quantite);
        odf.setUnite(unite);
        odf.setPuUnite(pu);
        odf.setPrix(prix);

        success = fonction.update_ordonnanceF(con,odf);
        if(success){
            con.commit();
            response.sendRedirect("facture.jsp?id_ordonnance="+id_ordonnance);        
        } else{
            con.rollback();
            response.sendRedirect("facture.jsp?id_ordonnance="+id_ordonnance+"&error=Delete Non effectuer");          
        } 
    }
} catch (Exception e) {
    try { con.rollback(); } catch (Exception ex) { throw ex; }
    e.printStackTrace();
    String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
    response.sendRedirect("facture.jsp?id_ordonnance="+id_ordonnance+"&error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
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