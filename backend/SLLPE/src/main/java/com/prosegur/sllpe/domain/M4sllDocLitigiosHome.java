package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:20:50 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllDocLitigios.
 * @see com.prosegur.sllpe.domain.M4sllDocLitigios
 * @author Hibernate Tools
 */

public class M4sllDocLitigiosHome {

    private static final Log log = LogFactory.getLog(M4sllDocLitigiosHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllDocLitigios transientInstance) {
        log.debug("persisting M4sllDocLitigios instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllDocLitigios persistentInstance) {
        log.debug("removing M4sllDocLitigios instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllDocLitigios merge(M4sllDocLitigios detachedInstance) {
        log.debug("merging M4sllDocLitigios instance");
        try {
            M4sllDocLitigios result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllDocLitigios findById( M4sllDocLitigiosId id) {
        log.debug("getting M4sllDocLitigios instance with id: " + id);
        try {
            M4sllDocLitigios instance = entityManager.find(M4sllDocLitigios.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

