<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    User user = (User) session.getAttribute("user_log");
    if (user == null) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }
    String id_ordonnance = request.getParameter("id_ordonnance");
    if(id_ordonnance == null){
        response.sendRedirect("ordonnance.jsp?error=Aucune id_ordonnance recue");
    }
    Ordonnance_complet ordonnance = null;
    Function fonction = new Function();
    Vector<MedOrdonnanceFille> ordonnanceFilles = new Vector<>();
    double total = 0;
    Vector<Unite> unites = new Vector<>();

    try {
        ordonnance = fonction.get_1ordonnance_complet(id_ordonnance);
        unites = fonction.get_as_unite_v();
        if(ordonnance == null){
            response.sendRedirect("ordonnance.jsp?error=Erreur lors du chargement de L'Ordonnances "+id_ordonnance);
        }
        ordonnanceFilles = fonction.get_medordonnances_fille(id_ordonnance);
    } catch (Exception e) {
        response.sendRedirect("home.jsp?error=" + e.getMessage());
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
    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        min-height: 100vh;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Message d'erreur */
        .error {
            background: #ffeaea;
            color: var(--danger);
            padding: 16px 20px;
            border-radius: 12px;
            border-left: 6px solid var(--danger);
            margin: 20px 0;
            font-weight: 500;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.1);
        }
    .container {
        margin-top: 30px;
        margin-bottom: 50px;
    }

    /* Titre principal */
    .section-title {
        color: #2c3e50;
        font-weight: 700;
        font-size: 2.2rem;
        margin-bottom: 1.5rem;
        text-align: center;
        position: relative;
    }

    .section-title i {
        color: #3498db;
        margin-right: 12px;
    }

    .section-title::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 4px;
        background: #3498db;
        border-radius: 2px;
    }

    /* Infos ordonnance */
    p {
        background: white;
        padding: 14px 20px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.06);
        margin-bottom: 15px;
        font-size: 1.05rem;
        border-left: 5px solid #3498db;
    }

    p strong {
        color: #2c3e50;
    }

    /* Bouton Livrer */
    .btn-livrer {
        background: linear-gradient(135deg, #27ae60, #2ecc71);
        color: white;
        border: none;
        padding: 12px 30px;
        font-size: 1.1rem;
        font-weight: 600;
        border-radius: 50px;
        box-shadow: 0 6px 20px rgba(46, 204, 113, 0.3);
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
    }

    .btn-livrer:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(46, 204, 113, 0.4);
        background: linear-gradient(135deg, #2ecc71, #27ae60);
    }

    .btn-livrer i {
        font-size: 1.4rem;
    }

    /* Tableau */
    .table-dashboard {
        background: white;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        margin-top: 30px;
    }

    .table-dashboard thead {
        background: linear-gradient(135deg, #3498db, #2980b9);
        color: white;
        text-transform: uppercase;
        font-size: 0.9rem;
        letter-spacing: 0.5px;
    }

    .table-dashboard thead th {
        padding: 18px 15px;
        font-weight: 600;
    }

    .table-dashboard tbody tr {
        transition: all 0.2s ease;
    }

    .table-dashboard tbody tr:hover {
        background-color: #f8f9fa;
        transform: scale(1.01);
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }

    .table-dashboard td {
        padding: 18px 15px;
        vertical-align: middle;
        font-size: 1.05rem;
    }

    .table-dashboard td strong {
        color: #2c3e50;
        font-size: 1.1rem;
    }

    /* Ligne "Aucun médicament" */
    .text-muted i {
        color: #95a5a6;
        opacity: 0.6;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .section-title {
            font-size: 1.8rem;
        }
        
        .btn-livrer {
            width: 100%;
            justify-content: center;
        }
        
        .table-responsive {
            border-radius: 12px;
        }
    }

    /* Petite animation au chargement */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .container > * {
        animation: fadeInUp 0.6s ease-out;
    }
</style>
<body>

<%@ include file="header.jsp" %>

<div class="container">
    <% if(request.getParameter("error") != null) { %>
        <div class="error text-center">
            <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getParameter("error") %>
        </div>
    <% } %>
    <h2 class="section-title"><i class="bi bi-hourglass-split"></i> Ordonnances N°<%= id_ordonnance %></h2>
    <p>Prescrit par le Docteur <strong><%= ordonnance.getNomMedecin() %> 
        <%= ordonnance.getPrenomMedecin() %> </strong>
    </p>
    <p><strong>Pour le Patient :</strong> <%= ordonnance.getNom() %></p>
    <p><strong>Date :</strong> <%= ordonnance.getDaty() %></p>
    
    <%-- form de livraison --%>
    <form action="livraison.jsp" method="post">
        <input type="hidden" name="idordonnance" value="<%= ordonnance.getId() %>">
        <button type="submit" class="btn btn-livrer mt-3">
            <i class="bi bi-truck"></i> Livrer
        </button>
    </form>
    
    <!-- Tableau des médicaments -->
    <div class="table-responsive mt-3">
        <table class="table table-dashboard table-hover">
            <thead>
                <tr>
                    <th>Médicament</th>
                    <th>Qté</th>
                    <th>Unité</th>
                    <th>Prix Unitaire</th>
                    <th>Prix Total</th>
                    <th>Annulation</th>
                </tr>
            </thead>
            <tbody>

            <% if(ordonnanceFilles == null || ordonnanceFilles.isEmpty()) { %>

                <tr>
                    <td colspan="4" class="text-center text-muted py-4">
                        <i class="bi bi-capsule-pill fs-2"></i><br>
                                        Aucun médicament
                    </td>
                </tr>

            <% } else {
                for(MedOrdonnanceFille odf : ordonnanceFilles) {
                Medicament medoc = fonction.get_1medicament(odf.getIdMedicament());
                total += odf.getPrix();
            %>
                <form action="traite_delete.jsp" method="post">
                    <tr>
                        <td><strong><%= medoc.getLibelle() %></strong></td>
                        <td>
                            <input type="number" name="quantite" min="0" value="<%= odf.getQuantite() %>">
                        </td>
                        <td>
                            <% Unite u1 = fonction.get_1unite(odf.getUnite());%>
                            <select name="unite" >
                                <% if(!medoc.getUnite().equals(odf.getUnite())) {%>
                                    <option value="<%= u1.getId() %>"><%= u1.getVal() %></option>
                                <% } %>
                                <option value="<%= medoc.getUnite() %>">unite</option>
                                <% if(unites == null) {%>
                                    <p>Aucun Unite trouver</p>
                                <%} else{ 
                                    for(Unite unite: unites) { 
                                        if(!unite.getVal().equals("unite")) {
                                            if(!unite.getId().equals(u1.getId())) {%>
                                            <option value="<%= unite.getId() %>"><%= unite.getVal() %></option>
                                        <% } 
                                        }
                                    }
                                } %>
                            </select>
                        </td>
                        <td><%= odf.getPuUnite() %></td>
                        <td><%= odf.getPrix() %></td>
                        <td> <button>
                            <a href="traite_delete.jsp?code=1&idOdF=<%= odf.getId() %>&id_ordonnance=<%= id_ordonnance %>">
                            Annuler</a></button> 
                        </td>
                        
                        <td>
                            <input type="hidden" value="2" name="code">
                            <input type="hidden" value="<%= id_ordonnance %>" name="id_ordonnance">
                            <input type="hidden" value="<%= odf.getId() %>" name="idOdF">

                            <input type="hidden" value="<%= medoc.getUnite() %>" name="medocUnite">
                            <input type="hidden" value="<%= medoc.getPv() %>" name="medocPu">

                            <input type="submit" value="Modifier">
                        </td>
                    </tr>
                </form>
            <% } 
            } %>
            <tr>
                <td>Prix Total</td>
                <td></td>
                <td></td>
                <td></td>
                <td><%= total %></td>
            </tr>


            </tbody>
        </table>
    </div>

</div>

</body>
</html>