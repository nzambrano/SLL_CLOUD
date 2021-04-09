package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllPagos.
 * @see com.prosegur.sllpe.domain.M4sllPagos
 * @author Hibernate Tools
 */

public class M4sllPagosHome {

    private static final Log log = LogFactory.getLog(M4sllPagosHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllPagos transientInstance) {
        log.debug("persisting M4sllPagos instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllPagos persistentInstance) {
        log.debug("removing M4sllPagos instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllPagos merge(M4sllPagos detachedInstance) {
        log.debug("merging M4sllPagos instance");
        try {
            M4sllPagos result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllPagos findById( M4sllPagosId id) {
        log.debug("getting M4sllPagos instance with id: " + id);
        try {
            M4sllPagos instance = entityManager.find(M4sllPagos.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

