<%-- 
    Document   : asistencia
    Created on : 11-dic-2021, 21:05:19
    Author     : PcCom
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" href="../diseño/ptexto.css">
    </head>
    <%
        if(request.getParameter("a") != null){
            response.sendRedirect("welcome.jsp?mensajecorreo=yes");
        }
    %>
    <body>
        <a href="welcome.jsp">Salir</a><br><br>
        <div class="base">
            <h1>Asistencia al cliente</h1>
            <h2>Por favor, coméntenos cualquier problema o fallo que la web Nozama pueda tener.</h2>
            <p>Para ello, nos pondremos en contacto mediante correo con usted lo antes posible, puede que exista una demora en nuestra respuesta, por posiblemente que tengamos muchas peticiones de asistencia en el momento.</p>
            <p>Por favor, envíenos un correo con el que nos podamos poner en contacto con usted:<form action='asistencia.jsp' method='GET'><input type="email" required><input type="submit" value="enviar" name="a"></form></p>
        </div>
    </body>
</html>
