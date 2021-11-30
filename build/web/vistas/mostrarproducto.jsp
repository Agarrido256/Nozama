<%-- 
    Document   : mostrarproducto
    Created on : 29-nov-2021, 21:23:19
    Author     : PcCom
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="modelo.Foro"%>
<%@page import="modelo.ForoJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" href="../diseño/mostrarproducto.css">
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            ProductoJpaController controlProducto = new ProductoJpaController();
            List<Producto> datosProducto = controlProducto.findProductoEntities();
            ForoJpaController controlForo = new ForoJpaController();
            List<Foro> datosForo = controlForo.findForoEntities();
            if(request.getParameter("esteproducto") == null){
                response.sendRedirect("welcome.jsp");
            }
            int esteproducto = Integer.parseInt(request.getParameter("esteproducto"));
        %>
        <div class="base">
                <div class="body">
                <%
                    for(Producto registro : datosProducto){
                    if(registro.getIdpro() == esteproducto){%>
                                <div class="producto">
                                    <div class="imgdiv">
                                        <img src="../imagenes/<%= registro.getImg()%>" alt="<%= registro.getImg()%>">
                                    </div>
                                    <div class="contdiv">
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
                                        <h3>Por: <%= formatoprecio.format(mostrar)%>€<br><span style="color: goldenrod;"><%= formatoprecio.format(mostrarp)%>€ para cuentas premium</span><br> <span style="color: red;">¡<%= registro.getDescuento()%>% de descuento!</span><br><span style="color: gray;">¡<%= registro.getPrecioenvio()%> de envió</span></h3>
                                        <%} else {%>
                                        <h3>Por: <%= formatoprecio.format(Double.parseDouble(precio))%>€<br><span style="color: goldenrod;"><%= formatoprecio.format(Double.parseDouble(preciop))%>€ para cuentas premium</span><br><span style="color: gray;"><%= registro.getPrecioenvio()%> de envió</span></h3>
                                        <%}%>
                                        <br><br><br><br><br><br>
                                        <button>Comprar</button>
                                        <button>Añadir al carro</button><br>
                                        <label style="color: red; opacity: 0.7;">*falta por implementar funciones comprar y añadir carro</label><br>
                                        <label style="color: red; opacity: 0.7;">*PÁGINA NO TERMINADA, FALTA DISEÑO</label> 
                                    </div>
                                </div>
                                <div class="foro">
                                    <label style="color: red; opacity: 0.7;">*falta por implementar opiniones de los clientes</label> 
                                </div>
                    <%}}%>
                </div>
            </div>
    </body>
</html>
