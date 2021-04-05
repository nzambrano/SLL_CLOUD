package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:12:52 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class StdSubGeoDiv.
 * @see com.prosegur.sllpe.domain.StdSubGeoDiv
 * @author Hibernate Tools
 */

public class StdSubGeoDivHome {

    private static final Log log = LogFactory.getLog(StdSubGeoDivHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(StdSubGeoDiv transientInstance) {
        log.debug("persisting StdSubGeoDiv instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(StdSubGeoDiv persistentInstance) {
        log.debug("removing StdSubGeoDiv instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public StdSubGeoDiv merge(StdSubGeoDiv detachedInstance) {
        log.debug("merging StdSubGeoDiv instance");
        try {
            StdSubGeoDiv result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public StdSubGeoDiv findById( StdSubGeoDivId id) {
        log.debug("getting StdSubGeoDiv instance with id: " + id);
        try {
            StdSubGeoDiv instance = entityManager.find(StdSubGeoDiv.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

