<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="database.*"%>
<%@ page import="java.net.URLEncoder"%>

<% 
    String idordonnance = request.getParameter("idordonnance");
    Function fonction = new Function();
    Connection con = null;
    Med_Ordonnance ordonnance = null;
    try{
        con = VanialaConnection.getConnection();
        con.setAutoCommit(false);

        ordonnance = fonction.get_1ordonnance(idordonnance,con);
        if(ordonnance == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Ordonnance non trouver", "UTF-8"));
            return;
        }
        String idclient = ordonnance.getObservation_s();
        java.util.Date daty = ordonnance.getDaty();
    // inserer une vente
        String idvente = fonction.set_vente(con,idclient,daty);
        if(idvente == null){
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insertion de VENTE impossible", "UTF-8"));
            return;
        }
    // prendre les med_ordonnances_fille
        Vector<MedOrdonnanceFille> ordonnanceFille = fonction.get_medordonnances_fille(idordonnance,con);
        if(idvente == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Vector Ordonnance fille VIDE", "UTF-8"));
            return;
        }
    // inserer ventes detaille
        for(MedOrdonnanceFille odf: ordonnanceFille){
            String idProduit = odf.getIdMedicament();
            Medicament medoc = fonction.get_1medicament(idProduit,con);
            double quantite = odf.getQuantite();
            double prix = odf.getPuUnite();
            String designation = medoc.getLibelle();  // nom medoc
            String idmedecin = ordonnance.getIdmedecin();
        //  appel de la fonction
            String idventeDetaille = fonction.set_vente_details(con,idvente,idProduit,quantite,
            prix,designation,idmedecin);
            if(idventeDetaille == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insert vente detaille IMPOSSIBLE", "UTF-8"));
                return;
            }
        }

        Vente vente = fonction.getVenteById(idvente,con);
        if(vente == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Vente Vide", "UTF-8"));
            return;
        }
    // inserer MVT Stock
        java.util.Date datyPrevu = vente.getDatyPrevu();
        String idMVTstock = fonction.set_MvtStock(con,idvente,datyPrevu);
        if(idMVTstock == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insert MVT Stock IMPOSSIBLE", "UTF-8"));
            return;
        }
    
    // inserer MVT Stock fille
        
        Vector<VenteDetails> venteDetails = fonction.get_VenteDetails(con,idvente);
        if(venteDetails == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Vente Detaille Vide", "UTF-8"));
            return;
        }
        for(VenteDetails vntD: venteDetails){
            double sortie = vntD.getQte();
            double entree = 0.0;
            double pu = vntD.getPu();
            String idprod = vntD.getIdProduit();
            String designe = vntD.getDesignation();
            String idMVTstock_fille = fonction.set_MvtStockFille(con,idMVTstock,idprod,entree,sortie,designe,pu) ;
            if(idMVTstock_fille == null){
                try { con.rollback(); } catch (SQLException ex) { throw ex; }
                response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Insert MVT Stock Fille IMPOSSIBLE", "UTF-8"));
                return;
            }
        }
    // update date_fin de ordonnance
        if(fonction.update_datefin_ordonnance(idordonnance,datyPrevu,con)){
        // diriger vers stock.jsp
            con.commit();
            response.sendRedirect("Stock.jsp?idmvt="+idMVTstock);
            return;
        } else{
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("UPDATE Date Fin Ordonnance IMPOSSIBLE", "UTF-8"));
            return;
        }

    } catch(Exception e){
        try { con.rollback(); } catch (SQLException ex) { throw ex; }
        e.printStackTrace();
        String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
        response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
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