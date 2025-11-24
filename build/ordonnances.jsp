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
        ordonnances = fonction.get_medordonnances();
    }catch (Exception e) {
        response.sendRedirect("login.jsp?error=" + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap.min.css">
</head>
    <style>
    .error{
        color:#e74c3c;
        font-size:14px;
        margin-top:15px;
        font-weight:500;}
    </style>
<body>
<%@ include file="header.jsp" %>

    <div class="container">
        <div class="row text-center">
            <h1 class="bienvenue">TOUS LES ORDONNANCES</h1>
        </div>
        <% if(request.getParameter("error") != null) { %>
            <p class="error">
                <%= request.getParameter("error") %>
            </p>
        <% } %>
        <div class="row">
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
        </div>
    </div>

</body>
</html>