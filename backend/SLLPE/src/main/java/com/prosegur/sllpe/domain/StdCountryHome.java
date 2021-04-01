package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:11:49 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class StdCountry.
 * @see com.prosegur.sllpe.domain.StdCountry
 * @author Hibernate Tools
 */

public class StdCountryHome {

    private static final Log log = LogFactory.getLog(StdCountryHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(StdCountry transientInstance) {
        log.debug("persisting StdCountry instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(StdCountry persistentInstance) {
        log.debug("removing StdCountry instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public StdCountry merge(StdCountry detachedInstance) {
        log.debug("merging StdCountry instance");
        try {
            StdCountry result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public StdCountry findById( StdCountryId id) {
        log.debug("getting StdCountry instance with id: " + id);
        try {
            StdCountry instance = entityManager.find(StdCountry.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

