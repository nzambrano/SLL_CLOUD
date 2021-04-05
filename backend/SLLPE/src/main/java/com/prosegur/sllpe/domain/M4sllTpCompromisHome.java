package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:08:37 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpCompromis.
 * @see com.prosegur.sllpe.domain.M4sllTpCompromis
 * @author Hibernate Tools
 */

public class M4sllTpCompromisHome {

    private static final Log log = LogFactory.getLog(M4sllTpCompromisHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpCompromis transientInstance) {
        log.debug("persisting M4sllTpCompromis instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpCompromis persistentInstance) {
        log.debug("removing M4sllTpCompromis instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpCompromis merge(M4sllTpCompromis detachedInstance) {
        log.debug("merging M4sllTpCompromis instance");
        try {
            M4sllTpCompromis result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpCompromis findById( M4sllTpCompromisId id) {
        log.debug("getting M4sllTpCompromis instance with id: " + id);
        try {
            M4sllTpCompromis instance = entityManager.find(M4sllTpCompromis.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

