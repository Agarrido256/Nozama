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
public class ForoJpaController implements Serializable {

    public ForoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public ForoJpaController(){
        this.emf = Persistence.createEntityManagerFactory("NozamaPU");
    }
    
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Foro foro) throws RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Producto idpprodcuto = foro.getIdpprodcuto();
            if (idpprodcuto != null) {
                idpprodcuto = em.getReference(idpprodcuto.getClass(), idpprodcuto.getIdpro());
                foro.setIdpprodcuto(idpprodcuto);
            }
            Usuario idusuario = foro.getIdusuario();
            if (idusuario != null) {
                idusuario = em.getReference(idusuario.getClass(), idusuario.getIduser());
                foro.setIdusuario(idusuario);
            }
            em.persist(foro);
            if (idpprodcuto != null) {
                idpprodcuto.getForoList().add(foro);
                idpprodcuto = em.merge(idpprodcuto);
            }
            if (idusuario != null) {
                idusuario.getForoList().add(foro);
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

    public void edit(Foro foro) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Foro persistentForo = em.find(Foro.class, foro.getIdforo());
            Producto idpprodcutoOld = persistentForo.getIdpprodcuto();
            Producto idpprodcutoNew = foro.getIdpprodcuto();
            Usuario idusuarioOld = persistentForo.getIdusuario();
            Usuario idusuarioNew = foro.getIdusuario();
            if (idpprodcutoNew != null) {
                idpprodcutoNew = em.getReference(idpprodcutoNew.getClass(), idpprodcutoNew.getIdpro());
                foro.setIdpprodcuto(idpprodcutoNew);
            }
            if (idusuarioNew != null) {
                idusuarioNew = em.getReference(idusuarioNew.getClass(), idusuarioNew.getIduser());
                foro.setIdusuario(idusuarioNew);
            }
            foro = em.merge(foro);
            if (idpprodcutoOld != null && !idpprodcutoOld.equals(idpprodcutoNew)) {
                idpprodcutoOld.getForoList().remove(foro);
                idpprodcutoOld = em.merge(idpprodcutoOld);
            }
            if (idpprodcutoNew != null && !idpprodcutoNew.equals(idpprodcutoOld)) {
                idpprodcutoNew.getForoList().add(foro);
                idpprodcutoNew = em.merge(idpprodcutoNew);
            }
            if (idusuarioOld != null && !idusuarioOld.equals(idusuarioNew)) {
                idusuarioOld.getForoList().remove(foro);
                idusuarioOld = em.merge(idusuarioOld);
            }
            if (idusuarioNew != null && !idusuarioNew.equals(idusuarioOld)) {
                idusuarioNew.getForoList().add(foro);
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
                Integer id = foro.getIdforo();
                if (findForo(id) == null) {
                    throw new NonexistentEntityException("The foro with id " + id + " no longer exists.");
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
            Foro foro;
            try {
                foro = em.getReference(Foro.class, id);
                foro.getIdforo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The foro with id " + id + " no longer exists.", enfe);
            }
            Producto idpprodcuto = foro.getIdpprodcuto();
            if (idpprodcuto != null) {
                idpprodcuto.getForoList().remove(foro);
                idpprodcuto = em.merge(idpprodcuto);
            }
            Usuario idusuario = foro.getIdusuario();
            if (idusuario != null) {
                idusuario.getForoList().remove(foro);
                idusuario = em.merge(idusuario);
            }
            em.remove(foro);
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

    public List<Foro> findForoEntities() {
        return findForoEntities(true, -1, -1);
    }

    public List<Foro> findForoEntities(int maxResults, int firstResult) {
        return findForoEntities(false, maxResults, firstResult);
    }

    private List<Foro> findForoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Foro.class));
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

    public Foro findForo(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Foro.class, id);
        } finally {
            em.close();
        }
    }

    public int getForoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Foro> rt = cq.from(Foro.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
