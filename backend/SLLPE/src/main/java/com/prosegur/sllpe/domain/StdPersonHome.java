package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class StdPerson.
 * @see com.prosegur.sllpe.domain.StdPerson
 * @author Hibernate Tools
 */

public class StdPersonHome {

    private static final Log log = LogFactory.getLog(StdPersonHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(StdPerson transientInstance) {
        log.debug("persisting StdPerson instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(StdPerson persistentInstance) {
        log.debug("removing StdPerson instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public StdPerson merge(StdPerson detachedInstance) {
        log.debug("merging StdPerson instance");
        try {
            StdPerson result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public StdPerson findById( StdPersonId id) {
        log.debug("getting StdPerson instance with id: " + id);
        try {
            StdPerson instance = entityManager.find(StdPerson.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

