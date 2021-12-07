/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Foro;
import modelo.ForoJpaController;
import modelo.Producto;
import modelo.ProductoJpaController;
import modelo.Usuario;
import modelo.UsuarioJpaController;

/**
 *
 * @author PcCom
 */
public class ForoDAO extends HttpServlet {
    ForoJpaController controlcon = new ForoJpaController();
    Foro foro = new Foro();
    ProductoJpaController controlProducto = new ProductoJpaController();
    List<Producto> datosProducto = controlProducto.findProductoEntities();
    UsuarioJpaController controlUsuario = new UsuarioJpaController();
    List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
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
            out.println("<title>Servlet ForoDAO</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForoDAO at " + request.getContextPath() + "</h1>");
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
            String asunto = request.getParameter("asunto").toString();
            String descripcion = request.getParameter("descripcion").toString();
            int puntuacion = parseInt(request.getParameter("puntuacion"));
            String idusuario = request.getParameter("idusuario").toString();
            Usuario idusuariop = controlUsuario.findUsuario(idusuario);
            int idpproducto = parseInt(request.getParameter("idproducto"));
            Producto idpproductop = controlProducto.findProducto(idpproducto);
            try{
                foro.setAsunto(asunto);
                foro.setDescripcion(descripcion);
                foro.setPuntuacion(puntuacion);
                foro.setIdusuario(idusuariop);
                foro.setIdpprodcuto(idpproductop);
                controlcon.create(foro);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/foro/gestionForo.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/foro/gestionForo.jsp");
                return;
            }
        }
        if(request.getParameter("Modificar") != null){
            int idforo = parseInt(request.getParameter("idforo"));
            String asunto;
            if(request.getParameter("asunto").toString().isEmpty()){
                asunto = sesion.getAttribute("sasunto").toString();
            } else {
                asunto = request.getParameter("asunto").toString();
            }
            String descripcion;
            if(request.getParameter("descripcion").toString().isEmpty()){
                descripcion = sesion.getAttribute("sdescripcion").toString();
            } else {
                descripcion = request.getParameter("descripcion").toString();
            }
            int puntuacion;
            if(request.getParameter("puntuacion").toString().isEmpty()){
                puntuacion = parseInt(sesion.getAttribute("spuntuacion").toString());
            } else {
                puntuacion = parseInt(request.getParameter("puntuacion"));
            }
            String idusuario;
            if(request.getParameter("idusuario").toString().isEmpty()){
                idusuario = sesion.getAttribute("sidusuario").toString();
            } else {
                idusuario = request.getParameter("idusuario").toString();
            }
            Usuario idusuariop = controlUsuario.findUsuario(idusuario);
            int idpproducto;
            if(request.getParameter("idpproducto").toString().isEmpty()){
                idpproducto = parseInt(sesion.getAttribute("sidpproducto").toString());
            } else {
                idpproducto = parseInt(request.getParameter("idpproducto"));
            }
            Producto idpproductop = controlProducto.findProducto(idpproducto);
            try{
                foro.setIdforo(idforo);
                foro.setAsunto(asunto);
                foro.setDescripcion(descripcion);
                foro.setPuntuacion(puntuacion);
                foro.setIdusuario(idusuariop);
                foro.setIdpprodcuto(idpproductop);
                controlcon.edit(foro);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/foro/modForo.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/foro/modForo.jsp");
                return;
            }
        }
        if(request.getParameter("Eliminar") != null){
            int idforo = parseInt(request.getParameter("sidforo"));
            try{
                controlcon.destroy(idforo);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/foro/gestionForo.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/foro/gestionForo.jsp");
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
