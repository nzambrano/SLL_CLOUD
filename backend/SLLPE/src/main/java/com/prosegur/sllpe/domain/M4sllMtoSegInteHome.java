package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllMtoSegInte.
 * @see com.prosegur.sllpe.domain.M4sllMtoSegInte
 * @author Hibernate Tools
 */

public class M4sllMtoSegInteHome {

    private static final Log log = LogFactory.getLog(M4sllMtoSegInteHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllMtoSegInte transientInstance) {
        log.debug("persisting M4sllMtoSegInte instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllMtoSegInte persistentInstance) {
        log.debug("removing M4sllMtoSegInte instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllMtoSegInte merge(M4sllMtoSegInte detachedInstance) {
        log.debug("merging M4sllMtoSegInte instance");
        try {
            M4sllMtoSegInte result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllMtoSegInte findById( M4sllMtoSegInteId id) {
        log.debug("getting M4sllMtoSegInte instance with id: " + id);
        try {
            M4sllMtoSegInte instance = entityManager.find(M4sllMtoSegInte.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

