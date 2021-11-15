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
import modelo.exceptions.PreexistingEntityException;
import modelo.exceptions.RollbackFailureException;

/**
 *
 * @author PcCom
 */
public class UsuarioJpaController implements Serializable {

    public UsuarioJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public UsuarioJpaController(){
        this.emf = Persistence.createEntityManagerFactory("NozamaPU");
    }
    
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Usuario usuario) throws PreexistingEntityException, RollbackFailureException, Exception {
        if (usuario.getAsistenciaList() == null) {
            usuario.setAsistenciaList(new ArrayList<Asistencia>());
        }
        if (usuario.getForoList() == null) {
            usuario.setForoList(new ArrayList<Foro>());
        }
        if (usuario.getPedidoList() == null) {
            usuario.setPedidoList(new ArrayList<Pedido>());
        }
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            List<Asistencia> attachedAsistenciaList = new ArrayList<Asistencia>();
            for (Asistencia asistenciaListAsistenciaToAttach : usuario.getAsistenciaList()) {
                asistenciaListAsistenciaToAttach = em.getReference(asistenciaListAsistenciaToAttach.getClass(), asistenciaListAsistenciaToAttach.getIdasistencia());
                attachedAsistenciaList.add(asistenciaListAsistenciaToAttach);
            }
            usuario.setAsistenciaList(attachedAsistenciaList);
            List<Foro> attachedForoList = new ArrayList<Foro>();
            for (Foro foroListForoToAttach : usuario.getForoList()) {
                foroListForoToAttach = em.getReference(foroListForoToAttach.getClass(), foroListForoToAttach.getIdforo());
                attachedForoList.add(foroListForoToAttach);
            }
            usuario.setForoList(attachedForoList);
            List<Pedido> attachedPedidoList = new ArrayList<Pedido>();
            for (Pedido pedidoListPedidoToAttach : usuario.getPedidoList()) {
                pedidoListPedidoToAttach = em.getReference(pedidoListPedidoToAttach.getClass(), pedidoListPedidoToAttach.getIdpedido());
                attachedPedidoList.add(pedidoListPedidoToAttach);
            }
            usuario.setPedidoList(attachedPedidoList);
            em.persist(usuario);
            for (Asistencia asistenciaListAsistencia : usuario.getAsistenciaList()) {
                Usuario oldIdusuarioOfAsistenciaListAsistencia = asistenciaListAsistencia.getIdusuario();
                asistenciaListAsistencia.setIdusuario(usuario);
                asistenciaListAsistencia = em.merge(asistenciaListAsistencia);
                if (oldIdusuarioOfAsistenciaListAsistencia != null) {
                    oldIdusuarioOfAsistenciaListAsistencia.getAsistenciaList().remove(asistenciaListAsistencia);
                    oldIdusuarioOfAsistenciaListAsistencia = em.merge(oldIdusuarioOfAsistenciaListAsistencia);
                }
            }
            for (Foro foroListForo : usuario.getForoList()) {
                Usuario oldIdusuarioOfForoListForo = foroListForo.getIdusuario();
                foroListForo.setIdusuario(usuario);
                foroListForo = em.merge(foroListForo);
                if (oldIdusuarioOfForoListForo != null) {
                    oldIdusuarioOfForoListForo.getForoList().remove(foroListForo);
                    oldIdusuarioOfForoListForo = em.merge(oldIdusuarioOfForoListForo);
                }
            }
            for (Pedido pedidoListPedido : usuario.getPedidoList()) {
                Usuario oldIdusuarioOfPedidoListPedido = pedidoListPedido.getIdusuario();
                pedidoListPedido.setIdusuario(usuario);
                pedidoListPedido = em.merge(pedidoListPedido);
                if (oldIdusuarioOfPedidoListPedido != null) {
                    oldIdusuarioOfPedidoListPedido.getPedidoList().remove(pedidoListPedido);
                    oldIdusuarioOfPedidoListPedido = em.merge(oldIdusuarioOfPedidoListPedido);
                }
            }
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findUsuario(usuario.getIduser()) != null) {
                throw new PreexistingEntityException("Usuario " + usuario + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Usuario usuario) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Usuario persistentUsuario = em.find(Usuario.class, usuario.getIduser());
            List<Asistencia> asistenciaListOld = persistentUsuario.getAsistenciaList();
            List<Asistencia> asistenciaListNew = usuario.getAsistenciaList();
            List<Foro> foroListOld = persistentUsuario.getForoList();
            List<Foro> foroListNew = usuario.getForoList();
            List<Pedido> pedidoListOld = persistentUsuario.getPedidoList();
            List<Pedido> pedidoListNew = usuario.getPedidoList();
            List<String> illegalOrphanMessages = null;
            for (Asistencia asistenciaListOldAsistencia : asistenciaListOld) {
                if (!asistenciaListNew.contains(asistenciaListOldAsistencia)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Asistencia " + asistenciaListOldAsistencia + " since its idusuario field is not nullable.");
                }
            }
            for (Foro foroListOldForo : foroListOld) {
                if (!foroListNew.contains(foroListOldForo)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Foro " + foroListOldForo + " since its idusuario field is not nullable.");
                }
            }
            for (Pedido pedidoListOldPedido : pedidoListOld) {
                if (!pedidoListNew.contains(pedidoListOldPedido)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Pedido " + pedidoListOldPedido + " since its idusuario field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Asistencia> attachedAsistenciaListNew = new ArrayList<Asistencia>();
            for (Asistencia asistenciaListNewAsistenciaToAttach : asistenciaListNew) {
                asistenciaListNewAsistenciaToAttach = em.getReference(asistenciaListNewAsistenciaToAttach.getClass(), asistenciaListNewAsistenciaToAttach.getIdasistencia());
                attachedAsistenciaListNew.add(asistenciaListNewAsistenciaToAttach);
            }
            asistenciaListNew = attachedAsistenciaListNew;
            usuario.setAsistenciaList(asistenciaListNew);
            List<Foro> attachedForoListNew = new ArrayList<Foro>();
            for (Foro foroListNewForoToAttach : foroListNew) {
                foroListNewForoToAttach = em.getReference(foroListNewForoToAttach.getClass(), foroListNewForoToAttach.getIdforo());
                attachedForoListNew.add(foroListNewForoToAttach);
            }
            foroListNew = attachedForoListNew;
            usuario.setForoList(foroListNew);
            List<Pedido> attachedPedidoListNew = new ArrayList<Pedido>();
            for (Pedido pedidoListNewPedidoToAttach : pedidoListNew) {
                pedidoListNewPedidoToAttach = em.getReference(pedidoListNewPedidoToAttach.getClass(), pedidoListNewPedidoToAttach.getIdpedido());
                attachedPedidoListNew.add(pedidoListNewPedidoToAttach);
            }
            pedidoListNew = attachedPedidoListNew;
            usuario.setPedidoList(pedidoListNew);
            usuario = em.merge(usuario);
            for (Asistencia asistenciaListNewAsistencia : asistenciaListNew) {
                if (!asistenciaListOld.contains(asistenciaListNewAsistencia)) {
                    Usuario oldIdusuarioOfAsistenciaListNewAsistencia = asistenciaListNewAsistencia.getIdusuario();
                    asistenciaListNewAsistencia.setIdusuario(usuario);
                    asistenciaListNewAsistencia = em.merge(asistenciaListNewAsistencia);
                    if (oldIdusuarioOfAsistenciaListNewAsistencia != null && !oldIdusuarioOfAsistenciaListNewAsistencia.equals(usuario)) {
                        oldIdusuarioOfAsistenciaListNewAsistencia.getAsistenciaList().remove(asistenciaListNewAsistencia);
                        oldIdusuarioOfAsistenciaListNewAsistencia = em.merge(oldIdusuarioOfAsistenciaListNewAsistencia);
                    }
                }
            }
            for (Foro foroListNewForo : foroListNew) {
                if (!foroListOld.contains(foroListNewForo)) {
                    Usuario oldIdusuarioOfForoListNewForo = foroListNewForo.getIdusuario();
                    foroListNewForo.setIdusuario(usuario);
                    foroListNewForo = em.merge(foroListNewForo);
                    if (oldIdusuarioOfForoListNewForo != null && !oldIdusuarioOfForoListNewForo.equals(usuario)) {
                        oldIdusuarioOfForoListNewForo.getForoList().remove(foroListNewForo);
                        oldIdusuarioOfForoListNewForo = em.merge(oldIdusuarioOfForoListNewForo);
                    }
                }
            }
            for (Pedido pedidoListNewPedido : pedidoListNew) {
                if (!pedidoListOld.contains(pedidoListNewPedido)) {
                    Usuario oldIdusuarioOfPedidoListNewPedido = pedidoListNewPedido.getIdusuario();
                    pedidoListNewPedido.setIdusuario(usuario);
                    pedidoListNewPedido = em.merge(pedidoListNewPedido);
                    if (oldIdusuarioOfPedidoListNewPedido != null && !oldIdusuarioOfPedidoListNewPedido.equals(usuario)) {
                        oldIdusuarioOfPedidoListNewPedido.getPedidoList().remove(pedidoListNewPedido);
                        oldIdusuarioOfPedidoListNewPedido = em.merge(oldIdusuarioOfPedidoListNewPedido);
                    }
                }
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
                String id = usuario.getIduser();
                if (findUsuario(id) == null) {
                    throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;
        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            Usuario usuario;
            try {
                usuario = em.getReference(Usuario.class, id);
                usuario.getIduser();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Asistencia> asistenciaListOrphanCheck = usuario.getAsistenciaList();
            for (Asistencia asistenciaListOrphanCheckAsistencia : asistenciaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Usuario (" + usuario + ") cannot be destroyed since the Asistencia " + asistenciaListOrphanCheckAsistencia + " in its asistenciaList field has a non-nullable idusuario field.");
            }
            List<Foro> foroListOrphanCheck = usuario.getForoList();
            for (Foro foroListOrphanCheckForo : foroListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Usuario (" + usuario + ") cannot be destroyed since the Foro " + foroListOrphanCheckForo + " in its foroList field has a non-nullable idusuario field.");
            }
            List<Pedido> pedidoListOrphanCheck = usuario.getPedidoList();
            for (Pedido pedidoListOrphanCheckPedido : pedidoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Usuario (" + usuario + ") cannot be destroyed since the Pedido " + pedidoListOrphanCheckPedido + " in its pedidoList field has a non-nullable idusuario field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(usuario);
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

    public List<Usuario> findUsuarioEntities() {
        return findUsuarioEntities(true, -1, -1);
    }

    public List<Usuario> findUsuarioEntities(int maxResults, int firstResult) {
        return findUsuarioEntities(false, maxResults, firstResult);
    }

    private List<Usuario> findUsuarioEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Usuario.class));
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

    public Usuario findUsuario(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public int getUsuarioCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Usuario> rt = cq.from(Usuario.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
