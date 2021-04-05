package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:07:21 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllMtoCodAlt.
 * @see com.prosegur.sllpe.domain.M4sllMtoCodAlt
 * @author Hibernate Tools
 */

public class M4sllMtoCodAltHome {

    private static final Log log = LogFactory.getLog(M4sllMtoCodAltHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllMtoCodAlt transientInstance) {
        log.debug("persisting M4sllMtoCodAlt instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllMtoCodAlt persistentInstance) {
        log.debug("removing M4sllMtoCodAlt instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllMtoCodAlt merge(M4sllMtoCodAlt detachedInstance) {
        log.debug("merging M4sllMtoCodAlt instance");
        try {
            M4sllMtoCodAlt result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllMtoCodAlt findById( M4sllMtoCodAltId id) {
        log.debug("getting M4sllMtoCodAlt instance with id: " + id);
        try {
            M4sllMtoCodAlt instance = entityManager.find(M4sllMtoCodAlt.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

