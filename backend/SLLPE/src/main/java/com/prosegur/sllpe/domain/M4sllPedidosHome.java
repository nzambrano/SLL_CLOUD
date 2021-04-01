package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllPedidos.
 * @see com.prosegur.sllpe.domain.M4sllPedidos
 * @author Hibernate Tools
 */

public class M4sllPedidosHome {

    private static final Log log = LogFactory.getLog(M4sllPedidosHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllPedidos transientInstance) {
        log.debug("persisting M4sllPedidos instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllPedidos persistentInstance) {
        log.debug("removing M4sllPedidos instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllPedidos merge(M4sllPedidos detachedInstance) {
        log.debug("merging M4sllPedidos instance");
        try {
            M4sllPedidos result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllPedidos findById( M4sllPedidosId id) {
        log.debug("getting M4sllPedidos instance with id: " + id);
        try {
            M4sllPedidos instance = entityManager.find(M4sllPedidos.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

