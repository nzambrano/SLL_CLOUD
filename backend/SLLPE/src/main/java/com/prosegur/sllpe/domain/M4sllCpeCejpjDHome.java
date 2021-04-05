package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:13:38 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllCpeCejpjD.
 * @see com.prosegur.sllpe.domain.M4sllCpeCejpjD
 * @author Hibernate Tools
 */

public class M4sllCpeCejpjDHome {

    private static final Log log = LogFactory.getLog(M4sllCpeCejpjDHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllCpeCejpjD transientInstance) {
        log.debug("persisting M4sllCpeCejpjD instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllCpeCejpjD persistentInstance) {
        log.debug("removing M4sllCpeCejpjD instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllCpeCejpjD merge(M4sllCpeCejpjD detachedInstance) {
        log.debug("merging M4sllCpeCejpjD instance");
        try {
            M4sllCpeCejpjD result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllCpeCejpjD findById( M4sllCpeCejpjDId id) {
        log.debug("getting M4sllCpeCejpjD instance with id: " + id);
        try {
            M4sllCpeCejpjD instance = entityManager.find(M4sllCpeCejpjD.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

