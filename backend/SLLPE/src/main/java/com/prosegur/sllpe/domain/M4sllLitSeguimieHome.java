package com.prosegur.sllpe.domain;
// Generated Mar 25, 2021, 4:12:31 PM by Hibernate Tools 5.2.0.Final


import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllLitSeguimie.
 * @see com.prosegur.sllpe.domain.M4sllLitSeguimie
 * @author Hibernate Tools
 */

public class M4sllLitSeguimieHome {

    private static final Log log = LogFactory.getLog(M4sllLitSeguimieHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllLitSeguimie transientInstance) {
        log.debug("persisting M4sllLitSeguimie instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        }
        catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllLitSeguimie persistentInstance) {
        log.debug("removing M4sllLitSeguimie instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        }
        catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllLitSeguimie merge(M4sllLitSeguimie detachedInstance) {
        log.debug("merging M4sllLitSeguimie instance");
        try {
            M4sllLitSeguimie result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        }
        catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllLitSeguimie findById( M4sllLitSeguimieId id) {
        log.debug("getting M4sllLitSeguimie instance with id: " + id);
        try {
            M4sllLitSeguimie instance = entityManager.find(M4sllLitSeguimie.class, id);
            log.debug("get successful");
            return instance;
        }
        catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

