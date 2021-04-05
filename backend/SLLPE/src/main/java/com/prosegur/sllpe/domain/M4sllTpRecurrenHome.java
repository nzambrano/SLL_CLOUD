package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:10:22 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpRecurren.
 * @see com.prosegur.sllpe.domain.M4sllTpRecurren
 * @author Hibernate Tools
 */

public class M4sllTpRecurrenHome {

    private static final Log log = LogFactory.getLog(M4sllTpRecurrenHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpRecurren transientInstance) {
        log.debug("persisting M4sllTpRecurren instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpRecurren persistentInstance) {
        log.debug("removing M4sllTpRecurren instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpRecurren merge(M4sllTpRecurren detachedInstance) {
        log.debug("merging M4sllTpRecurren instance");
        try {
            M4sllTpRecurren result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpRecurren findById( M4sllTpRecurrenId id) {
        log.debug("getting M4sllTpRecurren instance with id: " + id);
        try {
            M4sllTpRecurren instance = entityManager.find(M4sllTpRecurren.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

