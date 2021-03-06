<%-- 
    Document   : welcome
    Created on : 26-nov-2021, 21:40:02
    Author     : PcCom
--%>

<%@page import="funciones.Arreglos"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../diseño/welcome.css">
    </head>
    <body>
        <%
            Arreglos fix = new Arreglos();
            HttpSession sesion = request.getSession();
            ProductoJpaController controlProducto = new ProductoJpaController();
            List<Producto> datosProducto = controlProducto.findProductoEntities();
            if(sesion.getAttribute("mensaje") == "v"){
                out.print("<script>alert('Lo sentimos, pero el carrito se encuentra vacío, use nuestro buscador, nuestras categorías o directamente haga clic en algún producto que ve en pantalla, y al ver sus detalles, encontrara un botón para añadirlo al carrito');</script>");
                sesion.removeAttribute("mensaje");
            }
            if(sesion.getAttribute("mensaje") == "va"){
                out.print("<script>alert('Gracias por su compra!, Su carrito ha quedado vacío');</script>");
                sesion.removeAttribute("mensaje");
            }
            if(sesion.getAttribute("mensaje") == "vae"){
                out.print("<script>alert('Su carrito ha quedado vacío');</script>");
                sesion.removeAttribute("mensaje");
            }
            if(request.getParameter("mensajecorreo") != null){
                out.print("<script>alert('Nos pondremos en contacto con usted, revise su correo');</script>");
            }
            if(sesion.getAttribute("mensaje") == "yr"){
                out.print("<script>alert('Su cuenta ha sido registrada, bienvenid@');</script>");
                sesion.removeAttribute("mensaje");
                sesion.setAttribute("fuera", "si");
            }
            if(sesion.getAttribute("mensaje") == "nr"){
                out.print("<script>alert('No se ha podido registrar la cuenta, puede que esta ya exista, contacte con asistencia al cliente');</script>");
                sesion.removeAttribute("mensaje");
            }
        %>
        <div class="base">
            <div class="ofertas">
                <div class="headoferta">
                    <h1>¡ESTAMOS DE OFERTAS!</h1>
                    <h2>Hasta el 1 de enero, disfruta de nuestras ofertas de apertura</h2>
                </div>
                <div class="bodyoferta">
                <%int contador = 0;
                    for(Producto registro : datosProducto){
                        if(contador < 3){
                            if(registro.getDescuento() > 0 && registro.getStock() > 0){%>
                                <div class="productooferta" onclick="location.href='mostrarproducto.jsp?esteproducto=<%= registro.getIdpro()%>';" style="cursor: pointer;">
                                    <div class="imgproductooferta">
                                        <img src="../imagenes/<%= registro.getImg()%>" alt="<%= registro.getImg()%>">
                                    </div>
                                    <div class="contproductooferta">
                                        <h2><%= fix.fixtexto(registro.getNombre())%></h2>
                                        <hr>
                                        <h3 class="nombregrupo"><span class="delgrupo" style="color: gray;">de</span> <%= fix.fixtexto(registro.getAutor())%></h3>
                                        <%
                                            String contenido = registro.getContenido();
                                            contenido = contenido.replaceAll(" ", ", ");
                                        %>
                                        <p><span class="delgrupo" style="color: gray;">Contiene éxitos como:</span><br> <%= fix.fixtexto(contenido)%></p>
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
                                        %>
                                        <h3>Por: <%= formatoprecio.format(mostrar)%>€<br><span style="color: goldenrod;"><%= formatoprecio.format(mostrarp)%>€ para cuentas premium</span><br> <span style="color: red;">¡<%= registro.getDescuento()%>% de descuento!</span></h3>
                                    </div>
                                </div>
                                <%contador++;%>
                    <%}}}%>
                </div>
            </div>
            <div class="destacados">
                <div class="headdestacados">
                    <h1>Nuestros productos más destacados</h1>
                    <h2>Esto son unos de los productos más importantes que hemos podido añadir para la apertura de nuestra nueva web</h2>
                </div>
                <div class="bodydestacados">
                <%
                    for(Producto registro : datosProducto){%>
                                <div class="productodestacados" onclick="location.href='mostrarproducto.jsp?esteproducto=<%= registro.getIdpro()%>';" style="cursor: pointer;">
                                    <div class="imgproductodestacados">
                                        <img src="../imagenes/<%= registro.getImg()%>" alt="<%= registro.getImg()%>">
                                    </div>
                                    <div class="contproductodestacados">
                                        <h2><%= fix.fixtexto(registro.getNombre())%></h2>
                                        <hr>
                                        <h3 class="nombregrupo"><span class="delgrupo" style="color: gray;">de</span> <%= fix.fixtexto(registro.getAutor())%></h3>
                                        <%
                                            String contenido = registro.getContenido();
                                            contenido = contenido.replaceAll(" ", ", ");
                                        %>
                                        <p><span class="delgrupo" style="color: gray;">Contiene éxitos como:</span><br> <%= fix.fixtexto(contenido)%></p>
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
                    <%}%>
                </div>
            </div>
            <img src="../imagenes/bannerdetalles.jpg" alt="detalles" class="detalles">
        </div>
    </body>
</html>
