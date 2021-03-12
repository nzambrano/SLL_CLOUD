package com.prosegur.sllpe.domain;
// Generated Mar 11, 2021, 2:20:43 PM by Hibernate Tools 5.2.0.Final


import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllLitigios.
 * @see com.prosegur.sllpe.domain.M4sllLitigios
 * @author Hibernate Tools
 */

public class M4sllLitigiosHome {

    private static final Log log = LogFactory.getLog(M4sllLitigiosHome.class);

    @PersistenceContext private EntityManager entityManager;
    
    public void persist(M4sllLitigios transientInstance) {
        log.debug("persisting M4sllLitigios instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        }
        catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }
    
    public void remove(M4sllLitigios persistentInstance) {
        log.debug("removing M4sllLitigios instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        }
        catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }
    
    public M4sllLitigios merge(M4sllLitigios detachedInstance) {
        log.debug("merging M4sllLitigios instance");
        try {
            M4sllLitigios result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        }
        catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }
    
    public M4sllLitigios findById( M4sllLitigiosId id) {
        log.debug("getting M4sllLitigios instance with id: " + id);
        try {
            M4sllLitigios instance = entityManager.find(M4sllLitigios.class, id);
            log.debug("get successful");
            return instance;
        }
        catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

