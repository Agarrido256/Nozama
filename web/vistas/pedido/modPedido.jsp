<%-- 
    Document   : modPedido
    Created on : 05-dic-2021, 21:58:38
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page import="modelo.Pedido"%>
<%@page import="java.util.List"%>
<%@page import="modelo.PedidoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        PedidoJpaController controlPedido = new PedidoJpaController();
        List<Pedido> datosPedido = controlPedido.findPedidoEntities();
        ProductoJpaController controlProducto = new ProductoJpaController();
        List<Producto> datosProducto = controlProducto.findProductoEntities();
        UsuarioJpaController controlUsuario = new UsuarioJpaController();
        List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
        HttpSession sesion = request.getSession();
        String pattern = "dd-MM-yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String patron = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormato = new SimpleDateFormat(patron);
        String mensaje = "";
        if(request.getParameter("mod") != null){
            for(Pedido registro : datosPedido){
                if(request.getParameter("idpedido").equals(registro.getIdpedido().toString())){
                    sesion.setAttribute("sidpedido", registro.getIdpedido());
                    sesion.setAttribute("sfechacompra", registro.getFechacompra());
                    sesion.setAttribute("sestadoentrega", registro.getEstadoentrega());
                    sesion.setAttribute("sidusuario", registro.getIdusuario().getIduser());
                    sesion.setAttribute("sidproducto", registro.getIdproducto().getIdpro());
                    sesion.setAttribute("scantidadpedida", registro.getCantidadpedida());
                    sesion.setAttribute("scalle", registro.getCalle());
                    sesion.setAttribute("sciudad", registro.getCiudad());
                    sesion.setAttribute("sestado", registro.getEstado());
                    sesion.setAttribute("scodigopostal", registro.getCodigopostal());
                }
            }
        }
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
            for(Pedido registro : datosPedido){
                if(registro.getIdpedido().equals(sesion.getAttribute("sidpedido"))){
                    sesion.setAttribute("sfechacompra", registro.getFechacompra());
                    sesion.setAttribute("sestadoentrega", registro.getEstadoentrega());
                    sesion.setAttribute("sidusuario", registro.getIdusuario().getIduser());
                    sesion.setAttribute("sidproducto", registro.getIdproducto().getIdpro());
                    sesion.setAttribute("scantidadpedida", registro.getCantidadpedida());
                    sesion.setAttribute("scalle", registro.getCalle());
                    sesion.setAttribute("sciudad", registro.getCiudad());
                    sesion.setAttribute("sestado", registro.getEstado());
                    sesion.setAttribute("scodigopostal", registro.getCodigopostal());
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
        String Calle = sesion.getAttribute("scalle").toString();
        Calle = Calle.replaceAll("Ã±", "ñ");
        Calle = Calle.replaceAll("Ã", "Ñ");
        Calle = Calle.replaceAll("Âº", "º");
        String Ciudad = sesion.getAttribute("sciudad").toString();
        Ciudad = Ciudad.replaceAll("Ã±", "ñ");
        Ciudad = Ciudad.replaceAll("Ã", "Ñ");
        Ciudad = Ciudad.replaceAll("Âº", "º");
        String Estado = sesion.getAttribute("sestado").toString();
        Estado = Estado.replaceAll("Ã±", "ñ");
        Estado = Estado.replaceAll("Ã", "Ñ");
        Estado = Estado.replaceAll("Âº", "º");
    %>
    <body>
        <a href="gestionPedido.jsp">Cancelar y volver</a><br>
        <p>Escriba solamente, los datos que desee cambiar del pedido número: <%= sesion.getAttribute("sidpedido")%></p>
        <form action='../../PedidoDAO' method='POST'>
            <p>Fecha de compra: <input type='date' name='fechacompra' value='<%= simpleDateFormato.format(sesion.getAttribute("sfechacompra"))%>'/></p>
            <p>Estado de la entrega: <input type='text' name='estadoentrega' placeholder='<%= sesion.getAttribute("sestadoentrega")%>'/></p>
            <p>Id del comprador: 
            <select name="idusuario">
            <%for(Usuario registro : datosUsuario){
                if(sesion.getAttribute("sidusuario").equals(registro.getIduser())){%>
                    <option selected="selected" value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
                <%} else {%>
                    <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
                <%}}%>
            </select>
            </p>
            <p>Nombre del producto: 
            <select name="idproducto">
            <%for(Producto registro : datosProducto){
                if(sesion.getAttribute("sidproducto").equals(registro.getIdpro())){%>
                    <option selected="selected" value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
                <%} else {%>
                    <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
                <%}}%>
            </select>
            </p>
            <p>Cantidad de unidades pedidas: <input type="number" min="1" name='cantidadpedida' placeholder='<%= sesion.getAttribute("scantidadpedida")%>'/> unidades</p>
            <p>Información del envío:</p>
            <p>Calle: <input type='text' name='calle' placeholder='<%= Calle%>'/></p>
            <p>Ciudad: <input type='text' name='ciudad' placeholder='<%= Ciudad%>'/></p>
            <p>Estado: <input type='text' name='estado' placeholder='<%= Estado%>'/></p>
            <p>Código Postal: <input type='text' name='codigopostal' placeholder='<%= sesion.getAttribute("scodigopostal")%>'/></p>
            <p><input type='submit' name='Modificar' value='Modificar'/></p>
        </form>
        <br>
        <h3>Tabla Pedido</h3>
        <table>
            <tr>
                <th>
                    Pedido número
                </th>
                <th>
                    Fecha de compra
                </th>
                <th>
                    Estado de la entrega
                </th>
                <th>
                    Id del comprador
                </th>
                <th>
                    Id del producto
                </th>
                <th>
                    Cantidad de unidades pedidas
                </th>
                <th>
                    Calle
                </th>
                <th>
                    Ciudad
                </th>
                <th>
                    Estado
                </th>
                <th>
                    Código Postal
                </th>
            </tr>
            <%for(Pedido registro : datosPedido){
                if(registro.getIdpedido().equals(sesion.getAttribute("sidpedido"))){%>
            <tr>
                <td>
                    <%= registro.getIdpedido()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechacompra())%>
                </td>
                <td>
                    <%= registro.getEstadoentrega()%>
                </td>
                <td>
                    <%= registro.getIdusuario().getIduser()%>
                </td>
                <td>
                    <%= registro.getIdproducto().getIdpro()%>
                </td>
                <td>
                    <%= registro.getCantidadpedida()%>
                </td>
                <td>
                    <%
                        String esteCalle = registro.getCalle().toString();
                        esteCalle = esteCalle.replaceAll("Ã±", "ñ");
                        esteCalle = esteCalle.replaceAll("Ã", "Ñ");
                        esteCalle = esteCalle.replaceAll("Âº", "º");
                    %>
                    <%= esteCalle%>
                </td>
                <td>
                    <%
                        String esteCiudad = registro.getCiudad().toString();
                        esteCiudad = esteCiudad.replaceAll("Ã±", "ñ");
                        esteCiudad = esteCiudad.replaceAll("Ã", "Ñ");
                        esteCiudad = esteCiudad.replaceAll("Âº", "º");
                    %>
                    <%= esteCiudad%>
                </td>
                <td>
                    <%
                        String esteEstado = registro.getEstado().toString();
                        esteEstado = esteEstado.replaceAll("Ã±", "ñ");
                        esteEstado = esteEstado.replaceAll("Ã", "Ñ");
                        esteEstado = esteEstado.replaceAll("Âº", "º");
                    %>
                    <%= esteEstado%>
                </td>
                <td>
                    <%= registro.getCodigopostal() %>
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
            <%for(Usuario registrob : datosUsuario){%>
            <tr>
                <td>
                    <%= registrob.getIduser()%>
                </td>
                <td>
                    <%= registrob.getNombre()%>
                </td>
                <td>
                    <%= registrob.getApellidos()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registrob.getFechanac())%>
                </td>
                <td>
                    <%= registrob.getPremium()%>
                </td>
                <%if(registrob.getFechacadpremium() == null){%>
                <td>

                </td>
                <%} else {%>
                <td>
                    <%= simpleDateFormat.format(registrob.getFechacadpremium())%>
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
            <%for(Producto registroc : datosProducto){%>
            <tr>
                <td>
                    <%= registroc.getIdpro()%>
                </td>
                <td>
                    <%= registroc.getCategoria()%>
                </td>
                <td>
                    <%= registroc.getAutor()%>
                </td>
                <td>
                    <%= registroc.getImg()%>
                </td>
                <td>
                    <%= registroc.getNombre()%>
                </td>
                <td>
                    <%= registroc.getContenido()%>
                </td>
                <td>
                    <%= registroc.getPrecio()%>
                </td>
                <td>
                    <%= registroc.getPreciopremium()%>
                </td>
                <td>
                    <%= registroc.getPrecioenvio()%>
                </td>
                <td>
                    <%= registroc.getDescuento()%>
                </td>
                <td>
                    <%= registroc.getStock()%>
                </td>
            </tr>
            <%}%>
        </table><br>
    </body>
</html>

