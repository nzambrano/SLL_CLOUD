package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class StdGeoDiv.
 * @see com.prosegur.sllpe.domain.StdGeoDiv
 * @author Hibernate Tools
 */

public class StdGeoDivHome {

    private static final Log log = LogFactory.getLog(StdGeoDivHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(StdGeoDiv transientInstance) {
        log.debug("persisting StdGeoDiv instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(StdGeoDiv persistentInstance) {
        log.debug("removing StdGeoDiv instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public StdGeoDiv merge(StdGeoDiv detachedInstance) {
        log.debug("merging StdGeoDiv instance");
        try {
            StdGeoDiv result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public StdGeoDiv findById( StdGeoDivId id) {
        log.debug("getting StdGeoDiv instance with id: " + id);
        try {
            StdGeoDiv instance = entityManager.find(StdGeoDiv.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

