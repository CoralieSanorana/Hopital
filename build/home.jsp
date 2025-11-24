<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    User user = (User) session.getAttribute("user_log");
    if (user == null) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }
    Vector<Client> clients = new Vector<>();
    Vector<Medecin> medecins = new Vector<>();
    Vector<Medicament> medicaments = new Vector<>();

    try{
        Function fonction = new Function();
        clients = fonction.get_clients();
        medecins = fonction.get_medecins();
        medicaments = fonction.get_medicaments();
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
            <h1 class="bienvenue">BIENVENUE <%= user.get_nom().toUpperCase() %> !</h1>
            <p>Vous êtes connecté avec succes dans l'application Pharmacie</p>
        </div>
        <% if(request.getParameter("error") != null) { %>
            <p class="error">
                <%= request.getParameter("error") %>
            </p>
        <% } %>
        <div class="row">
            <form name="form1" method="post" action="traitement.jsp">
            <%-- quel docteur --%>
                <div class="input-group">
                    <p><label for="medecin">Medecin   </label></p>
                    <p>
                        <select name="medecin" id="" required>
                            <% if(medecins == null){ %>
                                <option value="">Aucun Medecin touver</option>
                            <% }else{ %>
                                <option value="">Choisir un Medecin</option>
                                <% for(Medecin med: medecins){ %>
                                    <option value="<%= med.get_id() %>"><%= med.get_prenom() %></option>
                                <% } %>
                            <% } %>
                        </select>
                    </p>
                </div>
            <%-- quel patient --%>
                <div class="input-group">
                    <p><label for="patient">Patient   </label> </p>
                    <p>
                        <select name="patient" id="" required>
                            <% if(clients == null){ %>
                                <option value="">Aucun Client touver</option>
                            <% }else{ %>
                                <option value="">Choisir un Client</option>
                                <% for(Client client: clients){ %>
                                    <option value="<%= client.get_id() %>"><%= client.get_nom() %></option>
                                <% } %>
                            <% } %>
                        </select>
                    </p>
                </div>
            <%-- bouton pour suver --%>
                <div class="input-group">
                    <p><input type="submit" value="Sauver l'ordonnance"></p>
                </div>
            <%-- les medicaments --%>
                <div class="input-group">
                    <p>
                        <table border="1">
                            <tr>
                                <th>Medicaments</th>
                                <th>Valider</th>
                                <th>Quantite</th>
                                <th>Description</th>
                            </tr>
                            <% if(medicaments == null){ %>
                                <p>Aucun Medicament trouvé</p>
                            <% } else { 
                                int index = 0;
                                for(Medicament medicament : medicaments) { %>
                                    <tr>
                                        <td><%= medicament.getLibelle() %></td>
                                        <td>
                                            <input type="checkbox" 
                                                name="selectedMedoc" 
                                                value="<%= medicament.getId() %>" 
                                                onchange="toggleFields(this, <%= index %>)">
                                        </td>
                                        <td>
                                            <input type="number" 
                                                name="quantite_<%= index %>" 
                                                min="1" 
                                                value="1" 
                                                disabled>
                                        </td>
                                        <td>
                                            <input type="text" 
                                                name="desc_<%= index %>" 
                                                placeholder="Posologie..." 
                                                disabled>
                                        </td>
                                    </tr>
                                    <% index++; 
                                } %>
                            <% } %>
                        </table>
                    </p>
                </div>

            </form>
        </div>



    </div>

</body>
<script>
function toggleFields(checkbox, index) {
    const quantite = document.getElementsByName("quantite_" + index)[0];
    const desc = document.getElementsByName("desc_" + index)[0];
    
    if (checkbox.checked) {
        quantite.disabled = false;
        desc.disabled = false;
    } else {
        quantite.disabled = true;
        desc.disabled = true;
        quantite.value = '';
        desc.value = '';
    }
}
</script>
</html>