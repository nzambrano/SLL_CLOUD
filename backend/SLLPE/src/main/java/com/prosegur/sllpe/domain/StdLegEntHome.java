package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class StdLegEnt.
 * @see com.prosegur.sllpe.domain.StdLegEnt
 * @author Hibernate Tools
 */

public class StdLegEntHome {

    private static final Log log = LogFactory.getLog(StdLegEntHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(StdLegEnt transientInstance) {
        log.debug("persisting StdLegEnt instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(StdLegEnt persistentInstance) {
        log.debug("removing StdLegEnt instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public StdLegEnt merge(StdLegEnt detachedInstance) {
        log.debug("merging StdLegEnt instance");
        try {
            StdLegEnt result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public StdLegEnt findById( StdLegEntId id) {
        log.debug("getting StdLegEnt instance with id: " + id);
        try {
            StdLegEnt instance = entityManager.find(StdLegEnt.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

