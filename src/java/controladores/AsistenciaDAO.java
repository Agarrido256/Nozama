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
import modelo.Administrador;
import modelo.AdministradorJpaController;
import modelo.Asistencia;
import modelo.AsistenciaJpaController;
import modelo.Producto;
import modelo.ProductoJpaController;
import modelo.Usuario;
import modelo.UsuarioJpaController;

/**
 *
 * @author PcCom
 */
public class AsistenciaDAO extends HttpServlet {
    AsistenciaJpaController controlcon = new AsistenciaJpaController();
    Asistencia asistencia = new Asistencia();
    ProductoJpaController controlProducto = new ProductoJpaController();
    List<Producto> datosProducto = controlProducto.findProductoEntities();
    UsuarioJpaController controlUsuario = new UsuarioJpaController();
    List<Usuario> datosUsuario = controlUsuario.findUsuarioEntities();
    AdministradorJpaController controlAdministrador = new AdministradorJpaController();
    List<Administrador> datosAdministrador = controlAdministrador.findAdministradorEntities();
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
            out.println("<title>Servlet AsistenciaDAO</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AsistenciaDAO at " + request.getContextPath() + "</h1>");
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
            String estado = request.getParameter("estado").toString();
            String idusuario = request.getParameter("idusuario").toString();
            Usuario idusuariop = controlUsuario.findUsuario(idusuario);
            int idpproducto = parseInt(request.getParameter("idproducto"));
            Producto idpproductop = controlProducto.findProducto(idpproducto);
            String idadministrador = request.getParameter("idusuario").toString();
            Administrador idadministradorp = controlAdministrador.findAdministrador(idadministrador);
            try{
                asistencia.setAsunto(asunto);
                asistencia.setDescripcion(descripcion);
                asistencia.setEstado(estado);
                asistencia.setIdusuario(idusuariop);
                asistencia.setIdpprodcuto(idpproductop);
                asistencia.setIdadministrador(idadministradorp);
                controlcon.create(asistencia);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/asistencia/gestionAsistencia.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/asistencia/gestionAsistencia.jsp");
                return;
            }
        }
        if(request.getParameter("Modificar") != null){
            int idasistencia = parseInt(request.getParameter("idasistencia"));
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
            String estado;
            if(request.getParameter("estado").toString().isEmpty()){
                estado = sesion.getAttribute("sestado").toString();
            } else {
                estado = request.getParameter("estado").toString();
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
            String idadministrador;
            if(request.getParameter("idadministrador").toString().isEmpty()){
                idadministrador = sesion.getAttribute("sidadministrador").toString();
            } else {
                idadministrador = request.getParameter("idadministrador").toString();
            }
            Administrador idadministradorp = controlAdministrador.findAdministrador(idadministrador);
            try{
                asistencia.setIdasistencia(idasistencia);
                asistencia.setAsunto(asunto);
                asistencia.setDescripcion(descripcion);
                asistencia.setEstado(estado);
                asistencia.setIdusuario(idusuariop);
                asistencia.setIdpprodcuto(idpproductop);
                asistencia.setIdadministrador(idadministradorp);
                controlcon.edit(asistencia);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/asistencia/modAsistencia.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/asistencia/modAsistencia.jsp");
                return;
            }
        }
        if(request.getParameter("Eliminar") != null){
            int idasistencia = parseInt(request.getParameter("sidasistencia"));
            try{
                controlcon.destroy(idasistencia);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/asistencia/gestionAsistencia.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/asistencia/gestionAsistencia.jsp");
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
