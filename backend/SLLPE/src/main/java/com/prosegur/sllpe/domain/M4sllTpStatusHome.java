package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:07:51 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpStatus.
 * @see com.prosegur.sllpe.domain.M4sllTpStatus
 * @author Hibernate Tools
 */

public class M4sllTpStatusHome {

    private static final Log log = LogFactory.getLog(M4sllTpStatusHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpStatus transientInstance) {
        log.debug("persisting M4sllTpStatus instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpStatus persistentInstance) {
        log.debug("removing M4sllTpStatus instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpStatus merge(M4sllTpStatus detachedInstance) {
        log.debug("merging M4sllTpStatus instance");
        try {
            M4sllTpStatus result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpStatus findById( M4sllTpStatusId id) {
        log.debug("getting M4sllTpStatus instance with id: " + id);
        try {
            M4sllTpStatus instance = entityManager.find(M4sllTpStatus.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

