<%-- 
    Document   : index
    Created on : 26-oct-2021, 14:34:45
    Author     : PcCom
--%>

<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page import="modelo.Administrador"%>
<%@page import="java.util.List"%>
<%@page import="modelo.AdministradorJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nozama</title>
        <link rel="icon" href="imagenes/favicon.png">
        <link rel="stylesheet" href="diseño/css.css">
        <script src="diseño/js.js"></script>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            AdministradorJpaController controlAdmin = new AdministradorJpaController();
            List<Administrador> datosAdministrador = controlAdmin.findAdministradorEntities();
            UsuarioJpaController controlUsu = new UsuarioJpaController();
            List<Usuario> datosUsuario = controlUsu.findUsuarioEntities();
            if(request.getParameter("Logearse") != null){
                String usuario = request.getParameter("user").toString();
                String contra = request.getParameter("pass").toString();
                for(Administrador registro : datosAdministrador){
                    if(registro.getIdadmin().equals(usuario) && registro.getContraseña().equals(contra)){
                        sesion.setAttribute("user", usuario);
                        sesion.setAttribute("userpass", contra);
                        sesion.setAttribute("esadmin", "si"); //no uso boolean porque luego el if no le gusta los boolean de sesion
                        sesion.setAttribute("n", registro.getNombre());
                        response.sendRedirect("index.jsp");
                    }
                }
                for(Usuario registro : datosUsuario){
                    if(registro.getIduser().equals(usuario) && registro.getContraseña().equals(contra)){
                        sesion.setAttribute("user", usuario);
                        sesion.setAttribute("userpass", contra);
                        sesion.setAttribute("esadmin", "no");
                        sesion.setAttribute("n", registro.getNombre());
                        response.sendRedirect("index.jsp");
                    }
                }
                out.print("<script>alert('Usuario o clave no valida!');</script>");
            }
            if(request.getParameter("cerrarsesion") != null){
                sesion.invalidate();
                response.sendRedirect("index.jsp");
            } //java.lang.IllegalStateException: getAttribute: Session already invalidated
        %>
        <div class="base">
            <header>
                <a href=""><img src="imagenes/logo.PNG"></a>
                <div class="buscador"></div>
                <div class="divlogin"><a href="#" id="login">
                    <%if(sesion.getAttribute("user") == null){%>
                        Iniciar sesión
                    <%} else {%>
                        Bienvenido <%= sesion.getAttribute("n")%>
                    <%}%>
                </a><br>
                    <%if(sesion.getAttribute("esadmin") == "si") {%>
                        <a href="index.jsp?cerrarsesion=true">Cerrar sesión</a><br>
                        <a href="#">Administración</a>
                    <%} else if(sesion.getAttribute("esadmin") == "no") {%>
                        <a href="index.jsp?cerrarsesion=true">Cerrar sesión</a>
                    <%}%>
                </div>
            </header>
            <nav>
                <p style="font-weight: bold; margin-top: 5px;"><a href="">nav</a> | <a href="">nav</a> | <a href="">nav</a></p>
            </nav>
            <section>
                <article>
                    
                </article>
                <footer>
                    <div class="foot1">
                        <h2>Conócenos</h2>
                        <a href="">Trabajar en Nozama</a><br>
                        <a href="">Sobre Nosotros</a>
                    </div>
                    <div class="foot2">
                        <h2>Métodos de pago en Nozama</h2>
                        <a href="">Métodos de pago</a><br>
                        <a href="">¿Problemas con el pago?</a>
                    </div>
                    <div class="foot3">
                        <h2>¿Necesitas ayuda?</h2>
                        <a href="">Atención al Cliente</a>
                    </div>
                    <img src="imagenes/logofixed.PNG">
                </footer>
            </section>
        </div>
        <div id="loginModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <div> 
                    <%if(sesion.getAttribute("user") == null){%>
                        <form action="index.jsp" method="POST"> 
                            <br>
                            <label for="inputEmail">Nombre de cuenta:</label><br>
                            <input type="text" name="user" placeholder="Escriba su nombre de cuenta..."><br>
                            <label for="inputPassword">Contraseña:</label><br>
                            <input type="password" name="pass" placeholder="Escriba su contraseña..."><br>
                            <br>
                            <button type="submit" name="Logearse">ACCEDER <img src="imagenes/loginicon.png"></button><br>
                            <p><a href="" style="color:cornflowerblue">¿Has olvidado la contraseña?</a></p> 
                        </form>
                    <%} else {%>
                        <h2>Opciones de cuenta</h2>
                        <a href="#" style="color: rgb(246,167,96);">Cambiar contraseña</a><br>
                        <a href="#" style="color: rgb(246,167,96);">Cambiar parámetros de la cuenta</a><br>
                        <a href="index.jsp?cerrarsesion=true" style="color: rgb(246,167,96);">Cerrar sesión</a>
                    <%}%>
                </div> 
            </div>
        </div>
    </body>
</html>
