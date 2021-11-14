/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author PcCom
 */
@Entity
@Table(name = "pedido")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Pedido.findAll", query = "SELECT p FROM Pedido p"),
    @NamedQuery(name = "Pedido.findByIdpedido", query = "SELECT p FROM Pedido p WHERE p.idpedido = :idpedido"),
    @NamedQuery(name = "Pedido.findByFechacompra", query = "SELECT p FROM Pedido p WHERE p.fechacompra = :fechacompra"),
    @NamedQuery(name = "Pedido.findByEstadoentrega", query = "SELECT p FROM Pedido p WHERE p.estadoentrega = :estadoentrega"),
    @NamedQuery(name = "Pedido.findByCantidadpedida", query = "SELECT p FROM Pedido p WHERE p.cantidadpedida = :cantidadpedida"),
    @NamedQuery(name = "Pedido.findByCalle", query = "SELECT p FROM Pedido p WHERE p.calle = :calle"),
    @NamedQuery(name = "Pedido.findByCiudad", query = "SELECT p FROM Pedido p WHERE p.ciudad = :ciudad"),
    @NamedQuery(name = "Pedido.findByEstado", query = "SELECT p FROM Pedido p WHERE p.estado = :estado"),
    @NamedQuery(name = "Pedido.findByCodigopostal", query = "SELECT p FROM Pedido p WHERE p.codigopostal = :codigopostal")})
public class Pedido implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idpedido")
    private Integer idpedido;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fechacompra")
    @Temporal(TemporalType.DATE)
    private Date fechacompra;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 99)
    @Column(name = "estadoentrega")
    private String estadoentrega;
    @Basic(optional = false)
    @NotNull
    @Column(name = "cantidadpedida")
    private int cantidadpedida;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 99)
    @Column(name = "calle")
    private String calle;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 99)
    @Column(name = "ciudad")
    private String ciudad;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 99)
    @Column(name = "estado")
    private String estado;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 99)
    @Column(name = "codigopostal")
    private String codigopostal;
    @JoinColumn(name = "idproducto", referencedColumnName = "idpro")
    @ManyToOne(optional = false)
    private Producto idproducto;
    @JoinColumn(name = "idusuario", referencedColumnName = "iduser")
    @ManyToOne(optional = false)
    private Usuario idusuario;

    public Pedido() {
    }

    public Pedido(Integer idpedido) {
        this.idpedido = idpedido;
    }

    public Pedido(Integer idpedido, Date fechacompra, String estadoentrega, int cantidadpedida, String calle, String ciudad, String estado, String codigopostal) {
        this.idpedido = idpedido;
        this.fechacompra = fechacompra;
        this.estadoentrega = estadoentrega;
        this.cantidadpedida = cantidadpedida;
        this.calle = calle;
        this.ciudad = ciudad;
        this.estado = estado;
        this.codigopostal = codigopostal;
    }

    public Integer getIdpedido() {
        return idpedido;
    }

    public void setIdpedido(Integer idpedido) {
        this.idpedido = idpedido;
    }

    public Date getFechacompra() {
        return fechacompra;
    }

    public void setFechacompra(Date fechacompra) {
        this.fechacompra = fechacompra;
    }

    public String getEstadoentrega() {
        return estadoentrega;
    }

    public void setEstadoentrega(String estadoentrega) {
        this.estadoentrega = estadoentrega;
    }

    public int getCantidadpedida() {
        return cantidadpedida;
    }

    public void setCantidadpedida(int cantidadpedida) {
        this.cantidadpedida = cantidadpedida;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCodigopostal() {
        return codigopostal;
    }

    public void setCodigopostal(String codigopostal) {
        this.codigopostal = codigopostal;
    }

    public Producto getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(Producto idproducto) {
        this.idproducto = idproducto;
    }

    public Usuario getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Usuario idusuario) {
        this.idusuario = idusuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idpedido != null ? idpedido.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Pedido)) {
            return false;
        }
        Pedido other = (Pedido) object;
        if ((this.idpedido == null && other.idpedido != null) || (this.idpedido != null && !this.idpedido.equals(other.idpedido))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Pedido[ idpedido=" + idpedido + " ]";
    }
    
}
