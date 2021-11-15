/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.exceptions.NonexistentEntityException;
import modelo.exceptions.RollbackFailureException;

/**
 *
 * @author PcCom
 */
public class AsistenciaJpaController implements Serializable {

    public AsistenciaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public AsistenciaJpaController(){
        this.emf = Persistence.createEntityManagerFactory("NozamaPU");
    }
    
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }


    public void create(Asistencia asistencia) throws RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Administrador idadministrador = asistencia.getIdadministrador();
            if (idadministrador != null) {
                idadministrador = em.getReference(idadministrador.getClass(), idadministrador.getIdadmin());
                asistencia.setIdadministrador(idadministrador);
            }
            Producto idpprodcuto = asistencia.getIdpprodcuto();
            if (idpprodcuto != null) {
                idpprodcuto = em.getReference(idpprodcuto.getClass(), idpprodcuto.getIdpro());
                asistencia.setIdpprodcuto(idpprodcuto);
            }
            Usuario idusuario = asistencia.getIdusuario();
            if (idusuario != null) {
                idusuario = em.getReference(idusuario.getClass(), idusuario.getIduser());
                asistencia.setIdusuario(idusuario);
            }
            em.persist(asistencia);
            if (idadministrador != null) {
                idadministrador.getAsistenciaList().add(asistencia);
                idadministrador = em.merge(idadministrador);
            }
            if (idpprodcuto != null) {
                idpprodcuto.getAsistenciaList().add(asistencia);
                idpprodcuto = em.merge(idpprodcuto);
            }
            if (idusuario != null) {
                idusuario.getAsistenciaList().add(asistencia);
                idusuario = em.merge(idusuario);
            }
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Asistencia asistencia) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Asistencia persistentAsistencia = em.find(Asistencia.class, asistencia.getIdasistencia());
            Administrador idadministradorOld = persistentAsistencia.getIdadministrador();
            Administrador idadministradorNew = asistencia.getIdadministrador();
            Producto idpprodcutoOld = persistentAsistencia.getIdpprodcuto();
            Producto idpprodcutoNew = asistencia.getIdpprodcuto();
            Usuario idusuarioOld = persistentAsistencia.getIdusuario();
            Usuario idusuarioNew = asistencia.getIdusuario();
            if (idadministradorNew != null) {
                idadministradorNew = em.getReference(idadministradorNew.getClass(), idadministradorNew.getIdadmin());
                asistencia.setIdadministrador(idadministradorNew);
            }
            if (idpprodcutoNew != null) {
                idpprodcutoNew = em.getReference(idpprodcutoNew.getClass(), idpprodcutoNew.getIdpro());
                asistencia.setIdpprodcuto(idpprodcutoNew);
            }
            if (idusuarioNew != null) {
                idusuarioNew = em.getReference(idusuarioNew.getClass(), idusuarioNew.getIduser());
                asistencia.setIdusuario(idusuarioNew);
            }
            asistencia = em.merge(asistencia);
            if (idadministradorOld != null && !idadministradorOld.equals(idadministradorNew)) {
                idadministradorOld.getAsistenciaList().remove(asistencia);
                idadministradorOld = em.merge(idadministradorOld);
            }
            if (idadministradorNew != null && !idadministradorNew.equals(idadministradorOld)) {
                idadministradorNew.getAsistenciaList().add(asistencia);
                idadministradorNew = em.merge(idadministradorNew);
            }
            if (idpprodcutoOld != null && !idpprodcutoOld.equals(idpprodcutoNew)) {
                idpprodcutoOld.getAsistenciaList().remove(asistencia);
                idpprodcutoOld = em.merge(idpprodcutoOld);
            }
            if (idpprodcutoNew != null && !idpprodcutoNew.equals(idpprodcutoOld)) {
                idpprodcutoNew.getAsistenciaList().add(asistencia);
                idpprodcutoNew = em.merge(idpprodcutoNew);
            }
            if (idusuarioOld != null && !idusuarioOld.equals(idusuarioNew)) {
                idusuarioOld.getAsistenciaList().remove(asistencia);
                idusuarioOld = em.merge(idusuarioOld);
            }
            if (idusuarioNew != null && !idusuarioNew.equals(idusuarioOld)) {
                idusuarioNew.getAsistenciaList().add(asistencia);
                idusuarioNew = em.merge(idusuarioNew);
            }
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = asistencia.getIdasistencia();
                if (findAsistencia(id) == null) {
                    throw new NonexistentEntityException("The asistencia with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Asistencia asistencia;
            try {
                asistencia = em.getReference(Asistencia.class, id);
                asistencia.getIdasistencia();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The asistencia with id " + id + " no longer exists.", enfe);
            }
            Administrador idadministrador = asistencia.getIdadministrador();
            if (idadministrador != null) {
                idadministrador.getAsistenciaList().remove(asistencia);
                idadministrador = em.merge(idadministrador);
            }
            Producto idpprodcuto = asistencia.getIdpprodcuto();
            if (idpprodcuto != null) {
                idpprodcuto.getAsistenciaList().remove(asistencia);
                idpprodcuto = em.merge(idpprodcuto);
            }
            Usuario idusuario = asistencia.getIdusuario();
            if (idusuario != null) {
                idusuario.getAsistenciaList().remove(asistencia);
                idusuario = em.merge(idusuario);
            }
            em.remove(asistencia);
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Asistencia> findAsistenciaEntities() {
        return findAsistenciaEntities(true, -1, -1);
    }

    public List<Asistencia> findAsistenciaEntities(int maxResults, int firstResult) {
        return findAsistenciaEntities(false, maxResults, firstResult);
    }

    private List<Asistencia> findAsistenciaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Asistencia.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Asistencia findAsistencia(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Asistencia.class, id);
        } finally {
            em.close();
        }
    }

    public int getAsistenciaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Asistencia> rt = cq.from(Asistencia.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
