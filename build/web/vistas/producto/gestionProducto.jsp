<%-- 
    Document   : gestionProducto
    Created on : 04-dic-2021, 17:31:54
    Author     : PcCom
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
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
        ProductoJpaController control = new ProductoJpaController();
        List<Producto> datos = control.findProductoEntities();
        HttpSession sesion = request.getSession();
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
        <h2>Gestionar productos</h2>
        <p>Si se añade un nuevo producto o modifica un disco a otro diferente, el diseñador del código de la web, se encargara de añadir la imagen del disco a la carpeta local de imágenes de la aplicación cuanto antes</p>
        <h3>Registrar un producto</h3>
        <form action='../../ProductoDAO' method='POST'>
            <p>Categoría: <input type='text' name='categoria' required/></p>
            <p>Autor: <input type='text' name='autor' required/></p>
            <p>Nombre: <input type='text' name='nombre' required/></p>
            <p>4 mejores canciones que el disco contiene, sepárelas con un espacio por favor: <input type='text' name='contenido' required/></p>
            <p>Precio: <input type="number" min="0.00" max="10000.00" step="0.01" name='precio' required/>€</p>
            <p>Precio para cuentas premium: <input type="number" min="0.00" max="10000.00" step="0.01" name='preciopremium' required/>€</p>
            <p>Precio de envió: <input type="number" min="0.00" max="10000.00" step="0.01" name='precioenvio' required/>€</p>
            <p>Descuento, si es 0, no tiene descuento: <input type="number" min="0" max="75" name='descuento' required/>%</p>
            <p>Stock actual: <input type="number" min="0" name='stock' required/> unidades</p>
            <p><input type='submit' name='Registrar' value='Registrar'/></p>
        </form>
        <h3>Modificar un producto</h3>
        <form action='modProducto.jsp' method='GET'>
            <p>Nombre del disco: 
            <select name="idpro">
            <%for(Producto registro : datos){%>
                <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='mod' value='Modificar'/></p>
        </form>
        <h3>Eliminar un producto</h3>
        <form action='../../ProductoDAO' method='POST'>
            <p>Nombre del disco: 
            <select name="idpro">
            <%for(Producto registro : datos){%>
                <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Eliminar' value='Eliminar'/></p>
        </form>
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
            <%for(Producto registro : datos){%>
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
    </body>
</html>

