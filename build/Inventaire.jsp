<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.net.URLEncoder"%>

<%
    User user = (User) session.getAttribute("user_log");
    if (user == null) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }
    Inventaire inv = null;
    Vector<InventaireFille_ING> invf_ING = new Vector<>();
    try {
        Function fonction = new Function();
        /*if(request.getParameter("date") != null){
            String dateString = request.getParameter("date");
            if (dateString == null || dateString.isEmpty()) {
                response.sendRedirect("Inventaire.jsp?error=" + URLEncoder.encode("Aucune Date selectionner", "UTF-8"));
                return;
            }
            java.util.Date date = null;
            try{
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
                date = sdf.parse(dateString);
            }catch(Exception e){
                String msg = e.getMessage() != null ? e.getMessage() : "Erreur inconnue";
                response.sendRedirect("Inventaire.jsp?error=" + URLEncoder.encode("Erreur : " + msg, "UTF-8"));
                    return;
            }
            inv = fonction.getInventaireByDate(date);
            invf_ING = fonction.get_inventairefille_ing(inv.getId());

        } else{*/
            inv = fonction.getInventaire_recent();
            invf_ING = fonction.get_inventairefille_ing(inv.getId());
        //}
    } catch (Exception e) {
        response.sendRedirect("home.jsp?error=" + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Arretage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
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
        <h1 class="bienvenue">Arretage</h1>

        <% if(request.getParameter("error") != null) { %>
            <div class="error text-center">
                <i class="bi bi-exclamation-triangle-fill"></i> <%= request.getParameter("error") %>
            </div>
        <% } %>

        <div class="card-form">
            <form name="form1" method="post" action="Inventaire.jsp">
                <div class="row g-4 mb-4">
                <!-- Date -->
                    <div class="col-md-6">
                        <label class="form-label"><i class="bi bi-person-badge"></i> Date d'Arretage</label>
                        <input type="date" name="date" id="" required>
                    </div>
                <!-- Bouton sauvegarde -->
                    <div class="col-md-6">
                        <button type="submit" class="btn btn-save px-5">
                            <i class="bi bi-check2-all"></i> Rechercher
                        </button>
                    </div>
                </div>
            </form>

                <!-- Tableau des médicaments -->
                <div class="table-responsive">
                    <table class="table table-medicaments">
                        <thead>
                            <tr>
                                <th>Id Inventaire</th>
                                <th>Produit</th>
                                <th>Explication</th>
                                <th>Date</th>
                                <th>Quantité Logiciel</th>
                                <th>Quantité reelle</th>
                                <th>Magasin</th>
                                <th>Etat</th>
                                <th>Jauge</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(invf_ING == null || invf_ING.isEmpty()) { %>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        <i class="bi bi-prescription2 fs-1"></i><br>
                                        Aucun Inventaire disponible
                                    </td>
                                </tr>
                            <% } else { 
                                for(InventaireFille_ING invf : invf_ING) { %>
                                    <tr>
                                        <td><%= invf.getIdInventaire() %></td>
                                        <td><%= invf.getIdProduitLib() %></td>
                                        <td><%= invf.getExplication() %></td>
                                        <td><%= invf.getDaty() %></td>
                                        <td><%= invf.getQuantite_theorique() %></td>
                                        <td><%= invf.getQuantite() %></td>
                                        <td><%= invf.getIdmagasin() %></td>
                                        <td><%= invf.getEtat() %></td>
                                        <td><%= invf.getIdjauge() %></td>
                                    </tr>
                                <% } %>
                            <% } %>
                        </tbody>
                    </table>
                </div>
        </div>
    </div>
</body>
</html>