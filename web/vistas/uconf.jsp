<%-- 
    Document   : uconf
    Created on : 11-dic-2021, 22:45:40
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../diseño/uconf.css">
        <script src="../diseño/mostrarproducto.js"></script>
    </head>
    <%
        UsuarioJpaController controlcon = new UsuarioJpaController();
        List<Usuario> datos = controlcon.findUsuarioEntities();
        HttpSession sesion = request.getSession();
        String pattern = "dd-MM-yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String patron = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormato = new SimpleDateFormat(patron);
        String mensaje = "";
        if(sesion.getAttribute("user") != null){
            for(Usuario registro : datos){
                if(sesion.getAttribute("user").toString().equals(registro.getIduser())){
                    sesion.setAttribute("siduser", registro.getIduser() );
                    sesion.setAttribute("snombre", registro.getNombre());
                    sesion.setAttribute("sapellidos", registro.getApellidos());
                    sesion.setAttribute("sfechanac", registro.getFechanac());
                    sesion.setAttribute("spremium", registro.getPremium());
                    sesion.setAttribute("sfechacadpremium", registro.getFechacadpremium());
                    sesion.setAttribute("scontrasena", registro.getContraseña());
                }
            }
        } else {
            response.sendRedirect("welcome.jsp");
        }
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
            for(Usuario registro : datos){
                if(registro.getIduser().equals(sesion.getAttribute("siduser"))){
                    sesion.setAttribute("snombre", registro.getNombre());
                    sesion.setAttribute("sapellidos", registro.getApellidos());
                    sesion.setAttribute("sfechanac", registro.getFechanac());
                    sesion.setAttribute("spremium", registro.getPremium());
                    sesion.setAttribute("sfechacadpremium", registro.getFechacadpremium());
                    sesion.setAttribute("scontrasena", registro.getContraseña());
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
        if(sesion.getAttribute("mensaje") == "yp"){
            out.print("<script>alert('Disfrute de su subscripción premium');</script>");
            sesion.removeAttribute("mensaje");
        }
        if(sesion.getAttribute("mensaje") == "np"){
            out.print("<script>alert('ERROR, no se ha podido comprar la subscripción');</script>");
            sesion.removeAttribute("mensaje");
        }
    %>
    <body>
        <a href="welcome.jsp">Volver</a><br><br>
        <div class="base">
            <h2>Cambiar configuración de cuenta</h2>
            <p>Recuerde que para logearse en la web deben recordar su id de usuario y contraseña</p>
            <p>Su id de cuenta es: <%= sesion.getAttribute("siduser")%></p>
            <form action='../UsuarioDAO' method='POST'>
                <p>Nombre: <input type='text' name='nombre' placeholder='<%= sesion.getAttribute("snombre")%>'></p>
                <p>Apellidos: <input type='text' name='apellidos' placeholder='<%= sesion.getAttribute("sapellidos")%>'/></p>
                <p>Fecha de nacimiento: <input type='date' name='fechanac' value='<%= simpleDateFormato.format(sesion.getAttribute("sfechanac"))%>'/></p>
                <p>Contraseña: <input type='password' name='contrasena'/></p>
                <p><input type='submit' name='Uconf' value='Modificar'/></p>
            </form>
                <%if(sesion.getAttribute("spremium").equals(false)){%>
                <h2>PREMIUM</h2>
                <p>Le ofrecemos premium, premium es una subscripción anual que permite a los usuarios pagar precios más bajos por nuestros productos, le recomendamos que se pase a premium si es un usuario común de nuestra web y disfrute del beneficio.</p>
                <button style="background-color: goldenrod;" href="#" id="login">COMPRAR SUBSCRIPCIÓN PREMIUM</button>
                <%} else {%>
                <h2>Enhorabuena, su cuenta ya dispone de una subscripción <span style="color: goldenrod">premium</span></h2>
                <%}%>
            <div id="loginModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <div> 
                    <%if(sesion.getAttribute("esadmin") == "no"){%>
                        <form action="../UsuarioDAO" method="POST"> 
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
                            <button type="submit" name="Ppremium">Comprar subscripción <img src="../imagenes/loginicon.png"></button><br>
                        </form>
                    <%} else {%>
                        <label style="color: red;">Para poder realizar un pedido, primero debe iniciar sesión con su cuenta de usuario</label><br>
                    <%}%>
                </div> 
            </div>
        </div>
    </body>
</html>
