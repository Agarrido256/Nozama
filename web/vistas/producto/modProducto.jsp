<%-- 
    Document   : modProducto
    Created on : 04-dic-2021, 18:44:32
    Author     : PcCom
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        String mensaje = "";
        if(request.getParameter("mod") != null){
            for(Producto registro : datos){
                if(request.getParameter("idpro").equals(registro.getIdpro().toString())){
                    sesion.setAttribute("sidpro", registro.getIdpro());
                    sesion.setAttribute("scategoria", registro.getCategoria());
                    sesion.setAttribute("sautor", registro.getAutor());
                    sesion.setAttribute("simg", registro.getImg());
                    sesion.setAttribute("snombre", registro.getNombre());
                    sesion.setAttribute("scontenido", registro.getContenido());
                    sesion.setAttribute("sprecio", registro.getPrecio());
                    sesion.setAttribute("spreciopremium", registro.getPreciopremium());
                    sesion.setAttribute("sprecioenvio", registro.getPrecioenvio());
                    sesion.setAttribute("sdescuento", registro.getDescuento());
                    sesion.setAttribute("sstock", registro.getStock());
                }
            }
        }
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
        <a href="gestionProducto.jsp">Cancelar y volver</a><br>
        <p>Escriba solamente, los datos que desee cambiar del producto con el nombre: <%= sesion.getAttribute("snombre")%></p>
        <form action='../../ProductoDAO' method='POST'>
            <p>Categoría: <input type='text' name='categoria' placeholder='<%= sesion.getAttribute("scategoria")%>'/></p>
            <p>Autor: <input type='text' name='autor' placeholder='<%= sesion.getAttribute("sautor")%>'/></p>
            <p>Nombre: <input type='text' name='nombre' placeholder='<%= sesion.getAttribute("snombre")%>'/></p>
            <p>4 mejores canciones que el disco contiene, sepárelas con un espacio por favor: <input type='text' name='contenido' placeholder='<%= sesion.getAttribute("scontenido")%>'/></p>
            <p>Precio: <input type="number" min="0.00" max="10000.00" step="0.01" name='precio' placeholder='<%= sesion.getAttribute("sprecio")%>'/>€</p>
            <p>Precio para cuentas premium: <input type="number" min="0.00" max="10000.00" step="0.01" name='preciopremium' placeholder='<%= sesion.getAttribute("spreciopremium")%>'/>€</p>
            <p>Precio de envió: <input type="number" min="0.00" max="10000.00" step="0.01" name='precioenvio' placeholder='<%= sesion.getAttribute("sprecioenvio")%>'/>€</p>
            <p>Descuento, si es 0, no tiene descuento: <input type="number" min="0" max="75" name='descuento' placeholder='<%= sesion.getAttribute("sdescuento")%>'/>%</p>
            <p>Stock actual: <input type="number" min="0" name='stock' placeholder='<%= sesion.getAttribute("sstock")%>'/> unidades</p>
            <p><input type='submit' name='Modificar' value='Modificar'/></p>
        </form>
        <br>
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
            <%for(Producto registro : datos){
                if(registro.getIdpro().equals(sesion.getAttribute("sidpro"))){%>
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
            <%}}%>
        </table><br>
    </body>
</html>
