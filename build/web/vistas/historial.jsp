<%-- 
    Document   : historial
    Created on : 12-dic-2021, 0:35:48
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Pedido"%>
<%@page import="java.util.List"%>
<%@page import="modelo.PedidoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../diseño/uconf.css">
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
        <div class="base" style="margin-top: -300px;">
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
                        esteCalle = esteCalle.replaceAll("Ã¡", "á");
                        esteCalle = esteCalle.replaceAll("Ã©", "é");
                        esteCalle = esteCalle.replaceAll("Ã­", "í");
                        esteCalle = esteCalle.replaceAll("Ã³", "ó");
                        esteCalle = esteCalle.replaceAll("Ãº", "ú");
                        esteCalle = esteCalle.replaceAll("Ã", "Á");
                        esteCalle = esteCalle.replaceAll("Ã", "É");
                        esteCalle = esteCalle.replaceAll("Ã", "Í");
                        esteCalle = esteCalle.replaceAll("Ã", "Ó");
                        esteCalle = esteCalle.replaceAll("Ã", "Ú");
                    %>
                    <%= esteCalle%>
                </td>
                <td>
                    <%
                        String esteCiudad = registro.getCiudad().toString();
                        esteCiudad = esteCiudad.replaceAll("Ã±", "ñ");
                        esteCiudad = esteCiudad.replaceAll("Ã", "Ñ");
                        esteCiudad = esteCiudad.replaceAll("Âº", "º");
                        esteCiudad = esteCiudad.replaceAll("Ã¡", "á");
                        esteCiudad = esteCiudad.replaceAll("Ã©", "é");
                        esteCiudad = esteCiudad.replaceAll("Ã­", "í");
                        esteCiudad = esteCiudad.replaceAll("Ã³", "ó");
                        esteCiudad = esteCiudad.replaceAll("Ãº", "ú");
                        esteCiudad = esteCiudad.replaceAll("Ã", "Á");
                        esteCiudad = esteCiudad.replaceAll("Ã", "É");
                        esteCiudad = esteCiudad.replaceAll("Ã", "Í");
                        esteCiudad = esteCiudad.replaceAll("Ã", "Ó");
                        esteCiudad = esteCiudad.replaceAll("Ã", "Ú");
                    %>
                    <%= esteCiudad%>
                </td>
                <td>
                    <%
                        String esteEstado = registro.getEstado().toString();
                        esteEstado = esteEstado.replaceAll("Ã±", "ñ");
                        esteEstado = esteEstado.replaceAll("Ã", "Ñ");
                        esteEstado = esteEstado.replaceAll("Âº", "º");
                        esteEstado = esteEstado.replaceAll("Ã¡", "á");
                        esteEstado = esteEstado.replaceAll("Ã©", "é");
                        esteEstado = esteEstado.replaceAll("Ã­", "í");
                        esteEstado = esteEstado.replaceAll("Ã³", "ó");
                        esteEstado = esteEstado.replaceAll("Ãº", "ú");
                        esteEstado = esteEstado.replaceAll("Ã", "Á");
                        esteEstado = esteEstado.replaceAll("Ã", "É");
                        esteEstado = esteEstado.replaceAll("Ã", "Í");
                        esteEstado = esteEstado.replaceAll("Ã", "Ó");
                        esteEstado = esteEstado.replaceAll("Ã", "Ú");
                    %>
                    <%= esteEstado%>
                </td>
                <td>
                    <%= registro.getCodigopostal() %>
                </td>
            </tr>
            <%}}%>
        </table><br>
    </body>
</html>
