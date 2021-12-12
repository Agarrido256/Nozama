<%-- 
    Document   : historial
    Created on : 12-dic-2021, 0:35:48
    Author     : PcCom
--%>

<%@page import="funciones.Arreglos"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Pedido"%>
<%@page import="java.util.List"%>
<%@page import="modelo.PedidoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../diseño/historial.css">
    </head>
    <%
        Arreglos fix = new Arreglos();
        PedidoJpaController controlPedido = new PedidoJpaController();
        List<Pedido> datosPedido = controlPedido.findPedidoEntities();
        HttpSession sesion = request.getSession();
        String pattern = "dd-MM-yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String patron = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormato = new SimpleDateFormat(patron);
        if(sesion.getAttribute("user") == null){
            response.sendRedirect("welcome.jsp");
        }
    %>
    <body>
        <a href="welcome.jsp" style="height: 10px; margin-bottom: 0px;">Volver</a><br><br>
        <div class="base">
            <h2>Este es su historial de compras</h2>
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
                if(registro.getIdusuario().getIduser().toString().equals(sesion.getAttribute("user").toString())){%>
            <tr>
                <td>
                    <%= registro.getIdpedido()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechacompra())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getEstadoentrega())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getIdusuario().getIduser())%>
                </td>
                <td>
                    <%= registro.getIdproducto().getIdpro()%>
                </td>
                <td>
                    <%= registro.getCantidadpedida()%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getCalle())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getCiudad())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getEstado())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getCodigopostal())%>
                </td>
            </tr>
            <%}}%>
        </table><br>
    </body>
</html>
