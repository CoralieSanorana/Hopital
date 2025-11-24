<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="stylesheet" href="assets/style.css">
  <title>Connexion</title>

</head>
<body>
  <div class="login-container">
    <h2>Connexion</h2>

    <%-- affichage des erreurs --%>
    <% if(request.getParameter("error") != null) { %>
      <p class="error">
        <% if("1".equals(request.getParameter("error"))) { %>
          User non trouvé : nom ou mot de passe incorrect !
        <% } else { %>
          <%= request.getParameter("error") %>
        <% } %>
      </p>
    <% } %>

    <form name="form1" method="post" action="form.jsp">
      <div class="input-group">
        <label for="nom">Nom</label>
        <input type="text" id="nom" name="nom" placeholder="Votre nom ..." required />
      </div>
      <div class="input-group">
        <label for="pwd">Mot de passe</label>
        <input type="password" id="pwd" name="pwd" placeholder="Votre mot de passe..." required />
      </div>
      <button type="submit" name="Submit" class="submit-btn">Se connecter</button>
    </form>
    <p class="footer-text">Heureux de vous recevoir dans notre Pharmacie!</p>
  </div>
</body>
</html>