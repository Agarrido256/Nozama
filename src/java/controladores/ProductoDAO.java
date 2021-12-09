/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Producto;
import modelo.ProductoJpaController;

/**
 *
 * @author PcCom
 */
public class ProductoDAO extends HttpServlet {
    ProductoJpaController controlcon = new ProductoJpaController();
    Producto producto = new Producto();
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
            out.println("<title>Servlet ProductoDAO</title>");            
            out.println("</head>");
            out.println("<body>");
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
            String categoria = request.getParameter("categoria").toString();
            String autor = request.getParameter("autor").toString();
            String nombre = request.getParameter("nombre").toString();
            String img = nombre + ".PNG";
            String contenido = request.getParameter("contenido").toString();
            String esteprecio = request.getParameter("precio").toString();
            esteprecio = esteprecio.replace(".", ",");
            if(esteprecio.contains(",")){
                String decimales = esteprecio.substring(esteprecio.indexOf(",")+1);
                if(decimales.length() == 1){
                    esteprecio = esteprecio + "0";
                }
            }
            esteprecio = esteprecio + "€";
            String precio = esteprecio;
            esteprecio = request.getParameter("preciopremium").toString();
            esteprecio = esteprecio.replace(".", ",");
            if(esteprecio.contains(",")){
                String decimales = esteprecio.substring(esteprecio.indexOf(",")+1);
                if(decimales.length() == 1){
                    esteprecio = esteprecio + "0";
                }
            }
            esteprecio = esteprecio + "€";
            String preciopremium = esteprecio;
            esteprecio = request.getParameter("precioenvio").toString();
            esteprecio = esteprecio.replace(".", ",");
            if(esteprecio.contains(",")){
                String decimales = esteprecio.substring(esteprecio.indexOf(",")+1);
                if(decimales.length() == 1){
                    esteprecio = esteprecio + "0";
                }
            }
            esteprecio = esteprecio + "€";
            String precioenvio = esteprecio;
            int descuento = parseInt(request.getParameter("descuento"));
            int stock = parseInt(request.getParameter("stock"));
            try{
                producto.setCategoria(categoria);
                producto.setAutor(autor);
                producto.setImg(img);
                producto.setNombre(nombre);
                producto.setContenido(contenido);
                producto.setPrecio(precio);
                producto.setPreciopremium(preciopremium);
                producto.setPrecioenvio(precioenvio);
                producto.setDescuento(descuento);
                producto.setStock(stock);
                controlcon.create(producto);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/producto/gestionProducto.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/producto/gestionProducto.jsp");
                return;
            }
        }
        if(request.getParameter("Modificar") != null){
            int idpro = parseInt(sesion.getAttribute("sidpro").toString());
            String categoria;
            if(request.getParameter("categoria").toString().isEmpty()){
                categoria = sesion.getAttribute("scategoria").toString();
            } else {
                categoria = request.getParameter("categoria").toString();
            }
            String autor;
            if(request.getParameter("autor").toString().isEmpty()){
                autor = sesion.getAttribute("sautor").toString();
            } else {
                autor = request.getParameter("autor").toString();
            }
            String nombre;
            if(request.getParameter("nombre").toString().isEmpty()){
                nombre = sesion.getAttribute("snombre").toString();
            } else {
                nombre = request.getParameter("nombre").toString();
            }
            String img = nombre + ".PNG";
            String contenido;
            if(request.getParameter("contenido").toString().isEmpty()){
                contenido = sesion.getAttribute("scontenido").toString();
            } else {
                contenido = request.getParameter("contenido").toString();
            }
            String precio;
            if(request.getParameter("precio").toString().isEmpty()){
                precio = sesion.getAttribute("sprecio").toString();
            } else {
                String esteprecio = request.getParameter("precio").toString();
                esteprecio = esteprecio.replace(".", ",");
                if(esteprecio.contains(",")){
                    String decimales = esteprecio.substring(esteprecio.indexOf(",")+1);
                    if(decimales.length() == 1){
                        esteprecio = esteprecio + "0";
                    }
                }
                esteprecio = esteprecio + "€";
                precio = esteprecio;
            }
            String preciopremium;
            if(request.getParameter("preciopremium").toString().isEmpty()){
                preciopremium = sesion.getAttribute("spreciopremium").toString();
            } else {
                String esteprecio = request.getParameter("preciopremium").toString();
                esteprecio = esteprecio.replace(".", ",");
                if(esteprecio.contains(",")){
                    String decimales = esteprecio.substring(esteprecio.indexOf(",")+1);
                    if(decimales.length() == 1){
                        esteprecio = esteprecio + "0";
                    }
                }
                esteprecio = esteprecio + "€";
                preciopremium = esteprecio;
            }
            String precioenvio;
            if(request.getParameter("precioenvio").toString().isEmpty()){
                precioenvio = sesion.getAttribute("sprecioenvio").toString();
            } else {
                String esteprecio = request.getParameter("precioenvio").toString();
                esteprecio = esteprecio.replace(".", ",");
                if(esteprecio.contains(",")){
                    String decimales = esteprecio.substring(esteprecio.indexOf(",")+1);
                    if(decimales.length() == 1){
                        esteprecio = esteprecio + "0";
                    }
                }
                esteprecio = esteprecio + "€";
                precioenvio = esteprecio;
            }
            int descuento;
            if(request.getParameter("descuento").toString().isEmpty()){
                descuento = parseInt(sesion.getAttribute("sdescuento").toString());
            } else {
                descuento = parseInt(request.getParameter("descuento"));
            }
            int stock;
            if(request.getParameter("stock").toString().isEmpty()){
                stock = parseInt(sesion.getAttribute("sstock").toString());
            } else {
                stock = parseInt(request.getParameter("stock"));
            }
            try{
                producto.setIdpro(idpro);
                producto.setCategoria(categoria);
                producto.setAutor(autor);
                producto.setImg(img);
                producto.setNombre(nombre);
                producto.setContenido(contenido);
                producto.setPrecio(precio);
                producto.setPreciopremium(preciopremium);
                producto.setPrecioenvio(precioenvio);
                producto.setDescuento(descuento);
                producto.setStock(stock);
                controlcon.edit(producto);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/producto/modProducto.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/producto/modProducto.jsp");
                return;
            }
        }
        if(request.getParameter("Eliminar") != null){
            int idpro = parseInt(request.getParameter("idpro").toString());
            try{
                controlcon.destroy(idpro);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/producto/gestionProducto.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/producto/gestionProducto.jsp");
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
