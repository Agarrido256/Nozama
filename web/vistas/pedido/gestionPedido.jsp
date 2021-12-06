<%-- 
    Document   : gestionPedido
    Created on : 05-dic-2021, 18:16:03
    Author     : PcCom
--%>

<%@page import="modelo.Producto"%>
<%@page import="modelo.ProductoJpaController"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioJpaController"%>
<%@page import="modelo.Administrador"%>
<%@page import="modelo.AdministradorJpaController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Pedido"%>
<%@page import="java.util.List"%>
<%@page import="modelo.PedidoJpaController"%>
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
        PedidoJpaController controlPedido = new PedidoJpaController();
        List<Pedido> datosPedido = controlPedido.findPedidoEntities();
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
        <p>Introduzca los datos y seleccione la acción, en el caso de que quiera eliminar o modificar un registro,
            solo es necesario declarar el <strong>id identificador del registro en cuestión</strong></p>
        <h2>Gestionar pedidos</h2>
        <p>Si se registra un nuevo pedido en esta página de administración, no se reducirá el stock del producto en cuestión, ya que solo se usara esta función registrar para solución de posibles errores de la web</p>
        <h3>Registrar un pedido</h3>
        <form action='../../PedidoDAO' method='POST'>
            <p>Fecha de compra: <input type='date' name='fechacompra' required/></p>
            <p>Estado de la entrega: <input type='text' name='estadoentrega' required/></p>
            <p>Id del comprador: 
            <select name="idusuario">
            <%for(Usuario registro : datosUsuario){%>
                <option value='<%= registro.getIduser()%>'><%= registro.getIduser()%></option>
            <%}%>
            </select>
            </p>
            <p>Nombre del producto: 
            <select name="idproducto">
            <%for(Producto registro : datosProducto){%>
                <option value='<%= registro.getIdpro()%>'><%= registro.getNombre()%></option>
            <%}%>
            </select>
            </p>
            <p>Cantidad de unidades pedidas: <input type="number" min="1" name='cantidadpedida' required/> unidades</p>
            <p>Información del envío:</p>
            <p>Calle: <input type='text' name='calle' required/></p>
            <p>Ciudad: <input type='text' name='ciudad' required/></p>
            <p>Estado: <input type='text' name='estado' required/></p>
            <p>Código Postal: <input type='text' name='codigopostal' required/></p>
            <p><input type='submit' name='Registrar' value='Registrar'/></p>
        </form>
        <h3>Modificar un producto</h3>
        <form action='modPedido.jsp' method='GET'>
            <p>Número del pedido: (fíjese en la tabla de abajo)  
            <select name="idpedido">
            <%for(Pedido registro : datosPedido){%>
                <option value='<%= registro.getIdpedido()%>'><%= registro.getIdpedido()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='mod' value='Modificar'/></p>
        </form>
        <h3>Eliminar un pedido</h3>
        <form action='../../PedidoDAO' method='POST'>
            <p>Número del pedido: (fíjese en la tabla de abajo)  
            <select name="idpedido">
            <%for(Pedido registro : datosPedido){%>
                <option value='<%= registro.getIdpedido()%>'><%= registro.getIdpedido()%></option>
            <%}%>
            </select>
            </p>
            <p><input type='submit' name='Eliminar' value='Eliminar'/></p>
        </form>
        <h3>Tabla Pedido</h3>
        <table>
            <tr>
                <th>
                    Pedido número
                </th>
                <th>
                    Fecha de compra
                </th>
                <th>
                    Estado de la entrega
                </th>
                <th>
                    Id del comprador
                </th>
                <th>
                    Id del producto
                </th>
                <th>
                    Cantidad de unidades pedidas
                </th>
                <th>
                    Calle
                </th>
                <th>
                    Ciudad
                </th>
                <th>
                    Estado
                </th>
                <th>
                    Código Postal
                </th>
            </tr>
            <%for(Pedido registro : datosPedido){%>
            <tr>
                <td>
                    <%= registro.getIdpedido()%>
                </td>
                <td>
                    <%= simpleDateFormat.format(registro.getFechacompra())%>
                </td>
                <td>
                    <%= registro.getEstadoentrega()%>
                </td>
                <td>
                    <%= registro.getIdusuario().getIduser()%>
                </td>
                <td>
                    <%= registro.getIdproducto().getIdpro()%>
                </td>
                <td>
                    <%= registro.getCantidadpedida()%>
                </td>
                <td>
                    <%= registro.getCalle()%>
                </td>
                <td>
                    <%= registro.getCiudad()%>
                </td>
                <td>
                    <%= registro.getEstado()%>
                </td>
                <td>
                    <%= registro.getCodigopostal() %>
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
    </body>
</html>

