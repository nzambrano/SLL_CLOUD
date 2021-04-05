package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:12:06 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class StdGeoPlace.
 * @see com.prosegur.sllpe.domain.StdGeoPlace
 * @author Hibernate Tools
 */

public class StdGeoPlaceHome {

    private static final Log log = LogFactory.getLog(StdGeoPlaceHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(StdGeoPlace transientInstance) {
        log.debug("persisting StdGeoPlace instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(StdGeoPlace persistentInstance) {
        log.debug("removing StdGeoPlace instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public StdGeoPlace merge(StdGeoPlace detachedInstance) {
        log.debug("merging StdGeoPlace instance");
        try {
            StdGeoPlace result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public StdGeoPlace findById( StdGeoPlaceId id) {
        log.debug("getting StdGeoPlace instance with id: " + id);
        try {
            StdGeoPlace instance = entityManager.find(StdGeoPlace.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

