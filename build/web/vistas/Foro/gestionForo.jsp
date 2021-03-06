<%-- 
    Document   : gestionForo
    Created on : 07-dic-2021, 17:34:56
    Author     : PcCom
--%>

<%@page import="funciones.Arreglos"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page import="modelo.Foro"%>
<%@page import="java.util.List"%>
<%@page import="modelo.ForoJpaController"%>
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
        Arreglos fix = new Arreglos();
        ForoJpaController controlForo = new ForoJpaController();
        List<Foro> datosForo = controlForo.findForoEntities();
        ProductoJpaController controlProducto = new ProductoJpaController();
        List<Producto> datosProducto = controlProducto.findProductoEntities();
        UsuarioJpaController controlUsuario = new UsuarioJpaController();
        List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
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
        <p>Introduzca los datos y seleccione la acci??n, en el caso de que quiera eliminar o modificar un registro,
            solo es necesario declarar el <strong>id identificador del registro en cuesti??n</strong></p>
        <h2>Gestionar Foro</h2>
        <h3>Registrar una opini??n en el foro</h3>
        <form action='../../ForoDAO' method='POST'>
            <p>Asunto: <input type='text' name='asunto' required/></p>
            <p>Descripci??n: <input type='text' name='descripcion' required/></p>
            <p>Puncuaci??n: <input type="number" min="1" max="5" name='puntuacion' required/></p>
            <p>Id del usuario que ha publicado la opini??n: 
            <select name="idusuario">
            <%for(Usuario registro : datosUsuario){%>
                <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
            <%}%>
            </select>
            </p>
            <p>Nombre del producto en el que se ha publicado la opini??n: 
            <select name="idpproducto">
            <%for(Producto registro : datosProducto){%>
                <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Registrar' value='Registrar'/></p>
        </form>
        <h3>Modificar un foro</h3>
        <form action='modForo.jsp' method='GET'>
            <p>N??mero identificativo del foro: (f??jese en la tabla de abajo)  
            <select name="idforo">
            <%for(Foro registro : datosForo){%>
                <option value='<%= registro.getIdforo()%>'><%= registro.getIdforo()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='mod' value='Modificar'/></p>
        </form>
        <h3>Eliminar un foro</h3>
        <form action='../../ForoDAO' method='POST'>
            <p>N??mero identificativo del foro: (f??jese en la tabla de abajo)  
            <select name="idforo">
            <%for(Foro registro : datosForo){%>
                <option value='<%= registro.getIdforo()%>'><%= registro.getIdforo()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Eliminar' value='Eliminar'/></p>
        </form>
        <h3>Tabla Foro</h3>
        <table>
            <tr>
                <th>
                    Foro n??mero
                </th>
                <th>
                    Asunto
                </th>
                <th>
                    Descripci??n
                </th>
                <th>
                    Puntuaci??n
                </th>
                <th>
                    Id del usuario
                </th>
                <th>
                    Id del producto
                </th>
            </tr>
            <%for(Foro registro : datosForo){%>
            <tr>
                <td>
                    <%= registro.getIdforo()%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getAsunto())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getDescripcion())%>
                </td>
                <td>
                    <%= registro.getPuntuacion()%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getIdusuario().getIduser())%>
                </td>
                <td>
                    <%= registro.getIdpprodcuto().getIdpro()%>
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
                    ??Cuenta premium?
                </th>
                <th>
                    Fecha de caducidad de cuenta premium
                </th>
            </tr>
            <%for(Usuario registro : datosUsuario){%>
            <tr>
                <td>
                    <%= fix.fixtexto(registro.getIduser())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getNombre())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getApellidos())%>
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
                    Producto n??mero
                </th>
                <th>
                    Categor??a
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
                    Precio de envi??
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
                    <%= fix.fixtexto(registro.getCategoria())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getAutor())%>
                </td>
                <td>
                    <%= registro.getImg()%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getNombre())%>
                </td>
                <td>
                    <%= fix.fixtexto(registro.getContenido())%>
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
    </body>
</html>

