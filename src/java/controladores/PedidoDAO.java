/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Pedido;
import modelo.PedidoJpaController;
import modelo.Producto;
import modelo.ProductoJpaController;
import modelo.Usuario;
import modelo.UsuarioJpaController;

/**
 *
 * @author PcCom
 */
public class PedidoDAO extends HttpServlet {
    PedidoJpaController controlcon = new PedidoJpaController();
    Pedido pedido = new Pedido();
    UsuarioJpaController controlUsuario = new UsuarioJpaController();
    List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
    ProductoJpaController controlProducto = new ProductoJpaController();
    List<Producto> datosProducto = controlProducto.findProductoEntities();
    String mensaje = "";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PedidoDAO</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PedidoDAO at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        mensaje = "";
        if(request.getParameter("Registrar") != null){
            String estafecha = request.getParameter("fechacompra").toString();
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechacompra;
            try {
                fechacompra = simpleDateFormat.parse(estafecha);
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/gestionPedido.jsp");
                return;
            }
            String estadoentrega = request.getParameter("estadoentrega").toString();
            String idusuario = request.getParameter("idusuario").toString();
            Usuario idusuariop = controlUsuario.findUsuario(idusuario);
            int idproducto = parseInt(request.getParameter("idproducto"));
            Producto idproductop = controlProducto.findProducto(idproducto);
            int cantidadpedida = parseInt(request.getParameter("cantidadpedida"));
            String calle = request.getParameter("calle").toString();
            String ciudad = request.getParameter("ciudad").toString();
            String estado = request.getParameter("estado").toString();
            String codigopostal = request.getParameter("codigopostal").toString();
            try{
                pedido.setFechacompra(fechacompra);
                pedido.setEstadoentrega(estadoentrega);
                pedido.setIdusuario(idusuariop);
                pedido.setIdproducto(idproductop);
                pedido.setCantidadpedida(cantidadpedida);
                pedido.setCalle(calle);
                pedido.setCiudad(ciudad);
                pedido.setEstado(estado);
                pedido.setCodigopostal(codigopostal);
                controlcon.create(pedido);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/gestionPedido.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/gestionPedido.jsp");
                return;
            }
        }
        if(request.getParameter("Modificar") != null){
            int idpedido = parseInt(request.getParameter("sidpedido"));
            String estafecha;
            if(request.getParameter("fechacompra").toString().isEmpty()){
                estafecha = sesion.getAttribute("sfechacompra").toString();
            } else {
                estafecha = request.getParameter("fechacompra").toString();
            }
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechacompra;
            try {
                fechacompra = simpleDateFormat.parse(estafecha);
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/modPedido.jsp");
                return;
            }
            String estadoentrega;
            if(request.getParameter("estadoentrega").toString().isEmpty()){
                estadoentrega = sesion.getAttribute("sestadoentrega").toString();
            } else {
                estadoentrega = request.getParameter("estadoentrega").toString();
            }
            String idusuario;
            if(request.getParameter("idusuario").toString().isEmpty()){
                idusuario = sesion.getAttribute("sidusuario").toString();
            } else {
                idusuario = request.getParameter("idusuario").toString();
            }
            Usuario idusuariop = controlUsuario.findUsuario(idusuario);
            int idproducto;
            if(request.getParameter("idproducto").toString().isEmpty()){
                idproducto = parseInt(sesion.getAttribute("sidproducto").toString());
            } else {
                idproducto = parseInt(request.getParameter("idproducto"));
            }
            Producto idproductop = controlProducto.findProducto(idproducto);
            int cantidadpedida;
            if(request.getParameter("cantidadpedida").toString().isEmpty()){
                cantidadpedida = parseInt(sesion.getAttribute("scantidadpedida").toString());
            } else {
                cantidadpedida = parseInt(request.getParameter("cantidadpedida"));
            }
            String calle;
            if(request.getParameter("calle").toString().isEmpty()){
                calle = sesion.getAttribute("scalle").toString();
            } else {
                calle = request.getParameter("calle").toString();
            }
            String ciudad;
            if(request.getParameter("ciudad").toString().isEmpty()){
                ciudad = sesion.getAttribute("sciudad").toString();
            } else {
                ciudad = request.getParameter("ciudad").toString();
            }
            String estado;
            if(request.getParameter("estado").toString().isEmpty()){
                estado = sesion.getAttribute("sestado").toString();
            } else {
                estado = request.getParameter("estado").toString();
            }
            String codigopostal;
            if(request.getParameter("codigopostal").toString().isEmpty()){
                codigopostal = sesion.getAttribute("scodigopostal").toString();
            } else {
                codigopostal = request.getParameter("codigopostal").toString();
            }
            try{
                pedido.setIdpedido(idpedido);
                pedido.setFechacompra(fechacompra);
                pedido.setEstadoentrega(estadoentrega);
                pedido.setIdusuario(idusuariop);
                pedido.setIdproducto(idproductop);
                pedido.setCantidadpedida(cantidadpedida);
                pedido.setCalle(calle);
                pedido.setCiudad(ciudad);
                pedido.setEstado(estado);
                pedido.setCodigopostal(codigopostal);
                controlcon.edit(pedido);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/modPedido.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/modPedido.jsp");
                return;
            }
        }
        if(request.getParameter("Eliminar") != null){
            int idpedido = parseInt(request.getParameter("sidpedido"));
            try{
                controlcon.destroy(idpedido);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/gestionPedido.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/pedido/gestionPedido.jsp");
                return;
            }
        }
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
