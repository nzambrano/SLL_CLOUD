package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllPedidoDet.
 * @see com.prosegur.sllpe.domain.M4sllPedidoDet
 * @author Hibernate Tools
 */

public class M4sllPedidoDetHome {

    private static final Log log = LogFactory.getLog(M4sllPedidoDetHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllPedidoDet transientInstance) {
        log.debug("persisting M4sllPedidoDet instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllPedidoDet persistentInstance) {
        log.debug("removing M4sllPedidoDet instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllPedidoDet merge(M4sllPedidoDet detachedInstance) {
        log.debug("merging M4sllPedidoDet instance");
        try {
            M4sllPedidoDet result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllPedidoDet findById( M4sllPedidoDetId id) {
        log.debug("getting M4sllPedidoDet instance with id: " + id);
        try {
            M4sllPedidoDet instance = entityManager.find(M4sllPedidoDet.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

