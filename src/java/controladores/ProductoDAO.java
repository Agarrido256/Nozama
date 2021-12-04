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
    private ProductoJpaController controlcon = new ProductoJpaController();
    private Producto producto = new Producto();
    private String mensaje = "";
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
            String img = request.getParameter("img").toString();
            String nombre = request.getParameter("nombre").toString();
            String contenido = request.getParameter("contenido").toString();
            String precio = request.getParameter("precio").toString();
            String preciopremium = request.getParameter("preciopremium").toString();
            String precioenvio = request.getParameter("precioenvio").toString();
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
                response.sendRedirect("vistas/administrador/gestionProducto.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/administrador/gestionProducto.jsp");
                return;
            }
        }
        if(request.getParameter("Modificar") != null){
            //EEEEEEEEEEEEEEEEE
            String idadmin = sesion.getAttribute("sidadmin").toString();
            String nombre;
            if(request.getParameter("nombre").toString().isEmpty()){
                nombre = sesion.getAttribute("snombre").toString();
            } else {
                nombre = request.getParameter("nombre").toString();
            }
            String apellidos;
            if(request.getParameter("apellidos").toString().isEmpty()){
                apellidos = sesion.getAttribute("sapellidos").toString();
            } else {
                apellidos = request.getParameter("apellidos").toString();
            }
            String contrasena;
            if(request.getParameter("contrasena").toString().isEmpty()){
                contrasena = sesion.getAttribute("scontrasena").toString();
            } else {
                contrasena = request.getParameter("contrasena").toString();
            }
            String estafecha;
            if(request.getParameter("fechanac").toString().isEmpty()){
                estafecha = sesion.getAttribute("sfechanac").toString();
            } else {
                estafecha = request.getParameter("fechanac").toString();
            }
            String estafechac;
            if(request.getParameter("fechacontrato").toString().isEmpty()){
                estafechac = sesion.getAttribute("sfechacontrato").toString();
            } else {
                estafechac = request.getParameter("fechacontrato").toString();
            }
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechanac;
            Date fechacontrato;
            try {
                fechanac = simpleDateFormat.parse(estafecha);
                fechacontrato = simpleDateFormat.parse(estafechac);
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/administrador/modAdministrador.jsp");
                return;
            }
            sesion.removeAttribute("sidadmin");
            sesion.removeAttribute("snombre");
            sesion.removeAttribute("sapellidos");
            sesion.removeAttribute("sfechanac");
            sesion.removeAttribute("scontrasena");
            sesion.removeAttribute("sfechacontrato");
            try{
                administrador.setIdadmin(idadmin);
                administrador.setNombre(nombre);
                administrador.setApellidos(apellidos);
                administrador.setFechanac(fechanac);
                administrador.setContraseña(contrasena);
                administrador.setFechacontrato(fechacontrato);
                controlcon.edit(administrador);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/administrador/modAdministrador.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/administrador/modAdministrador.jsp");
                return;
            }
        }
        if(request.getParameter("Eliminar") != null){
            String idadmin = request.getParameter("idadmin").toString();
            try{
                controlcon.destroy(idadmin);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/administrador/gestionAdministrador.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/administrador/gestionAdministrador.jsp");
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
