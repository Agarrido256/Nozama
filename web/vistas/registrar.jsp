<%-- 
    Document   : registrar
    Created on : 11-dic-2021, 21:30:40
    Author     : PcCom
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" href="../diseño/registrarse.css">
    </head>
    <%
        HttpSession sesion = request.getSession();
        if(sesion.getAttribute("mensaje") == "y"){
            sesion.setAttribute("mensaje", "yr");
            response.sendRedirect("welcome.jsp");
        }
        if(sesion.getAttribute("mensaje") == "n"){
            sesion.setAttribute("mensaje", "nr");
            response.sendRedirect("welcome.jsp");
        }
        if(sesion.getAttribute("mensaje") == "f"){
            out.print("<script>alert('Fecha incorrecta');</script>");
            sesion.removeAttribute("mensaje");
        }
        if(sesion.getAttribute("fuera") != null){
            response.sendRedirect("welcome.jsp");
        }
    %>
    <body>
        <a href="welcome.jsp">Cancelar</a><br><br>
        <div class="base">
            <h2>Nuevo usuario</h2>
            <p>Recuerde que para logearse en la web deben recordar su id de usuario y contraseña</p>
            <form action='../UsuarioDAO' method='POST'>
                <p>Id del Usuario: <input type='text' name='iduser' required/></p>
                <p>Nombre: <input type='text' name='nombre' required/></p>
                <p>Apellidos: <input type='text' name='apellidos' required/></p>
                <p>Fecha de nacimiento: <input type='date' name='fechanac' required/></p>
                <p>Contraseña: <input type='password' name='contrasena' required/></p>
                <p><input type='submit' name='Nuevo' value='Registrar'/></p>
            </form>
        </div>
    </body>
</html>
