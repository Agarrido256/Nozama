<%-- 
    Document   : modForo
    Created on : 07-dic-2021, 17:46:43
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page import="modelo.Foro"%>
<%@page import="java.util.List"%>
<%@page import="modelo.ForoJpaController"%>
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
        
        ForoJpaController controlForo = new ForoJpaController();
        List<Foro> datosForo = controlForo.findForoEntities();
        ProductoJpaController controlProducto = new ProductoJpaController();
        List<Producto> datosProducto = controlProducto.findProductoEntities();
        UsuarioJpaController controlUsuario = new UsuarioJpaController();
        List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
        HttpSession sesion = request.getSession();
        String pattern = "dd-MM-yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String mensaje = "";
        if(request.getParameter("mod") != null){
            for(Foro registro : datosForo){
                if(request.getParameter("idforo").equals(registro.getIdforo().toString())){
                    sesion.setAttribute("sidforo", registro.getIdforo());
                    sesion.setAttribute("sasunto", registro.getAsunto());
                    sesion.setAttribute("sdescripcion", registro.getDescripcion());
                    sesion.setAttribute("spuntuacion", registro.getPuntuacion());
                    sesion.setAttribute("sidusuario", registro.getIdusuario().getIduser());
                    sesion.setAttribute("sidpproducto", registro.getIdpprodcuto().getIdpro());
                }
            }
        }
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
            for(Foro registro : datosForo){
                if(registro.getIdforo().equals(sesion.getAttribute("sidforo"))){
                    sesion.setAttribute("sasunto", registro.getAsunto());
                    sesion.setAttribute("sdescripcion", registro.getDescripcion());
                    sesion.setAttribute("spuntuacion", registro.getPuntuacion());
                    sesion.setAttribute("sidusuario", registro.getIdusuario().getIduser());
                    sesion.setAttribute("sidpproducto", registro.getIdpprodcuto().getIdpro());
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
        <a href="gestionForo.jsp">Cancelar y volver</a><br>
        <p>Escriba solamente, los datos que desee cambiar del foro número: <%= sesion.getAttribute("sidforo")%></p>
        <form action='../../ForoDAO' method='POST'>
            <p>Asunto: <input type='text' name='asunto' placeholder='<%= sesion.getAttribute("sasunto")%>'/></p>
            <p>Descripción: <input type='text' name='descripcion' placeholder='<%= sesion.getAttribute("sdescripcion")%>'/></p>
            <p>Puntuación: <input type="number" min="0" max="5" name='puntuacion' placeholder='<%= sesion.getAttribute("spuntuacion")%>'/></p>
            <p>Id del usuario que ha publicado la opinión: 
            <select name="idusuario">
            <%for(Usuario registro : datosUsuario){
                if(sesion.getAttribute("sidusuario").equals(registro.getIduser())){%>
                    <option selected="selected" value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
                <%} else {%>
                    <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
                <%}}%>
            </select>
            </p>
            <p>Nombre del producto en el que se ha publicado la opinión: 
            <select name="idpproducto">
            <%for(Producto registro : datosProducto){
                if(sesion.getAttribute("sidpproducto").equals(registro.getIdpro())){%>
                    <option selected="selected" value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
                <%} else {%>
                    <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
                <%}}%>
            </select>
            </p>
            <p><input type='submit' name='Modificar' value='Modificar'/></p>
        </form>
        <br>
        <h3>Tabla Foro</h3>
        <table>
            <tr>
                <th>
                    Foro número
                </th>
                <th>
                    Asunto
                </th>
                <th>
                    Descripción
                </th>
                <th>
                    Puntuación
                </th>
                <th>
                    Id del usuario
                </th>
                <th>
                    Id del producto
                </th>
            </tr>
            <%for(Foro registro : datosForo){
                if(registro.getIdforo().equals(sesion.getAttribute("sidforo"))){%>
            <tr>
                <td>
                    <%= registro.getIdforo()%>
                </td>
                <td>
                    <%= registro.getDescripcion() %>
                </td>
                <td>
                    <%= registro.getAsunto()%>
                </td>
                <td>
                    <%= registro.getPuntuacion()%>
                </td>
                <td>
                    <%= registro.getIdusuario().getIduser()%>
                </td>
                <td>
                    <%= registro.getIdpprodcuto().getIdpro()%>
                </td>
            </tr>
            <%}}%>
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
            <%for(Producto registro : datosProducto){%>
            <tr>
                <td>
                    <%= registro.getIdpro()%>
                </td>
                <td>
                    <%= registro.getCategoria()%>
                </td>
                <td>
                    <%= registro.getAutor()%>
                </td>
                <td>
                    <%= registro.getImg()%>
                </td>
                <td>
                    <%= registro.getNombre()%>
                </td>
                <td>
                    <%= registro.getContenido()%>
                </td>
                <td>
                    <%= registro.getPrecio()%>
                </td>
                <td>
                    <%= registro.getPreciopremium()%>
                </td>
                <td>
                    <%= registro.getPrecioenvio()%>
                </td>
                <td>
                    <%= registro.getDescuento()%>
                </td>
                <td>
                    <%= registro.getStock()%>
                </td>
            </tr>
            <%}%>
        </table><br>
    </body>
</html>

