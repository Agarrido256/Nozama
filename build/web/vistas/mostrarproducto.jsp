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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../diseño/mostrarproducto.css">
        <script src="../diseño/mostrarproducto.js"></script>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            ProductoJpaController controlProducto = new ProductoJpaController();
            List<Producto> datosProducto = controlProducto.findProductoEntities();
            ForoJpaController controlForo = new ForoJpaController();
            List<Foro> datosForo = controlForo.findForoEntities();
            if(request.getParameter("esteproducto") != null){
                sesion.setAttribute("estepro", request.getParameter("esteproducto"));
            }
            if(sesion.getAttribute("mensaje") == "y"){
                response.sendRedirect("../ProductoDAO?Comprar=go");
            }
            if(sesion.getAttribute("mensaje") == "yes"){
                out.print("<script>alert('Gracias por su compra!');</script>");
                sesion.removeAttribute("mensaje");
            }
            if(sesion.getAttribute("mensaje") == "n"){
                out.print("<script>alert('ERROR, no se ha podido realizar el pedido');</script>");
                sesion.removeAttribute("mensaje");
            }
            if(request.getParameter("alcarro") != null){
                String[] carray = (String[])sesion.getAttribute("carray");
                String nuevoalcarro = request.getParameter("alcarro").toString();
                boolean yaesta = false;
                for (int i = 0; i < carray.length; i++) {
                    if(nuevoalcarro.equals(carray[i])){
                        yaesta = true;
                    }
                }
                if(!yaesta){
                    for (int i = 0; i < carray.length; i++) {
                        if(carray[i] == null){
                            carray[i] = request.getParameter("alcarro").toString();
                            sesion.setAttribute("carray", carray);
                        }
                    }
                }
                response.sendRedirect("mostrarproducto.jsp");
            }
        %>
        <div class="base">
                <div class="body">
                <%
                    for(Producto registro : datosProducto){
                    if(registro.getIdpro().toString().equals(sesion.getAttribute("estepro"))){
                    sesion.setAttribute("product", registro.getIdpro()); %>
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
                                        <br><br><br><br><br><br><br>
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
                                        <h3>Por: <%= formatoprecio.format(mostrar)%>€<br><span style="color: goldenrod;"><%= formatoprecio.format(mostrarp)%>€ para cuentas premium</span><br> <span style="color: red;">¡<%= registro.getDescuento()%>% de descuento!</span><br><span style="color: gray;"><%= registro.getPrecioenvio()%> de envió</span></h3>
                                        <%} else {%>
                                        <h3>Por: <%= formatoprecio.format(Double.parseDouble(precio))%>€<br><span style="color: goldenrod;"><%= formatoprecio.format(Double.parseDouble(preciop))%>€ para cuentas premium</span><br><span style="color: gray;"><%= registro.getPrecioenvio()%> de envió</span></h3>
                                        <%}%>
                                        <button href="#" id="login" 
                                        <%if(registro.getStock() < 1){%>
                                        disabled
                                        <%}%>
                                        >Comprar</button>
                                        <button onclick="location.href='mostrarproducto.jsp?alcarro=<%= registro.getIdpro()%>';" 
                                        <%if(registro.getStock() < 1 || sesion.getAttribute("esadmin") != "no"){%>
                                        disabled
                                        <%}%>   
                                        >Añadir al carro</button>
                                        <br>
                                        <%if(sesion.getAttribute("user") == null || sesion.getAttribute("esadmin") == "si"){%>
                                        <label style="color: red;">Primero debe logearse con su <strong>cuenta de usuario</strong></label>
                                        <%} else if(registro.getStock() < 1){%>
                                        <label style="color: red;">Lo sentimos, producto fuera de <strong>stock</strong></label>
                                        <%} else {%>
                                        <label style="color: gray;">En stock, tenemos actualmente <strong><%= registro.getStock()%></strong> unidades</label>
                                        <%}%>
                                    </div>
                                </div>
                                <div class="foro">
                                    <label style="color: red; opacity: 0.7;">*falta por implementar opiniones de los clientes</label> 
                                </div>
                    <%}}%>
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
