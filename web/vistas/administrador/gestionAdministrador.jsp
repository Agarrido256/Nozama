<%-- 
    Document   : gestionAdministrador
    Created on : 28-nov-2021, 15:23:11
    Author     : PcCom
--%>

<%@page import="funciones.Arreglos"%>
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
    <%
        Arreglos fix = new Arreglos();
        AdministradorJpaController controlAdministrador = new AdministradorJpaController();
        List<Administrador> datosAdministrador = controlAdministrador.findAdministradorEntities();
        HttpSession sesion = request.getSession();
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
            sesion.removeAttribute("mensaje");
        }
        if(sesion.getAttribute("mensaje") == "n"){
            out.print("<script>alert('ERROR, no se ha podido realizar la orden');</script>");
            sesion.removeAttribute("mensaje");
        }
        if(sesion.getAttribute("mensaje") == "f"){
            out.print("<script>alert('ERROR, fecha incorrecta');</script>");
            sesion.removeAttribute("mensaje");
        }
        if(sesion.getAttribute("mensaje") == "m"){
            out.print("<script>alert('ERROR, La entidad no existe');</script>");
            sesion.removeAttribute("mensaje");
        }
    %>
    <body>
        <a href="../tablas.jsp">Volver</a><br>
        <p>Introduzca los datos y seleccione la acción, en el caso de que quiera eliminar o modificar un registro,
            solo es necesario declarar el <strong>id identificador del registro en cuestión</strong></p>
        <h2>Gestionar administradores</h2>
        <h3>Registrar un administrador</h3>
        <form action='../../AdministradorDAO' method='POST'>
            <p>Id del Administrador: <input type='text' name='idadmin' required/></p>
            <p>Nombre: <input type='text' name='nombre' required/></p>
            <p>Apellidos: <input type='text' name='apellidos' required/></p>
            <p>Fecha de nacimiento: <input type='date' name='fechanac' required/></p>
            <p>Contraseña: <input type='password' name='contrasena' required/></p>
            <p>Fecha del contrato: <input type='date' name='fechacontrato' required/></p>
            <p><input type='submit' name='Registrar' value='Registrar'/></p>
        </form>
        <h3>Modificar a un administrador</h3>
        <form action='modAdministrador.jsp' method='GET'>
            <p>Id del Administrador: 
            <select name="idadmin">
            <%for(Administrador registro : datosAdministrador){%>
                <option value='<%= registro.getIdadmin()%>'><%= registro.getIdadmin()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='mod' value='Modificar'/></p>
        </form>
        <h3>Eliminar a un administrador</h3>
        <form action='../../AdministradorDAO' method='POST'>
            <p>Id del Administrador: 
            <select name="idadmin">
            <%for(Administrador registro : datosAdministrador){%>
                <option value='<%= registro.getIdadmin()%>'><%= registro.getIdadmin()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Eliminar' value='Eliminar'/></p>
        </form>
        <h3>Tabla Administrador</h3>
        <table>
            <tr>
                <th>
                    Id del Administrador
                </th>
                <th>
                    Nombre
                </th>
                <th>
                    Apellidos(fíjese en la tabla de abajo) 
                </th>
                <th>
                    Fecha de nacimiento
                </th>
                <th>
                    Fecha de contrato
                </th>
            </tr>
            <%for(Administrador registro : datosAdministrador){%>
            <tr>
                <td>
                    <%= fix.fixtexto(registro.getIdadmin())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getNombre())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getApellidos())%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechanac())%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechacontrato())%>
                </td>
            </tr>
            <%}%>
        </table><br>
    </body>
</html>

