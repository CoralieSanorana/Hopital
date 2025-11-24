<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%
    try {
        Function fonction = new Function();
        String nom = request.getParameter("nom");
        String pwd = request.getParameter("pwd");

        if (nom == null || pwd == null) {
            response.sendRedirect("login.jsp?error=1");
            return;
        }

        nom = nom.trim();
        pwd = pwd.trim();

        User user_log = fonction.login(nom, pwd);

        if (user_log == null) {
            response.sendRedirect("login.jsp?error=1");
        } else {
            //HttpSession session = request.getSession(true);  
            session.setAttribute("user_log", user_log);      

            response.sendRedirect("home.jsp");
        }
    } catch (Exception e) {
        response.sendRedirect("login.jsp?error=" + e.getMessage());
    }
%>