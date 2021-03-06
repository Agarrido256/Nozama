<%-- 
    Document   : modAdministrador
    Created on : 27-nov-2021, 17:27:11
    Author     : PcCom
--%>

<%@page import="funciones.Arreglos"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        AdministradorJpaController controlcon = new AdministradorJpaController();
        List<Administrador> datos = controlcon.findAdministradorEntities();
        HttpSession sesion = request.getSession();
        String pattern = "dd-MM-yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String patron = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormato = new SimpleDateFormat(patron);
        String mensaje = "";
        if(request.getParameter("mod") != null){
            for(Administrador registro : datos){
                if(request.getParameter("idadmin").toString().equals(registro.getIdadmin())){
                    sesion.setAttribute("sidadmin", registro.getIdadmin());
                    sesion.setAttribute("snombre", registro.getNombre());
                    sesion.setAttribute("sapellidos", registro.getApellidos());
                    sesion.setAttribute("sfechanac", registro.getFechanac());
                    sesion.setAttribute("scontrasena", registro.getContrase??a());
                    sesion.setAttribute("sfechacontrato", registro.getFechacontrato());
                }
            }
        }
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
            for(Administrador registro : datos){
                if(registro.getIdadmin().equals(sesion.getAttribute("sidadmin"))){
                    sesion.setAttribute("snombre", registro.getNombre());
                    sesion.setAttribute("sapellidos", registro.getApellidos());
                    sesion.setAttribute("sfechanac", registro.getFechanac());
                    sesion.setAttribute("scontrasena", registro.getContrase??a());
                    sesion.setAttribute("sfechacontrato", registro.getFechacontrato());
                }
            }
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
        <a href="gestionAdministrador.jsp">Cancelar y volver</a><br>
        <p>Escriba solamente, los datos que desee cambiar del administrador con el id: <%= fix.fixtexto(sesion.getAttribute("sidadmin").toString())%></p>
        <form action='../../AdministradorDAO' method='POST'>
            <p>Nombre: <input type='text' name='nombre' placeholder='<%= fix.fixtexto(sesion.getAttribute("snombre").toString())%>'/></p>
            <p>Apellidos: <input type='text' name='apellidos' placeholder='<%= fix.fixtexto(sesion.getAttribute("sapellidos").toString())%>'/></p>
            <p>Fecha de nacimiento: <input type='date' name='fechanac' value='<%= simpleDateFormato.format(sesion.getAttribute("sfechanac"))%>'/></p>
            <p>Contrase??a: <input type='password' name='contrasena'/></p>
            <p>Fecha del contrato: <input type='date' name='fechacontrato' value='<%= simpleDateFormato.format(sesion.getAttribute("sfechacontrato"))%>'/></p>
            <p><input type='submit' name='Modificar' value='Modificar'/></p>
        </form>
        <br>
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
                    Apellidos
                </th>
                <th>
                    Fecha de nacimiento
                </th>
                <th>
                    Fecha de contrato
                </th>
            </tr>
            <%for(Administrador registro : datos){
                if(registro.getIdadmin().equals(sesion.getAttribute("sidadmin"))){%>
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
            <%}}%>
        </table><br>
    </body>
</html>
