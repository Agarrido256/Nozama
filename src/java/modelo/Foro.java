/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author PcCom
 */
@Entity
@Table(name = "foro")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Foro.findAll", query = "SELECT f FROM Foro f"),
    @NamedQuery(name = "Foro.findByIdforo", query = "SELECT f FROM Foro f WHERE f.idforo = :idforo"),
    @NamedQuery(name = "Foro.findByAsunto", query = "SELECT f FROM Foro f WHERE f.asunto = :asunto"),
    @NamedQuery(name = "Foro.findByDescripcion", query = "SELECT f FROM Foro f WHERE f.descripcion = :descripcion"),
    @NamedQuery(name = "Foro.findByPuntuacion", query = "SELECT f FROM Foro f WHERE f.puntuacion = :puntuacion")})
public class Foro implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idforo")
    private Integer idforo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "asunto")
    private String asunto;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 500)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "puntuacion")
    private int puntuacion;
    @JoinColumn(name = "idpprodcuto", referencedColumnName = "idpro")
    @ManyToOne(optional = false)
    private Producto idpprodcuto;
    @JoinColumn(name = "idusuario", referencedColumnName = "iduser")
    @ManyToOne(optional = false)
    private Usuario idusuario;

    public Foro() {
    }

    public Foro(Integer idforo) {
        this.idforo = idforo;
    }

    public Foro(Integer idforo, String asunto, String descripcion, int puntuacion) {
        this.idforo = idforo;
        this.asunto = asunto;
        this.descripcion = descripcion;
        this.puntuacion = puntuacion;
    }

    public Integer getIdforo() {
        return idforo;
    }

    public void setIdforo(Integer idforo) {
        this.idforo = idforo;
    }

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPuntuacion() {
        return puntuacion;
    }

    public void setPuntuacion(int puntuacion) {
        this.puntuacion = puntuacion;
    }

    public Producto getIdpprodcuto() {
        return idpprodcuto;
    }

    public void setIdpprodcuto(Producto idpprodcuto) {
        this.idpprodcuto = idpprodcuto;
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
        hash += (idforo != null ? idforo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Foro)) {
            return false;
        }
        Foro other = (Foro) object;
        if ((this.idforo == null && other.idforo != null) || (this.idforo != null && !this.idforo.equals(other.idforo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Foro[ idforo=" + idforo + " ]";
    }
    
}
