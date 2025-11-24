<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // détruit complètement la session
    response.sendRedirect("login.jsp");
%>