package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:06:39 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpFases.
 * @see com.prosegur.sllpe.domain.M4sllTpFases
 * @author Hibernate Tools
 */

public class M4sllTpFasesHome {

    private static final Log log = LogFactory.getLog(M4sllTpFasesHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpFases transientInstance) {
        log.debug("persisting M4sllTpFases instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpFases persistentInstance) {
        log.debug("removing M4sllTpFases instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpFases merge(M4sllTpFases detachedInstance) {
        log.debug("merging M4sllTpFases instance");
        try {
            M4sllTpFases result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpFases findById( M4sllTpFasesId id) {
        log.debug("getting M4sllTpFases instance with id: " + id);
        try {
            M4sllTpFases instance = entityManager.find(M4sllTpFases.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

