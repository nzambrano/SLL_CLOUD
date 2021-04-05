package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:09:50 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpMotivo.
 * @see com.prosegur.sllpe.domain.M4sllTpMotivo
 * @author Hibernate Tools
 */

public class M4sllTpMotivoHome {

    private static final Log log = LogFactory.getLog(M4sllTpMotivoHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpMotivo transientInstance) {
        log.debug("persisting M4sllTpMotivo instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpMotivo persistentInstance) {
        log.debug("removing M4sllTpMotivo instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpMotivo merge(M4sllTpMotivo detachedInstance) {
        log.debug("merging M4sllTpMotivo instance");
        try {
            M4sllTpMotivo result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpMotivo findById( M4sllTpMotivoId id) {
        log.debug("getting M4sllTpMotivo instance with id: " + id);
        try {
            M4sllTpMotivo instance = entityManager.find(M4sllTpMotivo.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

