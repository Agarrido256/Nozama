<%-- 
    Document   : carrito
    Created on : 11-dic-2021, 1:11:34
    Author     : PcCom
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" href="../diseño/carrito.css">
        <script src="../diseño/carrito.js"></script>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            ProductoJpaController controlProducto = new ProductoJpaController();
            List<Producto> datosProducto = controlProducto.findProductoEntities();
            String[] carray = (String[])sesion.getAttribute("carray");
            int count = 0;
            for (int i = 0; i < carray.length; i++) {
                if(carray[i] != null){
                    count++;
                }
            }
            if(count < 1){
                sesion.setAttribute("mensaje", "v");
                response.sendRedirect("welcome.jsp");
            }
        %>
        <div class="base">
            <div class="destacados">
                <div class="headdestacados">
                    <h1>Aquí esta tu carrito</h1>
                </div>
                <div class="bodydestacados">
                <%
                    for(Producto registro : datosProducto){
                        boolean ok = false;
                        for (int i = 0; i < carray.length; i++) {
                            if(registro.getIdpro().toString().equals(carray[i])){
                                ok = true;
                            } 
                        }
                        if(ok){%>
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
                                        <button href="#" id="login" 
                                        <%if(registro.getStock() < 1){%>
                                        disabled
                                        <%}%>
                                        >Comprar</button>
                                        <button 
                                        <%if(registro.getStock() < 1 || sesion.getAttribute("esadmin") != "no"){%>
                                        disabled
                                        <%}%>   
                                        >Eliminar del carro</button>
                                    </div>
                                </div>
                    <%}}%>
                </div>
            </div>
        </div>
        <div id="loginModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <div> 
                    <%if(sesion.getAttribute("esadmin") == "no"){%>
                        <form action="../PedidoDAO" method="POST"> 
                            <br>
                            <h2 style="margin-top: 0px; margin-bottom: 5px;">Introduzca la dirección para el envío</h2>
                            <label>Calle:</label><br>
                            <input type="text" name="calle" placeholder="Calle..." required><br>
                            <label>Ciudad:</label><br>
                            <input type="text" name="ciudad" placeholder="Ciudad..." required><br>
                            <label>Estado:</label><br>
                            <input type="text" name="estado" placeholder="Estado..." required><br>
                            <label>Código postal:</label><br>
                            <input type="text" name="codigopostal" placeholder="Código postal..." required><br>
                            <br>
                            <h2 style="margin-top: 5px; margin-bottom: 5px;">Introduzca la información de pago</h2>
                            <div class="cualpago">
                                <img src="../imagenes/m1.png"><img src="../imagenes/m2.png"><img src="../imagenes/m3.jpg">
                            </div>
                            <label>Titular de la tarjeta:</label><br>
                            <input type="text" name="t1"><br>
                            <label>Número de la tarjeta:</label><br>
                            <input type="number" name="t2"><br>
                            <label>CVC / CVV:</label><br>
                            <input type="number" name="t3"><br>
                            <button type="submit" name="Comprar">Realizar el pedido <img src="../imagenes/loginicon.png"></button><br>
                        </form>
                    <%} else {%>
                        <label style="color: red;">Para poder realizar un pedido, primero debe iniciar sesión con su cuenta de usuario</label><br>
                    <%}%>
                </div> 
            </div>
        </div>        
    </body>
</html>
