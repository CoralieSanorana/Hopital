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
    <title>Saisie d'ordonnance</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap 5 + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        :root {
            --primary: #2c7be5;
            --success: #00d97e;
            --danger: #e74c3c;
            --warning: #f6c31c;
            --dark: #1a2d4d;
            --light: #f8f9fa;
            --gray: #95aac9;
            --border: #e3ebf6;
            --shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            color: #2d3748;
        }

        .bienvenue {
            margin: 30px 0 10px;
            color: var(--dark);
            font-weight: 700;
            text-align: center;
            font-size: 2.4rem;
            text-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .subtitle {
            text-align: center;
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 40px;
            font-size: 1.4rem;
        }

        .card-form {
            background: white;
            border-radius: 18px;
            padding: 30px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 8px;
        }

        select, input[type="number"], input[type="text"] {
            border-radius: 10px !important;
            border: 1.5px solid #cbd5e0;
            padding: 10px 12px !important;
            transition: all 0.3s ease;
        }

        select:focus, input:focus {
            border-color: var(--primary) !important;
            box-shadow: 0 0 0 0.2rem rgba(44, 123, 229, 0.2) !important;
        }

        /* Tableau des médicaments */
        .table-medicaments {
            margin-top: 30px;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .table-medicaments th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            text-align: center;
            padding: 15px !important;
        }

        .table-medicaments td {
            vertical-align: middle;
            padding: 14px !important;
            text-align: center;
        }

        .table-medicaments tbody tr:hover {
            background-color: #f1f7ff;
        }

        .table-medicaments input[type="checkbox"] {
            transform: scale(1.4);
            cursor: pointer;
        }

        .table-medicaments input:disabled {
            background-color: #ecf0f1;
            color: #95a5a6;
        }

        /* Boutons */
        .btn-save {
            background: linear-gradient(135deg, var(--success), #00b06b);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 14px 40px;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(0, 217, 126, 0.3);
        }

        .btn-save:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0, 217, 126, 0.4);
            background: linear-gradient(135deg, #00e68a, #00b06b);
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

        /* Responsive */
        @media (max-width: 768px) {
            .bienvenue { font-size: 2rem; }
            .card-form { padding: 20px; }
            .table-medicaments { font-size: 0.9rem; }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-4">
        <h1 class="bienvenue">BIENVENUE <%= user.get_nom().toUpperCase() %> !</h1>
        <p class="subtitle">Saisie d'une nouvelle ordonnance</p>

        <% if(request.getParameter("error") != null) { %>
            <div class="error text-center">
                <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getParameter("error") %>
            </div>
        <% } %>

        <div class="card-form">
            <form name="form1" method="post" action="traitement.jsp">
                <div class="row g-4 mb-4">
                    <!-- Médecin -->
                    <div class="col-md-6">
                        <label class="form-label"><i class="bi bi-person-badge"></i> Médecin prescripteur</label>
                        <select name="medecin" class="form-select form-select-lg" required>
                            <option value="">Choisir un médecin</option>
                            <% if(medecins != null) { 
                                for(Medecin med : medecins) { %>
                                    <option value="<%= med.get_id() %>"><%= med.get_prenom() %> <%= med.get_nom() != null ? med.get_nom() : "" %></option>
                            <%  } } else { %>
                                <option value="">Aucun médecin trouvé</option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Patient -->
                    <div class="col-md-6">
                        <label class="form-label"><i class="bi bi-person-heart"></i> Patient</label>
                        <select name="patient" class="form-select form-select-lg" required>
                            <option value="">Choisir un patient</option>
                            <% if(clients != null) { 
                                for(Client client : clients) { %>
                                    <option value="<%= client.get_id() %>"><%= client.get_nom() %></option>
                            <%  } } else { %>
                                <option value="">Aucun patient trouvé</option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <!-- Tableau des médicaments -->
                <div class="table-responsive">
                    <table class="table table-medicaments">
                        <thead>
                            <tr>
                                <th>Médicament</th>
                                <th style="width: 100px;">Sélection</th>
                                <th style="width: 120px;">Quantité</th>
                                <th>Description / Posologie</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(medicaments == null || medicaments.isEmpty()) { %>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        <i class="bi bi-prescription2 fs-1"></i><br>
                                        Aucun médicament disponible
                                    </td>
                                </tr>
                            <% } else { 
                                int index = 0;
                                for(Medicament medicament : medicaments) { %>
                                    <tr>
                                        <td><strong><%= medicament.getLibelle() %></strong></td>
                                        <td>
                                            <input type="checkbox" name="selectedMedoc" value="<%= medicament.getId() %>"
                                                   onchange="toggleFields(this, <%= index %>)" class="form-check-input">
                                        </td>
                                        <td>
                                            <input type="number" name="quantite_<%= index %>" min="1" value="1" class="form-control" disabled>
                                        </td>
                                        <td>
                                            <input type="text" name="desc_<%= index %>" placeholder="Ex: 1 comprimé matin et soir..." 
                                                   class="form-control" disabled>
                                        </td>
                                    </tr>
                            <% index++; } } %>
                        </tbody>
                    </table>
                </div>

                <!-- Bouton sauvegarde -->
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-save px-5">
                        <i class="bi bi-check2-all"></i> Sauvegarder l'ordonnance
                    </button>
                </div>
            </form>
        </div>
    </div>

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
</body>
</html>