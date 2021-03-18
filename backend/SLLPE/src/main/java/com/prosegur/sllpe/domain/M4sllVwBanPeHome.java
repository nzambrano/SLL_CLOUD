package com.prosegur.sllpe.domain;
// Generated Mar 17, 2021, 9:52:01 AM by Hibernate Tools 5.2.0.Final


import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllVwBanPe.
 * @see com.prosegur.sllpe.domain.M4sllVwBanPe
 * @author Hibernate Tools
 */
public class M4sllVwBanPeHome {

    private static final Log log = LogFactory.getLog(M4sllVwBanPeHome.class);

    @PersistenceContext private EntityManager entityManager;
    
    public void persist(M4sllVwBanPe transientInstance) {
        log.debug("persisting M4sllVwBanPe instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        }
        catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }
    
    public void remove(M4sllVwBanPe persistentInstance) {
        log.debug("removing M4sllVwBanPe instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        }
        catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }
    
    public M4sllVwBanPe merge(M4sllVwBanPe detachedInstance) {
        log.debug("merging M4sllVwBanPe instance");
        try {
            M4sllVwBanPe result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        }
        catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }
    
    public M4sllVwBanPe findById( M4sllVwBanPeId id) {
        log.debug("getting M4sllVwBanPe instance with id: " + id);
        try {
            M4sllVwBanPe instance = entityManager.find(M4sllVwBanPe.class, id);
            log.debug("get successful");
            return instance;
        }
        catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

