<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    User user = (User) session.getAttribute("user_log");
    if (user == null) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }
    Vector<Med_Ordonnance> ordonnances = new Vector<>();
    
    try{
        Function fonction = new Function();
        ordonnances = fonction.get_ordonnances_nonLivrer();
    }catch (Exception e) {
        response.sendRedirect("login.jsp?error=" + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ordonnances</title>
    <link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap.min.css">
</head>
<style>
    :root {
        --primary: #2c7be5;      /* bleu professionnel */
        --success: #00d97e;      /* vert livraison */
        --danger: #e74c3c;
        --warning: #f6c31c;
        --dark: #1a2d4d;
        --light: #f8f9fa;
        --gray: #95aac9;
        --border: #e3ebf6;
    }

    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
        color: #2d3748;
    }

    .bienvenue {
        margin: 30px 0 40px;
        color: var(--dark);
        font-weight: 600;
        text-align: center;
        font-size: 2.2rem;
        text-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    /* Carte ordonnance */
    .ordonnance-card {
        background: white;
        border-radius: 16px;
        padding: 20px;
        margin-bottom: 25px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        border: 1px solid var(--border);
        transition: all 0.3s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .ordonnance-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 15px 35px rgba(44, 123, 229, 0.15);
        border-color: var(--primary);
    }

    .ordonnance-card h4 {
        color: var(--primary);
        font-weight: 700;
        margin-bottom: 15px;
        font-size: 1.35rem;
        text-align: center;
        border-bottom: 2px solid #e3ebf6;
        padding-bottom: 10px;
    }

    .ordonnance-card p {
        margin: 10px 0;
        color: #4a5568;
        font-size: 1rem;
    }

    .ordonnance-card p strong {
        color: var(--dark);
    }

    /* Bouton Livrer */
    .btn-livrer {
        margin-top: auto;
        padding-top: 12px;
        background: linear-gradient(135deg, var(--success), #00b06b);
        color: white;
        border: none;
        border-radius: 10px;
        padding: 12px 20px;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
    }

    .btn-livrer:hover {
        background: linear-gradient(135deg, #00e68a, #00b06b);
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0, 217, 126, 0.3);
    }

    /* Message d'erreur */
    .error {
        background: #ffeaea;
        color: var(--danger);
        padding: 15px 20px;
        border-radius: 10px;
        border-left: 5px solid var(--danger);
        margin: 20px 0;
        font-weight: 500;
        box-shadow: 0 4px 15px rgba(231, 76, 60, 0.1);
    }

    /* Quand il n'y a pas d'ordonnance */
    .no-data {
        text-align: center;
        padding: 60px 20px;
        color: var(--gray);
        font-size: 1.3rem;
    }

    .no-data i {
        font-size: 4rem;
        color: #cbd5e0;
        margin-bottom: 20px;
        display: block;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .bienvenue {
            font-size: 1.8rem;
        }
        .ordonnance-card {
            padding: 18px;
        }
    }
</style>
<body>
<%@ include file="header.jsp" %>

    <div class="container">
        <div class="row text-center">
            <h1 class="bienvenue">TOUS LES ORDONNANCES NON LIVRER</h1>
        </div>
        <% if(request.getParameter("error") != null) { %>
            <p class="error">
                <%= request.getParameter("error") %>
            </p>
        <% } %>
        <%-- <div class="row">
            <% if(ordonnances == null ) {%>
                <p><h4>Aucune Ordonnance Trouver </h4></p>
            <% } else{ 
                for(Med_Ordonnance ordonnance: ordonnances) {%>
                <div class="col-sm-3">
                    <p><h4 class="text-center">Ordonnance <%= ordonnance.getId() %></h4></p>
                    <p>Patient <%= ordonnance.getObservation_s() %></p>
                    <p>Date <%= ordonnance.getDaty() %></p>
                    <form action="livraison.jsp" method="post">
                        <input type="hidden" name="idordonnance" value="<%= ordonnance.getId() %>">
                        <input type="submit" value="Livrer">
                    </form>
                </div>
            <% } }%>
        </div> --%>
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4 mt-3">
            <% if(ordonnances == null || ordonnances.isEmpty()) { %>
                <div class="col-12">
                    <div class="no-data">
                        <i class="bi bi-file-earmark-x"></i>
                        <h4>Aucune ordonnance non livrée pour le moment</h4>
                        <p>Toutes les ordonnances ont été livrées.</p>
                    </div>
                </div>
            <% } else { 
                for(Med_Ordonnance ordonnance : ordonnances) { %>
                    <div class="col">
                        <div class="ordonnance-card">
                            <h4>Ordonnance N°<%= ordonnance.getId() %></h4>
                            <p><strong>Patient :</strong> <%= ordonnance.getObservation_s() != null ? ordonnance.getObservation_s() : "Non spécifié" %></p>
                            <p><strong>Date :</strong> <%= ordonnance.getDaty() %></p>
                            
                            <form action="livraison.jsp" method="post" style="margin-top: 20px;">
                                <input type="hidden" name="idordonnance" value="<%= ordonnance.getId() %>">
                                <button type="submit" class="btn-livrer">
                                    Livrer l'ordonnance
                                </button>
                            </form>
                        </div>
                    </div>
                <% } 
            } %>
        </div>
    </div>

</body>
</html>