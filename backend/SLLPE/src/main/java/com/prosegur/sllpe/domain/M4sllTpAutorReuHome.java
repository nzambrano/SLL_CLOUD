package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpAutorReu.
 * @see com.prosegur.sllpe.domain.M4sllTpAutorReu
 * @author Hibernate Tools
 */

public class M4sllTpAutorReuHome {

    private static final Log log = LogFactory.getLog(M4sllTpAutorReuHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpAutorReu transientInstance) {
        log.debug("persisting M4sllTpAutorReu instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpAutorReu persistentInstance) {
        log.debug("removing M4sllTpAutorReu instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpAutorReu merge(M4sllTpAutorReu detachedInstance) {
        log.debug("merging M4sllTpAutorReu instance");
        try {
            M4sllTpAutorReu result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpAutorReu findById( M4sllTpAutorReuId id) {
        log.debug("getting M4sllTpAutorReu instance with id: " + id);
        try {
            M4sllTpAutorReu instance = entityManager.find(M4sllTpAutorReu.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

