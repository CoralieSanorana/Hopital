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

String dateString = request.getParameter("date");
if (dateString == null || dateString.isEmpty()) {
        response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Aucune Date selectionner", "UTF-8"));
        return;
    }

java.util.Date date = null;
try{
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
    date = sdf.parse(dateString);
}catch(Exception e){
    String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
    response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
        return;
}
String[] selectedMedocIds = request.getParameterValues("selectedMedoc");

try {
    con = VanialaConnection.getConnection();
    con.setAutoCommit(false);

    if (selectedMedocIds == null || selectedMedocIds.length == 0) {
        response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Aucun médicament sélectionné", "UTF-8"));
        return;
    }
    Vector<Medicament> medicaments = fonction.get_medicaments(con);
    int prochainNumero = medicaments.size() + 1;

    // inserer MVT Stock
        String idMVTstock = fonction.set_MvtStock(con,"",date);
        if(idMVTstock == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Insert MVT Stock IMPOSSIBLE", "UTF-8"));
            return;
        }

    for(String idmedoc : selectedMedocIds){
        Medicament medoc = null;
        int indice = 0;
        for(int i = 0;  i < medicaments.size(); i++){
            if(medicaments.get(i).getId().equals(idmedoc)){
                medoc = medicaments.get(i);
                indice = i;
                break;
            }
        }

        String quantiteStr = request.getParameter("quantite_" + indice);
        int quantite = 1;
        if (quantiteStr != null && !quantiteStr.trim().isEmpty()) {
            try {
                quantite = Integer.parseInt(quantiteStr.trim());
                if (quantite <= 0) quantite = 1;
            } catch (NumberFormatException e) {
                quantite = 1;
            }
        }

        // inserer MVT Stock fille
            double entree = quantite;
            double sortie = 0.0;
            double pu = medoc.getPv();
            String idprod = medoc.getId();
            String designe = medoc.getLibelle();
            String idMVTstock_fille = fonction.set_MvtStockFille(con,idMVTstock,idprod,entree,sortie,designe,pu) ;
            if(idMVTstock_fille == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille IMPOSSIBLE", "UTF-8"));
                return;
            }
    }
    
    con.commit();
    success = true;
    response.sendRedirect("Stock.jsp");

} catch (Exception e) {
    try { con.rollback(); } catch (SQLException ex) { throw ex; }
    e.printStackTrace();
    String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
    response.sendRedirect("Entree.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
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