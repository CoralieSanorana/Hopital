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
        if(ordonnanceFille == null){
            try { con.rollback(); } catch (SQLException ex) { throw ex; }
            response.sendRedirect("ordonnances.jsp?error=" + URLEncoder.encode("Vector Ordonnance fille VIDE", "UTF-8"));
            return;
        }
      // inserer ventes detaille
        for(MedOrdonnanceFille odf: ordonnanceFille){
          // prendre le medicament
            Medicament medoc = fonction.get_1medicament(odf.getIdMedicament(),con);
            double quantite = odf.getQuantite();
            double qte_total = 0.0;

          // prendre l'equivalence
            if(medoc.getUnite().equals(odf.getUnite())){
                qte_total = quantite;
            } else{
                Equivalence equi = fonction.get_equivalence(con,odf.getUnite());
                if(equi == null){
                    throw new Exception("Aucun equivalence ne correspond a l'unite choisi !!");
                }
                qte_total = equi.getQuantite() * quantite;
            }

            String idProduit = odf.getIdMedicament();
            double pu = odf.getPuUnite();
            double prix = odf.getPrix();
            String designation = medoc.getLibelle();  // nom medicament
            String idmedecin = ordonnance.getIdmedecin();
            String unite = odf.getUnite();
          // creer vente_details
            VenteDetails venteD = new VenteDetails(
                "id",
                idvente,
                idProduit,
                "idorigine",
                quantite,
                pu,
                0,0,0,0,
                "iddevise",0,
                designation,
                "compte",0,
                "idachat",0,
                idmedecin,
                unite,
                qte_total
            );
          //  appel de la fonction
            String idventeDetaille = fonction.set_vente_details(con,venteD);
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
            double sortie = vntD.getQte_total();
            double entree = 0.0;
            double pu = vntD.getPu();
            String idprod = vntD.getIdProduit();
            String designe = vntD.getDesignation();
            String unite2 = vntD.getUnite();
            double qte = vntD.getQte();
            double pv = qte * pu;

            MvtStockfille mvtF = new MvtStockfille(
                "id",idMVTstock,
                idprod,
                entree,sortie,
                vntD.getId(),
                "idtransfer",
                pu,"mvtsrc",
                0,designe,
                null,
                "dateperemption",
                "source",
                unite2,qte,pv
            );
            String idMVTstock_fille = fonction.set_MvtStockFille(con,mvtF) ;
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