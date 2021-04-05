package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:05:51 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllMtAbogados.
 * @see com.prosegur.sllpe.domain.M4sllMtAbogados
 * @author Hibernate Tools
 */

public class M4sllMtAbogadosHome {

    private static final Log log = LogFactory.getLog(M4sllMtAbogadosHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllMtAbogados transientInstance) {
        log.debug("persisting M4sllMtAbogados instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllMtAbogados persistentInstance) {
        log.debug("removing M4sllMtAbogados instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllMtAbogados merge(M4sllMtAbogados detachedInstance) {
        log.debug("merging M4sllMtAbogados instance");
        try {
            M4sllMtAbogados result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllMtAbogados findById( M4sllMtAbogadosId id) {
        log.debug("getting M4sllMtAbogados instance with id: " + id);
        try {
            M4sllMtAbogados instance = entityManager.find(M4sllMtAbogados.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

