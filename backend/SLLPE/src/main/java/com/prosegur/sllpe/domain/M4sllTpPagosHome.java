package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpPagos.
 * @see com.prosegur.sllpe.domain.M4sllTpPagos
 * @author Hibernate Tools
 */

public class M4sllTpPagosHome {

    private static final Log log = LogFactory.getLog(M4sllTpPagosHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpPagos transientInstance) {
        log.debug("persisting M4sllTpPagos instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpPagos persistentInstance) {
        log.debug("removing M4sllTpPagos instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpPagos merge(M4sllTpPagos detachedInstance) {
        log.debug("merging M4sllTpPagos instance");
        try {
            M4sllTpPagos result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpPagos findById( M4sllTpPagosId id) {
        log.debug("getting M4sllTpPagos instance with id: " + id);
        try {
            M4sllTpPagos instance = entityManager.find(M4sllTpPagos.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

