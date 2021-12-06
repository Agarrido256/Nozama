/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import modelo.exceptions.IllegalOrphanException;
import modelo.exceptions.NonexistentEntityException;
import modelo.exceptions.RollbackFailureException;

/**
 *
 * @author PcCom
 */
public class ProductoJpaController implements Serializable {

    public ProductoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public ProductoJpaController(){
        this.emf = Persistence.createEntityManagerFactory("NozamaPU");
    }
    
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Producto producto) throws RollbackFailureException, Exception {
        if (producto.getAsistenciaList() == null) {
            producto.setAsistenciaList(new ArrayList<Asistencia>());
        }
        if (producto.getForoList() == null) {
            producto.setForoList(new ArrayList<Foro>());
        }
        if (producto.getPedidoList() == null) {
            producto.setPedidoList(new ArrayList<Pedido>());
        }
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            List<Asistencia> attachedAsistenciaList = new ArrayList<Asistencia>();
            for (Asistencia asistenciaListAsistenciaToAttach : producto.getAsistenciaList()) {
                asistenciaListAsistenciaToAttach = em.getReference(asistenciaListAsistenciaToAttach.getClass(), asistenciaListAsistenciaToAttach.getIdasistencia());
                attachedAsistenciaList.add(asistenciaListAsistenciaToAttach);
            }
            producto.setAsistenciaList(attachedAsistenciaList);
            List<Foro> attachedForoList = new ArrayList<Foro>();
            for (Foro foroListForoToAttach : producto.getForoList()) {
                foroListForoToAttach = em.getReference(foroListForoToAttach.getClass(), foroListForoToAttach.getIdforo());
                attachedForoList.add(foroListForoToAttach);
            }
            producto.setForoList(attachedForoList);
            List<Pedido> attachedPedidoList = new ArrayList<Pedido>();
            for (Pedido pedidoListPedidoToAttach : producto.getPedidoList()) {
                pedidoListPedidoToAttach = em.getReference(pedidoListPedidoToAttach.getClass(), pedidoListPedidoToAttach.getIdpedido());
                attachedPedidoList.add(pedidoListPedidoToAttach);
            }
            producto.setPedidoList(attachedPedidoList);
            em.persist(producto);
            for (Asistencia asistenciaListAsistencia : producto.getAsistenciaList()) {
                Producto oldIdpprodcutoOfAsistenciaListAsistencia = asistenciaListAsistencia.getIdpprodcuto();
                asistenciaListAsistencia.setIdpprodcuto(producto);
                asistenciaListAsistencia = em.merge(asistenciaListAsistencia);
                if (oldIdpprodcutoOfAsistenciaListAsistencia != null) {
                    oldIdpprodcutoOfAsistenciaListAsistencia.getAsistenciaList().remove(asistenciaListAsistencia);
                    oldIdpprodcutoOfAsistenciaListAsistencia = em.merge(oldIdpprodcutoOfAsistenciaListAsistencia);
                }
            }
            for (Foro foroListForo : producto.getForoList()) {
                Producto oldIdpprodcutoOfForoListForo = foroListForo.getIdpprodcuto();
                foroListForo.setIdpprodcuto(producto);
                foroListForo = em.merge(foroListForo);
                if (oldIdpprodcutoOfForoListForo != null) {
                    oldIdpprodcutoOfForoListForo.getForoList().remove(foroListForo);
                    oldIdpprodcutoOfForoListForo = em.merge(oldIdpprodcutoOfForoListForo);
                }
            }
            for (Pedido pedidoListPedido : producto.getPedidoList()) {
                Producto oldIdproductoOfPedidoListPedido = pedidoListPedido.getIdproducto();
                pedidoListPedido.setIdproducto(producto);
                pedidoListPedido = em.merge(pedidoListPedido);
                if (oldIdproductoOfPedidoListPedido != null) {
                    oldIdproductoOfPedidoListPedido.getPedidoList().remove(pedidoListPedido);
                    oldIdproductoOfPedidoListPedido = em.merge(oldIdproductoOfPedidoListPedido);
                }
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

    public void edit(Producto producto) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Producto persistentProducto = em.find(Producto.class, producto.getIdpro());
            List<String> illegalOrphanMessages = null;
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            producto = em.merge(producto);
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = producto.getIdpro();
                if (findProducto(id) == null) {
                    throw new NonexistentEntityException("The producto with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Producto producto;
            try {
                producto = em.getReference(Producto.class, id);
                producto.getIdpro();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The producto with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Asistencia> asistenciaListOrphanCheck = producto.getAsistenciaList();
            for (Asistencia asistenciaListOrphanCheckAsistencia : asistenciaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Producto (" + producto + ") cannot be destroyed since the Asistencia " + asistenciaListOrphanCheckAsistencia + " in its asistenciaList field has a non-nullable idpprodcuto field.");
            }
            List<Foro> foroListOrphanCheck = producto.getForoList();
            for (Foro foroListOrphanCheckForo : foroListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Producto (" + producto + ") cannot be destroyed since the Foro " + foroListOrphanCheckForo + " in its foroList field has a non-nullable idpprodcuto field.");
            }
            List<Pedido> pedidoListOrphanCheck = producto.getPedidoList();
            for (Pedido pedidoListOrphanCheckPedido : pedidoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Producto (" + producto + ") cannot be destroyed since the Pedido " + pedidoListOrphanCheckPedido + " in its pedidoList field has a non-nullable idproducto field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(producto);
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

    public List<Producto> findProductoEntities() {
        return findProductoEntities(true, -1, -1);
    }

    public List<Producto> findProductoEntities(int maxResults, int firstResult) {
        return findProductoEntities(false, maxResults, firstResult);
    }

    private List<Producto> findProductoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Producto.class));
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

    public Producto findProducto(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Producto.class, id);
        } finally {
            em.close();
        }
    }

    public int getProductoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Producto> rt = cq.from(Producto.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
