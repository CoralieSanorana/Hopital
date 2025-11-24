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
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Navbar</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ordonnances.jsp">Ordonnances</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Dropdown
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Action</a></li>
                            <li><a class="dropdown-item" href="#">Another action</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                    <a href="logout.jsp" class="nav-link ">Se deconnecter</a>
                    </li>
                </ul>
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
<body>
    <div class="container">
        <div class="row text-center">
            <h1 class="bienvenue">TOUS LES ORDONNANCES</h1>
        </div>
        <div class="row">
            <% if(ordonnances == null ) {%>
                <p><h4>Aucune Ordonnance Trouver </h4></p>
            <% } else{ 
                for(Med_Ordonnance ordonnance: ordonnances) {%>
                <div class="col-sm-3">
                    <p><h4 class="text-center">Ordonnance <%= ordonnance.getId() %></h4></p>
                    <p>Patient <%= ordonnance.getObservation_s() %></p>
                    <p>Date <%= ordonnance.getDaty() %></p>
                    <form action="" method="post">
                        <input type="hidden" name="">
                        <input type="submit" value="Livrer">
                    </form>
                </div>
            <% } }%>
        </div>
    </div>

</body>
</html>