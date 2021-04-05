package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:08:21 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTribunales.
 * @see com.prosegur.sllpe.domain.M4sllTribunales
 * @author Hibernate Tools
 */

public class M4sllTribunalesHome {

    private static final Log log = LogFactory.getLog(M4sllTribunalesHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTribunales transientInstance) {
        log.debug("persisting M4sllTribunales instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTribunales persistentInstance) {
        log.debug("removing M4sllTribunales instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTribunales merge(M4sllTribunales detachedInstance) {
        log.debug("merging M4sllTribunales instance");
        try {
            M4sllTribunales result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTribunales findById( M4sllTribunalesId id) {
        log.debug("getting M4sllTribunales instance with id: " + id);
        try {
            M4sllTribunales instance = entityManager.find(M4sllTribunales.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

