<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    User user = (User) session.getAttribute("user_log");
    if (user == null) {
        response.sendRedirect("../login.jsp?error=1");
        return;
    }

    Vector<EtatsStock> etats = new Vector<>();
    try {
        Function fonction = new Function();
        etats = fonction.get_EtatStock();
    } catch (Exception e) {
        response.sendRedirect("../login.jsp?error=" + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>État du Stock</title>

    <link rel="stylesheet" type="text/css" href="../assets/bootstrap/css/bootstrap.min.css">

    <style>
        body {
            background-color: #eef2f7;
            font-family: "Segoe UI", sans-serif;
        }

        .card-custom {
            background: #ffffff;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
            width: 100%;
        }

        .title-text {
            color: #003366;
            font-weight: bold;
            margin-bottom: 20px;
        }

        /* --- TABLE & COLONNES --- */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100% !important;
            table-layout: fixed;
        }
th, td {
    white-space: normal;      /* Permet le retour à la ligne */
    word-wrap: break-word;    /* Coupe et renvoie à la ligne */
    font-size: 13px;
}


        .table thead th {
            position: sticky;
            top: 0;
            background: #003366 !important;
            color: #ffffff;
            z-index: 10;
            font-size: 13px;
        }

        table tbody tr:nth-child(even) {
            background-color: #f7faff;
        }

        table tbody tr:hover {
            background-color: #e3ecff !important;
        }

        /* --- COULEURS PERSONNALISÉES --- */
        #entry { color: #005fb8; font-weight: bold; }      /* Entrée */
        #exit  { color: #c21e1e; font-weight: bold; }      /* Sortie */
        #reste { color: #6a1b9a; font-weight: bold; }      /* Reste */
        #price { color: #0a7c2f; font-weight: bold; }      /* Prix */
    </style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="container-fluid mt-4">   <!-- FULL WIDTH -->
    <div class="row justify-content-center">
        <div class="col-12 card-custom">

            <h3 class="title-text">📦 État du Stock (montants)</h3>

            <% if (etats == null || etats.size() == 0) { %>

                <p class="text-muted">Aucun état de stock trouvé.</p>

            <% } else { %>

                <div class="table-responsive">
                    <table class="table table-hover table-bordered">
                        <thead>
                        <tr>
                            <th>Produit</th>
                            <th>Catégorie</th>
                            <th>Magasin</th>
                            <th>Dernier Mouvement</th>
                            <th>Entrée</th>
                            <th>Sortie</th>
                            <th>Reste</th>
                            <th>Montant Entrée</th>
                            <th>Montant Sortie</th>
                            <th>Montant Reste</th>
                            <th>PU Vente</th>
                        </tr>
                        </thead>

                        <tbody>
                        <% for (EtatsStock s : etats) { %>
                            <tr>
                                <td><%= s.getIdProduitLib() %></td>
                                <td><%= s.getCategorieIngredient() %></td>
                                <td><%= s.getIdMagasin() %></td>
                                <td><%= s.getDateDernierMouvement() %></td>
                                <td id="entry"><%= s.getEntree() %></td>
                                <td id="exit"><%= s.getSortie() %></td>
                                <td id="reste"><%= s.getReste() %></td>
                                <td id="price"><%= s.getMontantEntree() %></td>
                                <td id="price"><%= s.getMontantSortie() %></td>
                                <td id="price"><%= s.getMontantReste() %></td>
                                <td id="price"><%= s.getPuVente() %></td>
                            </tr>
                        <% } %>
                        </tbody>

                    </table>
                </div>

            <% } %>

        </div>
    </div>
</div>

</body>
</html>
