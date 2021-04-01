package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:06:21 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpPedido.
 * @see com.prosegur.sllpe.domain.M4sllTpPedido
 * @author Hibernate Tools
 */

public class M4sllTpPedidoHome {

    private static final Log log = LogFactory.getLog(M4sllTpPedidoHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpPedido transientInstance) {
        log.debug("persisting M4sllTpPedido instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpPedido persistentInstance) {
        log.debug("removing M4sllTpPedido instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpPedido merge(M4sllTpPedido detachedInstance) {
        log.debug("merging M4sllTpPedido instance");
        try {
            M4sllTpPedido result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpPedido findById( M4sllTpPedidoId id) {
        log.debug("getting M4sllTpPedido instance with id: " + id);
        try {
            M4sllTpPedido instance = entityManager.find(M4sllTpPedido.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

