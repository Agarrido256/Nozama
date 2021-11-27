/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Administrador;
import modelo.AdministradorJpaController;

/**
 *
 * @author PcCom
 */
public class AdministradorDAO extends HttpServlet {
    private AdministradorJpaController controlcon = new AdministradorJpaController();
    private Administrador administrador = new Administrador();
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
            out.println("<title>Servlet AdministradorDAO</title>");            
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
            String idadmin = request.getParameter("idadmin").toString();
            String nombre = request.getParameter("nombre").toString();
            String apellidos = request.getParameter("apellidos").toString();
            String estafecha = request.getParameter("fechanac").toString();
            String contrasena = request.getParameter("contrasena").toString();
            String estafechac = request.getParameter("fechacontrato").toString();
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
                response.sendRedirect("vistas/tablas.jsp");
                return;
            }
            try{
                administrador.setIdadmin(idadmin);
                administrador.setNombre(nombre);
                administrador.setApellidos(apellidos);
                administrador.setFechanac(fechanac);
                administrador.setContraseña(contrasena);
                administrador.setFechacontrato(fechacontrato);
                controlcon.create(administrador);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/tablas.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/tablas.jsp");
                return;
            }
        }
        if(request.getParameter("Modificar") != null){
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
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechanac;
            Date fechacontrato;
            try {
                fechanac = simpleDateFormat.parse(request.getParameter("fechanac").toString());
                fechacontrato = simpleDateFormat.parse(request.getParameter("fechacontrato").toString());
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/modAdministrador.jsp");
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
                response.sendRedirect("vistas/modAdministrador.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/modAdministrador.jsp");
                return;
            }
        }
        if(request.getParameter("Eliminar") != null){
            String idadmin = request.getParameter("idadmin").toString();
            try{
                controlcon.destroy(idadmin);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/tablas.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/tablas.jsp");
                return;
            }
        }
        
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
