/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import com.sun.xml.wss.util.DateUtils;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Boolean.parseBoolean;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Usuario;
import modelo.UsuarioJpaController;

/**
 *
 * @author PcCom
 */
public class UsuarioDAO extends HttpServlet {
    UsuarioJpaController controlcon = new UsuarioJpaController();
    Usuario usuario = new Usuario();
    List<Usuario> datos = controlcon.findUsuarioEntities();
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
            out.println("<title>Servlet UsuarioDAO</title>");            
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
            String iduser = request.getParameter("iduser").toString();
            String nombre = request.getParameter("nombre").toString();
            String apellidos = request.getParameter("apellidos").toString();
            String estafecha = request.getParameter("fechanac").toString();
            boolean premium = parseBoolean(request.getParameter("premium"));
            String estafechac = request.getParameter("fechacadpremium").toString();
            String contrasena = request.getParameter("contrasena").toString();
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechanac;
            Date fechacadpremium = null;
            try {
                fechanac = simpleDateFormat.parse(estafecha);
                if(!estafechac.isEmpty()){
                    fechacadpremium = simpleDateFormat.parse(estafechac);
                }
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/gestionUsuario.jsp");
                return;
            }
            try{
                usuario.setIduser(iduser);
                usuario.setNombre(nombre);
                usuario.setApellidos(apellidos);
                usuario.setFechanac(fechanac);
                usuario.setPremium(premium);
                if(fechacadpremium != null){
                    usuario.setFechacadpremium(fechacadpremium);
                }
                usuario.setContraseña(contrasena);
                controlcon.create(usuario);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/gestionUsuario.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/gestionUsuario.jsp");
                return;
            }
        }
        if(request.getParameter("Modificar") != null){
            String iduser = sesion.getAttribute("siduser").toString();
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
            if(request.getParameter("fechacadpremium").toString().isEmpty()){
                estafechac = "no";
            } else {
                estafechac = request.getParameter("fechacadpremium").toString();
            }
            boolean premium = parseBoolean(request.getParameter("premium"));
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechanac;
            Date fechacadpremium = null;
            try {
                fechanac = simpleDateFormat.parse(estafecha);
                if(estafechac != "no"){
                    fechacadpremium = simpleDateFormat.parse(estafechac);
                }
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/modUsuario.jsp");
                return;
            }
            try{
                usuario.setIduser(iduser);
                usuario.setNombre(nombre);
                usuario.setApellidos(apellidos);
                usuario.setFechanac(fechanac);
                usuario.setPremium(premium);
                if(fechacadpremium != null){
                    usuario.setFechacadpremium(fechacadpremium);
                }
                usuario.setContraseña(contrasena);
                controlcon.edit(usuario);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/modUsuario.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/modUsuario.jsp");
                return;
            }
        }
        if(request.getParameter("Eliminar") != null){
            String iduser = request.getParameter("iduser").toString();
            try{
                controlcon.destroy(iduser);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/gestionUsuario.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/usuario/gestionUsuario.jsp");
                return;
            }
        }
        if(request.getParameter("Nuevo") != null){
            String iduser = request.getParameter("iduser").toString();
            String nombre = request.getParameter("nombre").toString();
            String apellidos = request.getParameter("apellidos").toString();
            String estafecha = request.getParameter("fechanac").toString();
            boolean premium = false;
            String contrasena = request.getParameter("contrasena").toString();
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechanac;
            try {
                fechanac = simpleDateFormat.parse(estafecha);
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/registrar.jsp");
                return;
            }
            try{
                usuario.setIduser(iduser);
                usuario.setNombre(nombre);
                usuario.setApellidos(apellidos);
                usuario.setFechanac(fechanac);
                usuario.setPremium(premium);
                usuario.setContraseña(contrasena);
                controlcon.create(usuario);
                mensaje = "yr";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/welcome.jsp");
                return;
            } catch(Exception e){
                mensaje = "nr";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/welcome.jsp");
                return;
            }
        }
        if(request.getParameter("Uconf") != null){
            String iduser = sesion.getAttribute("user").toString();
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
            boolean premium = false;
            for(Usuario registro : datos){
                if(registro.getIduser().equals(iduser)){
                    premium = registro.getPremium();
                }
            }
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date fechanac;
            try {
                fechanac = simpleDateFormat.parse(estafecha);
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/uconf.jsp");
                return;
            }
            try{
                usuario.setIduser(iduser);
                usuario.setNombre(nombre);
                usuario.setApellidos(apellidos);
                usuario.setFechanac(fechanac);
                usuario.setPremium(premium);
                usuario.setContraseña(contrasena);
                controlcon.edit(usuario);
                mensaje = "y";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/uconf.jsp");
                return;
            } catch(Exception e){
                mensaje = "n";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/uconf.jsp");
                return;
            }
        }
        if(request.getParameter("Ppremium") != null){
            String iduser = sesion.getAttribute("user").toString();
            String nombre = sesion.getAttribute("snombre").toString();
            String apellidos = sesion.getAttribute("sapellidos").toString();
            String contrasena = sesion.getAttribute("scontrasena").toString();
            String estafecha = sesion.getAttribute("sfechanac").toString();
            boolean premium = true;
            Date fechanac = new Date();
            for(Usuario registro : datos){
                if(registro.getIduser().equals(iduser)){
                    fechanac = registro.getFechanac();
                }
            }
            LocalDateTime ldt = LocalDateTime.now().plusYears(1);
            String pattern = "yyyy-MM-dd";
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            Date date;
            try {
                date = simpleDateFormat.parse(ldt.toString());
            } catch (ParseException ex) {
                mensaje = "f";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/uconf.jsp");
                return;
            }
            try{
                usuario.setIduser(iduser);
                usuario.setNombre(nombre);
                usuario.setApellidos(apellidos);
                usuario.setFechanac(fechanac);
                usuario.setPremium(premium);
                usuario.setFechacadpremium(date);
                usuario.setContraseña(contrasena);
                controlcon.edit(usuario);
                mensaje = "yp";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/uconf.jsp");
                return;
            } catch(Exception e){
                mensaje = "np";
                sesion.setAttribute("mensaje", mensaje);
                response.sendRedirect("vistas/uconf.jsp");
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
