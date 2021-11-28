<%-- 
    Document   : tablas
    Created on : 27-nov-2021, 17:29:18
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Administrador"%>
<%@page import="java.util.List"%>
<%@page import="modelo.AdministradorJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <style>
            *{
                font-family: 'Source Sans Pro', sans-serif;
}

            html, body{
                width: 100%;
                height: 100%;
                margin: 0;
            }

            body{
                background-color: rgb(244,244,244);
            }
            
            table, td, th {
                border: 1px solid black;
            }

            table {
                border-collapse: collapse;
            }  
            
            tr, td{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <a href="welcome.jsp">Salir</a><br><br>
        <a href="administrador/gestionAdministrador.jsp" style="background-color: #CF6A32; color: white; border-radius: 10px; text-decoration: none; border: solid black 2px; padding: 2px; margin-left: 10px;">Gestionar la tabla Administrador</a><label style="color: red;">Falta por arreglar el modificar</label>
        <a href="usuario/gestionUsuario.jsp" style="background-color: #B2B2B2; color: white; border-radius: 10px; text-decoration: none; border: solid black 2px; padding: 2px; margin-left: 10px;">Gestionar la tabla Usuario</a><label style="color: red;">Falta por arreglar enviar sin valor no required y arreglar el modificar</label><br><br>
        <a href="#" style="background-color: #476291; color: white; border-radius: 10px; text-decoration: none; border: solid black 2px; padding: 2px; margin-left: 10px;">Gestionar la tabla Producto</a><label style="color: red;">Falta por implementar</label>
        <a href="#" style="background-color: #4D7455; color: white; border-radius: 10px; text-decoration: none; border: solid black 2px; padding: 2px; margin-left: 10px;">Gestionar la tabla Pedido</a><label style="color: red;">Falta por implementar</label><br><br>
        <a href="#" style="background-color: #AA0000; color: white; border-radius: 10px; text-decoration: none; border: solid black 2px; padding: 2px; margin-left: 10px;">Gestionar la tabla Asistencia</a><label style="color: red;">Falta por implementar</label>
        <a href="#" style="background-color: #8650AC; color: white; border-radius: 10px; text-decoration: none; border: solid black 2px; padding: 2px; margin-left: 10px;">Gestionar la tabla Foro</a><label style="color: red;">Falta por implementar</label><br><br>
    </body>
</html>
