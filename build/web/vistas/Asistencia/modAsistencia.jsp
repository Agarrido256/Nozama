<%-- 
    Document   : modAsistencia
    Created on : 07-dic-2021, 16:57:03
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Administrador"%>
<%@page import="modelo.AdministradorJpaController"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page import="modelo.Asistencia"%>
<%@page import="java.util.List"%>
<%@page import="modelo.AsistenciaJpaController"%>
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
        AsistenciaJpaController controlAsistencia = new AsistenciaJpaController();
        List<Asistencia> datosAsistencia = controlAsistencia.findAsistenciaEntities();
        ProductoJpaController controlProducto = new ProductoJpaController();
        List<Producto> datosProducto = controlProducto.findProductoEntities();
        UsuarioJpaController controlUsuario = new UsuarioJpaController();
        List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
        AdministradorJpaController controlAdministrador = new AdministradorJpaController();
        List<Administrador> datosAdministrador = controlAdministrador.findAdministradorEntities();
        HttpSession sesion = request.getSession();
        String pattern = "dd-MM-yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String mensaje = "";
        if(request.getParameter("mod") != null){
            for(Asistencia registro : datosAsistencia){
                if(request.getParameter("idasistencia").equals(registro.getIdasistencia().toString())){
                    sesion.setAttribute("sidasistencia", registro.getIdasistencia());
                    sesion.setAttribute("sasunto", registro.getAsunto());
                    sesion.setAttribute("sdescripcion", registro.getDescripcion());
                    sesion.setAttribute("sestado", registro.getEstado());
                    sesion.setAttribute("sidusuario", registro.getIdusuario().getIduser());
                    sesion.setAttribute("sidpproducto", registro.getIdpprodcuto().getIdpro());
                    sesion.setAttribute("sidadministrador", registro.getIdadministrador().getIdadmin());
                }
            }
        }
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
            for(Asistencia registro : datosAsistencia){
                if(sesion.getAttribute("sidasistencia").equals(registro.getIdasistencia().toString())){
                    sesion.setAttribute("sasunto", registro.getAsunto());
                    sesion.setAttribute("sdescripcion", registro.getDescripcion());
                    sesion.setAttribute("sestado", registro.getEstado());
                    sesion.setAttribute("sidusuario", registro.getIdusuario().getIduser());
                    sesion.setAttribute("sidpproducto", registro.getIdpprodcuto().getIdpro());
                    sesion.setAttribute("sidadministrador", registro.getIdadministrador().getIdadmin());
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
        <a href="gestionAsistencia.jsp">Cancelar y volver</a><br>
        <p>Escriba solamente, los datos que desee cambiar del ticket de asistencia número: <%= sesion.getAttribute("sidasistencia")%></p>
        <form action='../../AsistenciaDAO' method='POST'>
            <p>Asunto: <input type='text' name='asunto' placeholder='<%= sesion.getAttribute("sasunto")%>'/></p>
            <p>Descripción: <input type='text' name='descripcion' placeholder='<%= sesion.getAttribute("sdescripcion")%>'/></p>
            <p>Estado: <input type='text' name='estado' placeholder='<%= sesion.getAttribute("sestado")%>'/></p>
            <p>Id del comprador que pide ayuda: 
            <select name="idusuario">
            <%for(Usuario registro : datosUsuario){
                if(sesion.getAttribute("sidusuario").equals(registro.getIduser())){%>
                    <option selected="selected" value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
                <%} else {%>
                    <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
                <%}}%>
            </select>
            </p>
            <p>Nombre del producto con el que existe el problema: 
            <select name="idpproducto">
            <%for(Producto registro : datosProducto){
                if(sesion.getAttribute("sidproducto").equals(registro.getIdpro())){%>
                    <option selected="selected" value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
                <%} else {%>
                    <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
                <%}}%>
            </select>
            </p>
            <p>Id del administrador que responde: 
            <select name="idadministrador">
            <%for(Administrador registro : datosAdministrador){
                if(sesion.getAttribute("sidadministrador").equals(registro.getIdadmin())){%>
                    <option selected="selected" value='<%= registro.getIdadmin()%>'><%= registro.getIdadmin()%></option>
                <%} else {%>
                    <option value='<%= registro.getIdadmin()%>'><%= registro.getIdadmin()%></option>
                <%}}%>
            </select>
            </p>
            <p><input type='submit' name='Modificar' value='Modificar'/></p>
        </form>
        <br>
        <h3>Tabla Asistencia</h3>
        <table>
            <tr>
                <th>
                    Asistencia número
                </th>
                <th>
                    Asunto
                </th>
                <th>
                    Descripción
                </th>
                <th>
                    Estado
                </th>
                <th>
                    Id del usuario
                </th>
                <th>
                    Id del producto
                </th>
                <th>
                    Id del administrador
                </th>
            </tr>
            <%for(Asistencia registro : datosAsistencia){
                if(registro.getIdasistencia().equals(sesion.getAttribute("sidasistencia"))){%>
            <tr>
                <td>
                    <%= registro.getIdasistencia()%>
                </td>
                <td>
                    <%= registro.getAsunto()%>
                </td>
                <td>
                    <%= registro.getEstado()%>
                </td>
                <td>
                    <%= registro.getIdusuario().getIduser()%>
                </td>
                <td>
                    <%= registro.getIdpprodcuto().getIdpro()%>
                </td>
                <td>
                    <%= registro.getIdadministrador().getIdadmin()%>
                </td>
            </tr>
            <%}%>
        </table><br>
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
            <%for(Usuario registroa : datosUsuario){%>
            <tr>
                <td>
                    <%= registroa.getIduser()%>
                </td>
                <td>
                    <%= registroa.getNombre()%>
                </td>
                <td>
                    <%= registroa.getApellidos()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registroa.getFechanac())%>
                </td>
                <td>
                    <%= registroa.getPremium()%>
                </td>
                <%if(registroa.getFechacadpremium() == null){%>
                <td>

                </td>
                <%} else {%>
                <td>
                    <%= simpleDateFormat.format(registroa.getFechacadpremium())%>
                </td>
                <%}%>
            </tr>
            <%}%>
        </table><br>
        <h3>Tabla Producto</h3>
        <table>
            <tr>
                <th>
                    Producto número
                </th>
                <th>
                    Categoría
                </th>
                <th>
                    Autor
                </th>
                <th>
                    Imagen del producto
                </th>
                <th>
                    Nombre
                </th>
                <th>
                    Contenido
                </th>
                <th>
                    Precio
                </th>
                <th>
                    Precio premium
                </th>
                <th>
                    Precio de envió
                </th>
                <th>
                    Descuento
                </th>
                <th>
                    Stock
                </th>
            </tr>
            <%for(Producto registrob : datosProducto){%>
            <tr>
                <td>
                    <%= registrob.getIdpro()%>
                </td>
                <td>
                    <%= registrob.getCategoria()%>
                </td>
                <td>
                    <%= registrob.getAutor()%>
                </td>
                <td>
                    <%= registrob.getImg()%>
                </td>
                <td>
                    <%= registrob.getNombre()%>
                </td>
                <td>
                    <%= registrob.getContenido()%>
                </td>
                <td>
                    <%= registrob.getPrecio()%>
                </td>
                <td>
                    <%= registrob.getPreciopremium()%>
                </td>
                <td>
                    <%= registrob.getPrecioenvio()%>
                </td>
                <td>
                    <%= registrob.getDescuento()%>
                </td>
                <td>
                    <%= registrob.getStock()%>
                </td>
            </tr>
            <%}%>
        </table><br>
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
            <%for(Administrador registroc : datosAdministrador){%>
            <tr>
                <td>
                    <%= registroc.getIdadmin()%>
                </td>
                <td>
                    <%= registroc.getNombre()%>
                </td>
                <td>
                    <%= registroc.getApellidos()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registroc.getFechanac())%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registroc.getFechacontrato())%>
                </td>
            </tr>
            <%}%>
        </table><br>
    </body>
</html>

