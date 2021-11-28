<%-- 
    Document   : modUsuario
    Created on : 28-nov-2021, 17:21:34
    Author     : PcCom
--%>

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
        UsuarioJpaController controlcon = new UsuarioJpaController();
        List<Usuario> datos = controlcon.findUsuarioEntities();
        HttpSession sesion = request.getSession();
        String pattern = "dd-MM-yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String patron = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormato = new SimpleDateFormat(patron);
        String mensaje = "";
        if(request.getParameter("mod") != null){
            for(Usuario registro : datos){
                if(request.getParameter("iduser").toString().equals(registro.getIduser())){
                    sesion.setAttribute("siduser", registro.getIduser() );
                    sesion.setAttribute("snombre", registro.getNombre());
                    sesion.setAttribute("sapellidos", registro.getApellidos());
                    sesion.setAttribute("sfechanac", registro.getFechanac());
                    sesion.setAttribute("spremium", registro.getPremium());
                    sesion.setAttribute("sfechacadpremium", registro.getFechacadpremium());
                    sesion.setAttribute("scontrasena", registro.getContraseña());
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
        <a href="gestionUsuario.jsp">Cancelar y volver</a><br>
        <p>Escriba solamente, los datos que desee cambiar del administrador con el id: <%= sesion.getAttribute("sidadmin")%></p>
        <form action='../../AdministradorDAO' method='POST'>
            <p>Nombre: <input type='text' name='nombre' placeholder='<%= sesion.getAttribute("snombre")%>'></p>
            <p>Apellidos: <input type='text' name='apellidos' placeholder='<%= sesion.getAttribute("sapellidos")%>'/></p>
            <p>Fecha de nacimiento: <input type='date' name='fechanac' value='<%= simpleDateFormato.format(sesion.getAttribute("sfechanac"))%>'/></p>
            <%if(sesion.getAttribute("spremium").equals(true)){%>
            <p>Cuenta premium:(si)<input type='radio' name='premium' value="true" checked/>
                (no)<input type='radio' name='premium' value="false"/></p>
            <%} else {%>
            <p>¿Administrador?(si)<input type='radio' name='premium' value="true"/>
                (no)<input type='radio' name='premium' value="false" checked/></p>
            <%}%>
            <p>Fecha de caducidad de cuenta premium: <input type='date' name='fechacadpremium' 
            <%if(sesion.getAttribute("sfechacadpremium") != null){%>
                value='<%= simpleDateFormato.format(sesion.getAttribute("sfechanac"))%>'
            <%}%>
            /></p>
            <p>Contraseña: <input type='password' name='contrasena'/></p>
            <p><input type='submit' name='Modificar' value='Modificar'/></p>
        </form>
        <br>
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
            <%for(Usuario registro : datos){
                if(registro.getIduser().equals(sesion.getAttribute("siduser"))){%>
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
            <%}}%>
        </table><br>
    </body>
</html>

