<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    User user = (User) session.getAttribute("user_log");
    if (user == null) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }

    Function fonction = new Function();
    Vector<Ordonnance_complet> ordonnances_nonlivrer = new Vector<>();
    Vector<Ordonnance_complet> ordonnances_livrer = new Vector<>();

    try {
        ordonnances_nonlivrer = fonction.get_ordonnances_complet_nonLivrer();
        ordonnances_livrer = fonction.get_ordonnances_complet_Livrer();
    } catch (Exception e) {
        response.sendRedirect("login.jsp?error=" + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ordonnances</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>

<style>
    /* ======================
    🎨 Nouveau thème pro
    ====================== */
    :root {
        --primary: #2563eb;
        --primary-light: #3b82f6;
        --success: #10b981;
        --danger: #ef4444;
        --warning: #f59e0b;
        --gray-dark: #1e293b;
        --gray: #64748b;
        --light: #f1f5f9;
        --card-bg: #ffffff;
        --border: #e2e8f0;
    }

    body {
        background: #f8fafc;
        font-family: "Inter", sans-serif;
    }

    .section-title {
        font-size: 2rem;
        font-weight: 700;
        color: var(--gray-dark);
        margin-top: 45px;
        margin-bottom: 25px;
        text-align: center;
    }

    .card-ordonnance {
        background: var(--card-bg);
        border-radius: 16px;
        padding: 22px;
        box-shadow: 0px 8px 20px rgba(15, 23, 42, 0.08);
        border: 1px solid var(--border);
        transition: transform .2s ease, box-shadow .3s ease;
    }

    .card-ordonnance:hover {
        transform: translateY(-5px);
        box-shadow: 0px 18px 35px rgba(37, 99, 235, 0.18);
    }

    .card-header-pro {
        text-align: center;
        padding-bottom: 10px;
        margin-bottom: 10px;
        border-bottom: 2px solid var(--border);
        color: var(--primary);
        font-size: 1.3rem;
        font-weight: 700;
    }

    .card-ordonnance p {
        margin: 6px 0;
        color: var(--gray-dark);
    }

    .btn-livrer {
        background: var(--success);
        color: white;
        width: 100%;
        border-radius: 12px;
        padding: 12px;
        font-weight: 600;
        transition: .2s ease;
    }

    .btn-livrer:hover {
        background: #0f9d72;
    }

    /* Tableau style dashboard */
    .table-dashboard thead {
        background: var(--primary);
        color: #ffffff;
    }

    .table-dashboard th {
        padding: 12px;
        font-size: 0.95rem;
    }

    .table-dashboard td {
        padding: 12px;
        vertical-align: middle;
    }

    .btn-retour {
        background: var(--warning);
        color: white;
        font-weight: 600;
    }

    .btn-retour:hover {
        background: #d48806;
    }

    /* Message vide */
    .no-data {
        text-align: center;
        padding: 50px;
        color: var(--gray);
        font-size: 1.2rem;
    }

    .no-data i {
        font-size: 3.5rem;
        color: #cbd5e1;
        margin-bottom: 15px;
    }
</style>

<body>

<%@ include file="header.jsp" %>

<div class="container">

    <h2 class="section-title"><i class="bi bi-hourglass-split"></i> Ordonnances non livrées</h2>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">

        <% if(ordonnances_nonlivrer == null || ordonnances_nonlivrer.isEmpty()) { %>

            <div class="col-12">
                <div class="no-data">
                    <i class="bi bi-clipboard-x"></i>
                    <p>Aucune ordonnance non livrée</p>
                </div>
            </div>

        <% } else {
            for(Ordonnance_complet ordonnance : ordonnances_nonlivrer) { %>

                <div class="col">
                    <div class="card-ordonnance">
                        <div class="card-header-pro">
                            Ordonnance N° <%= ordonnance.getId() %>
                        </div>
                        <p><strong>Prescrit par le Docteur <%= ordonnance.getNomMedecin() %> 
                            <%= ordonnance.getPrenomMedecin() %> </strong>
                        </p>
                        <p><strong>Pour le Patient :</strong> <%= ordonnance.getNom() %></p>
                        <p><strong>Date :</strong> <%= ordonnance.getDaty() %></p>

                        <form action="livraison.jsp" method="post">
                            <input type="hidden" name="idordonnance" value="<%= ordonnance.getId() %>">
                            <button type="submit" class="btn btn-livrer mt-3">
                                <i class="bi bi-truck"></i> Livrer
                            </button>
                        </form>
                    </div>
                </div>

        <% } } %>

    </div>


    <h2 class="section-title"><i class="bi bi-check-circle"></i> Ordonnances déjà livrées</h2>

    <div class="row g-4">

    <% if(ordonnances_livrer == null || ordonnances_livrer.isEmpty()) { %>

        <div class="col-12">
            <div class="no-data">
                <i class="bi bi-clipboard-check"></i>
                <p>Aucune ordonnance livrée pour le moment</p>
            </div>
        </div>

    <% } else {
        for(Ordonnance_complet ordonnance : ordonnances_livrer) { %>

            <div class="col-12">
                <div class="card-ordonnance">

                    <div class="card-header-pro">Ordonnance N° <%= ordonnance.getId() %></div>

                    <p><strong>Prescrit par le Docteur <%= ordonnance.getNomMedecin() %> 
                        <%= ordonnance.getPrenomMedecin() %> </strong>
                    </p>
                    <p><strong>Pour le Patient :</strong> <%= ordonnance.getNom() %></p>
                    <p><strong>Date :</strong> <%= ordonnance.getDaty() %></p>

                    <!-- Tableau des médicaments -->
                    <div class="table-responsive mt-3">
                        <% Vector<MedOrdonnanceFille> ordonnanceFille = fonction.get_medordonnances_fille(ordonnance.getId()); %>

                        <table class="table table-dashboard table-hover">
                            <thead>
                                <tr>
                                    <th>Médicament</th>
                                    <th>Qté Livrée</th>
                                    <th>Qté à Retourner</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>

                            <% if(ordonnanceFille == null || ordonnanceFille.isEmpty()) { %>

                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <i class="bi bi-capsule-pill fs-2"></i><br>
                                        Aucun médicament
                                    </td>
                                </tr>

                            <% } else {
                                for(MedOrdonnanceFille odf : ordonnanceFille) {
                                    Medicament medoc = fonction.get_1medicament(odf.getIdMedicament());
                            %>

                                <tr>
                                    <td><strong><%= medoc.getLibelle() %></strong></td>
                                    <td><%= odf.getQuantite() %></td>

                                    <form action="retourner.jsp" method="post">
                                        <input type="hidden" name="idmedoc" value="<%= odf.getIdMedicament() %>">

                                        <td> 
                                            <select name="unite" id="">
                                                <% Unite u1 = fonction.get_1unite(medoc.getUnite()); %>
                                                <option value="<%= medoc.getUnite() %>"><%= u1.getVal() %></option>
                                                <% if(!medoc.getUnite().equals(odf.getUnite())) {%>
                                                 <% Unite u2 = fonction.get_1unite(odf.getUnite()); %>
                                                 <option value="<%= odf.getUnite() %>"><%= u2.getVal() %></option>
                                                <% } %>
                                            </select>
                                        </td>

                                        <td>
                                            <input type="number" name="quantite" min="0" max="<%= odf.getQuantite() %>" class="form-control">
                                        </td>

                                        <td>
                                            <button class="btn btn-retour">
                                                <i class="bi bi-arrow-return-left"></i> Retourner
                                            </button>
                                        </td>
                                    </form>
                                </tr>

                            <% } } %>

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

    <% } } %>

    </div>

</div>

</body>
</html>
