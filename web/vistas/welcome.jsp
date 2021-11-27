<%-- 
    Document   : welcome
    Created on : 26-nov-2021, 21:40:02
    Author     : PcCom
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../diseño/iframes.css">
        <script src="../diseño/iframes.js"></script>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
        %>
        <h1>Bienvenida señorita <%= sesion.getAttribute("n")%></h1>
    </body>
</html>
