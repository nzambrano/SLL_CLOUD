package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:06:07 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllEstudioJur.
 * @see com.prosegur.sllpe.domain.M4sllEstudioJur
 * @author Hibernate Tools
 */

public class M4sllEstudioJurHome {

    private static final Log log = LogFactory.getLog(M4sllEstudioJurHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllEstudioJur transientInstance) {
        log.debug("persisting M4sllEstudioJur instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllEstudioJur persistentInstance) {
        log.debug("removing M4sllEstudioJur instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllEstudioJur merge(M4sllEstudioJur detachedInstance) {
        log.debug("merging M4sllEstudioJur instance");
        try {
            M4sllEstudioJur result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllEstudioJur findById( M4sllEstudioJurId id) {
        log.debug("getting M4sllEstudioJur instance with id: " + id);
        try {
            M4sllEstudioJur instance = entityManager.find(M4sllEstudioJur.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

