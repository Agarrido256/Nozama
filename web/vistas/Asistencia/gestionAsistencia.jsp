<%-- 
    Document   : gestionAsistencia
    Created on : 07-dic-2021, 16:13:02
    Author     : PcCom
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Administrador"%>
<%@page import="modelo.AdministradorJpaController"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page import="modelo.Asistencia"%>
<%@page import="java.util.List"%>
<%@page import="modelo.AsistenciaJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
        AsistenciaJpaController controlAsistencia = new AsistenciaJpaController();
        List<Asistencia> datosAsistencia = controlAsistencia.findAsistenciaEntities();
        ProductoJpaController controlProducto = new ProductoJpaController();
        List<Producto> datosProducto = controlProducto.findProductoEntities();
        UsuarioJpaController controlUsuario = new UsuarioJpaController();
        List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
        AdministradorJpaController controlAdministrador = new AdministradorJpaController();
        List<Administrador> datosAdministrador = controlAdministrador.findAdministradorEntities();
        HttpSession sesion = request.getSession();
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        if(sesion.getAttribute("mensaje") == "y"){
            out.print("<script>alert('Orden Realizada!');</script>");
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
    %>
    <body>
        <a href="../tablas.jsp">Volver</a><br>
        <p>Introduzca los datos y seleccione la acción, en el caso de que quiera eliminar o modificar un registro,
            solo es necesario declarar el <strong>id identificador del registro en cuestión</strong></p>
        <h2>Gestionar Asistencias</h2>
        <h3>Registrar un ticket de asistencia</h3>
        <form action='../../AsistenciaDAO' method='POST'>
            <p>Asunto: <input type='text' name='asunto' required/></p>
            <p>Descripción: <input type='text' name='descripcion' required/></p>
            <p>Estado: <input type='text' name='estado' required/></p>
            <p>Id del comprador que pide ayuda: 
            <select name="idusuario">
            <%for(Usuario registro : datosUsuario){%>
                <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
            <%}%>
            </select>
            </p>
            <p>Nombre del producto con el que existe el problema: 
            <select name="idpproducto">
            <%for(Producto registro : datosProducto){%>
                <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
            <%}%>
            </select>
            </p>
            <p>Id del administrador que responde: 
            <select name="idadministrador">
            <%for(Administrador registro : datosAdministrador){%>
                <option value='<%= registro.getIdadmin()%>'><%= registro.getIdadmin()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Registrar' value='Registrar'/></p>
        </form>
        <h3>Modificar un producto</h3>
        <form action='modAsistencia.jsp' method='GET'>
            <p>Número del ticket de asistencia: (fíjese en la tabla de abajo)  
            <select name="idasistencia">
            <%for(Asistencia registro : datosAsistencia){%>
                <option value='<%= registro.getIdasistencia()%>'><%= registro.getIdasistencia()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='mod' value='Modificar'/></p>
        </form>
        <h3>Eliminar un pedido</h3>
        <form action='../../AsistenciaDAO' method='POST'>
            <p>Número del ticket de asistencia: (fíjese en la tabla de abajo)  
            <select name="idasistencia">
            <%for(Asistencia registro : datosAsistencia){%>
                <option value='<%= registro.getIdasistencia()%>'><%= registro.getIdasistencia()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Eliminar' value='Eliminar'/></p>
        </form>
        <h3>Tabla Asistencia</h3>
        <table>
            <tr>
                <th>
                    Asistencia número
                </th>
                <th>
                    Asunto
                </th>
                <th>
                    Descripción
                </th>
                <th>
                    Estado
                </th>
                <th>
                    Id del usuario
                </th>
                <th>
                    Id del producto
                </th>
                <th>
                    Id del administrador
                </th>
            </tr>
            <%for(Asistencia registro : datosAsistencia){%>
            <tr>
                <td>
                    <%= registro.getIdasistencia()%>
                </td>
                <td>
                    <%= registro.getAsunto()%>
                </td>
                <td>
                    <%= registro.getEstado()%>
                </td>
                <td>
                    <%= registro.getIdusuario().getIduser()%>
                </td>
                <td>
                    <%= registro.getIdpprodcuto().getIdpro()%>
                </td>
                <td>
                    <%= registro.getIdadministrador().getIdadmin()%>
                </td>
            </tr>
            <%}%>
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
            <%for(Usuario registro : datosUsuario){%>
            <tr>
                <td>
                    <%= registro.getIduser()%>
                </td>
                <td>
                    <%= registro.getNombre()%>
                </td>
                <td>
                    <%= registro.getApellidos()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechanac())%>
                </td>
                <td>
                    <%= registro.getPremium()%>
                </td>
                <%if(registro.getFechacadpremium() == null){%>
                <td>

                </td>
                <%} else {%>
                <td>
                    <%= simpleDateFormat.format(registro.getFechacadpremium())%>
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
            <%for(Producto registro : datosProducto){%>
            <tr>
                <td>
                    <%= registro.getIdpro()%>
                </td>
                <td>
                    <%= registro.getCategoria()%>
                </td>
                <td>
                    <%= registro.getAutor()%>
                </td>
                <td>
                    <%= registro.getImg()%>
                </td>
                <td>
                    <%= registro.getNombre()%>
                </td>
                <td>
                    <%= registro.getContenido()%>
                </td>
                <td>
                    <%= registro.getPrecio()%>
                </td>
                <td>
                    <%= registro.getPreciopremium()%>
                </td>
                <td>
                    <%= registro.getPrecioenvio()%>
                </td>
                <td>
                    <%= registro.getDescuento()%>
                </td>
                <td>
                    <%= registro.getStock()%>
                </td>
            </tr>
            <%}%>
        </table><br>
        <h3>Tabla Administrador</h3>
        <table>
            <tr>
                <th>
                    Id del Administrador
                </th>
                <th>
                    Nombre
                </th>
                <th>
                    Apellidos(fíjese en la tabla de abajo) 
                </th>
                <th>
                    Fecha de nacimiento
                </th>
                <th>
                    Fecha de contrato
                </th>
            </tr>
            <%for(Administrador registro : datosAdministrador){%>
            <tr>
                <td>
                    <%= registro.getIdadmin()%>
                </td>
                <td>
                    <%= registro.getNombre()%>
                </td>
                <td>
                    <%= registro.getApellidos()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechanac())%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechacontrato())%>
                </td>
            </tr>
            <%}%>
        </table><br>
    </body>
</html>

