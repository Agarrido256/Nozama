<%-- 
    Document   : categoria
    Created on : 30-nov-2021, 19:36:59
    Author     : PcCom
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" href="../diseño/categoria.css">
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            ProductoJpaController controlProducto = new ProductoJpaController();
            List<Producto> datosProducto = controlProducto.findProductoEntities();
            String nombrecategoria = null;
            if(sesion.getAttribute("c") == null){
                response.sendRedirect("welcome.jsp");
            }
            if(sesion.getAttribute("c").equals("Electronica")){
                nombrecategoria = "Electrónica";
            } else {
                nombrecategoria = String.valueOf(sesion.getAttribute("c"));
            }
        %>
        <div class="base">
            <div class="destacados">
                <div class="headdestacados">
                    <h1>Todos nuestros discos de <%= nombrecategoria%></h1>
                </div>
                <div class="bodydestacados">
                <%
                    for(Producto registro : datosProducto){
                    if(registro.getCategoria().equals(sesion.getAttribute("c"))){%>
                                <div class="productodestacados" onclick="location.href='mostrarproducto.jsp?esteproducto=<%= registro.getIdpro()%>';" style="cursor: pointer;">
                                    <div class="imgproductodestacados">
                                        <img src="../imagenes/<%= registro.getImg()%>" alt="<%= registro.getImg()%>">
                                    </div>
                                    <div class="contproductodestacados">
                                        <h2><%= registro.getNombre()%></h2>
                                        <hr>
                                        <h3 class="nombregrupo"><span class="delgrupo" style="color: gray;">de</span> <%= registro.getAutor()%></h3>
                                        <%
                                            String contenido = registro.getContenido();
                                            contenido = contenido.replaceAll(" ", ", ");
                                        %>
                                        <p><span class="delgrupo" style="color: gray;">Contiene éxitos como:</span><br> <%= contenido%></p>
                                        <%
                                        String precio = registro.getPrecio();
                                        precio = precio.replaceAll(",", ".");
                                        precio = precio.replaceAll("€", "");
                                        String preciop = registro.getPreciopremium();
                                        preciop = preciop.replaceAll(",", ".");
                                        preciop = preciop.replaceAll("€", "");
                                        Double descuento = (Double.parseDouble(precio) * registro.getDescuento()) / 100;
                                        Double mostrar = Double.parseDouble(precio) - descuento;
                                        Double descuentopremium = (Double.parseDouble(preciop) * registro.getDescuento()) / 100;
                                        Double mostrarp = Double.parseDouble(preciop) - descuentopremium;
                                        DecimalFormat formatoprecio = new DecimalFormat("#.00");
                                        if(registro.getDescuento() > 0){
                                        %>
                                        <h3>Por: <%= formatoprecio.format(mostrar)%>€<br><span style="color: goldenrod;"><%= formatoprecio.format(mostrarp)%>€ para cuentas premium</span><br> <span style="color: red;">¡<%= registro.getDescuento()%>% de descuento!</span></h3>
                                        <%} else {%>
                                        <h3>Por: <%= formatoprecio.format(Double.parseDouble(precio))%>€<br><span style="color: goldenrod;"><%= formatoprecio.format(Double.parseDouble(preciop))%>€ para cuentas premium</span></h3>
                                        <%}%>
                                    </div>
                                </div>
                    <%}}%>
                </div>
            </div>
        </div>
    </body>
</html>
