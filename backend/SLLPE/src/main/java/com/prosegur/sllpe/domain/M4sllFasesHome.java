package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllFases.
 * @see com.prosegur.sllpe.domain.M4sllFases
 * @author Hibernate Tools
 */

public class M4sllFasesHome {

    private static final Log log = LogFactory.getLog(M4sllFasesHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllFases transientInstance) {
        log.debug("persisting M4sllFases instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllFases persistentInstance) {
        log.debug("removing M4sllFases instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllFases merge(M4sllFases detachedInstance) {
        log.debug("merging M4sllFases instance");
        try {
            M4sllFases result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllFases findById( M4sllFasesId id) {
        log.debug("getting M4sllFases instance with id: " + id);
        try {
            M4sllFases instance = entityManager.find(M4sllFases.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

