<%-- 
    Document   : modAdministrador
    Created on : 27-nov-2021, 17:27:11
    Author     : PcCom
--%>

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
                    sesion.setAttribute("scontrasena", registro.getContraseña());
                    sesion.setAttribute("sfechacontrato", registro.getFechacontrato());
                }
            }
        }
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
            sesion.removeAttribute("mensaje");
        }
        if(sesion.getAttribute("mensaje") == "n"){
            out.print("<script>alert('ERROR, no se ha podido realizado la orden');</script>");
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
        <a href="tablas.jsp">Cancelar y volver</a><br>
        <p>Escriba solamente, los datos que desee cambiar del administrador con el id: <%= sesion.getAttribute("sidadmin")%></p>
        <form action='../AdministradorDAO' method='POST'>
            <p>Nombre: <input type='text' name='nombre' placeholder='<%= sesion.getAttribute("snombre")%>'/></p>
            <p>Apellidos: <input type='text' name='apellidos' placeholder='<%= sesion.getAttribute("sapellidos")%>'/></p>
            <p>Fecha de nacimiento: <input type='date' name='fechanac' value='<%= simpleDateFormato.format(sesion.getAttribute("sfechanac"))%>'/></p>
            <p>Contraseña: <input type='password' name='contrasena'/></p>
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
                    fecha de nacimiento
                </th>
                <th>
                    Fecha de contrato
                </th>
            </tr>
            <%for(Administrador registro : datos){
                if(registro.getIdadmin().equals(sesion.getAttribute("sidadmin"))){%>
            <tr>
                <td>
                    <%= registro.getIdadmin()%>
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
                    <%= simpleDateFormat.format(registro.getFechacontrato())%>
                </td>
            </tr>
            <%}}%>
        </table><br>
    </body>
</html>
