<%-- 
    Document   : gestionUsuario
    Created on : 28-nov-2021, 17:21:09
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
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
        UsuarioJpaController controlUsuario = new UsuarioJpaController();
        List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
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
        <h2>Gestionar usuarios</h2>
        <h3>Registrar un usuario</h3>
        <form action='../../UsuarioDAO' method='POST'>
            <p>Id del Usuario: <input type='text' name='iduser' required/></p>
            <p>Nombre: <input type='text' name='nombre' required/></p>
            <p>Apellidos: <input type='text' name='apellidos' required/></p>
            <p>Fecha de nacimiento: <input type='date' name='fechanac' required/></p>
            <p>Cuenta premium:(si)<input type='radio' name='premium' value="true" required/>
                (no)<input type='radio' name='premium' value="false" required/></p>
            <p>Fecha de caducidad de cuenta premium: <input type='date' name='fechacadpremium'/></p>
            <p>Contraseña: <input type='password' name='contrasena' required/></p>
            <p><input type='submit' name='Registrar' value='Registrar'/></p>
        </form>
        <h3>Modificar a un usuario</h3>
        <form action='modUsuario.jsp' method='GET'>
            <p>Id del Usuario: 
            <select name="iduser">
            <%for(Usuario registro : datosUsuario){%>
                <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='mod' value='Modificar'/></p>
        </form>
        <h3>Eliminar a un administrador</h3>
        <form action='../../UsuarioDAO' method='POST'>
            <p>Id del Usuario: 
            <select name="iduser">
            <%for(Usuario registro : datosUsuario){%>
                <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Eliminar' value='Eliminar'/></p>
        </form>
        <h3>Tabla Usuario</h3>
        <table>
            <tr>
                <th>
                    Id del Usuario
                </th>
                <th>
                    Nombre
                </th>
                <th>
                    Apellidos
                </th>
                <th>
                    Fecha de nacimiento
                </th>
                <th>
                    ¿Cuenta premium?
                </th>
                <th>
                    Fecha de caducidad de cuenta premium
                </th>
            </tr>
            <%for(Usuario registro : datosUsuario){%>
            <tr>
                <td>
                    <%= registro.getIduser()%>
                </td>
                <td>
                    <%= registro.getNombre()%>
                </td>
                <td>
                    <%= registro.getApellidos()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechanac())%>
                </td>
                <td>
                    <%= registro.getPremium()%>
                </td>
                <%if(registro.getFechacadpremium() == null){%>
                <td>

                </td>
                <%} else {%>
                <td>
                    <%= simpleDateFormat.format(registro.getFechacadpremium())%>
                </td>
                <%}%>
            </tr>
            <%}%>
        </table><br>
    </body>
</html>

