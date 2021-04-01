package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllNegocios.
 * @see com.prosegur.sllpe.domain.M4sllNegocios
 * @author Hibernate Tools
 */

public class M4sllNegociosHome {

    private static final Log log = LogFactory.getLog(M4sllNegociosHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllNegocios transientInstance) {
        log.debug("persisting M4sllNegocios instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllNegocios persistentInstance) {
        log.debug("removing M4sllNegocios instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllNegocios merge(M4sllNegocios detachedInstance) {
        log.debug("merging M4sllNegocios instance");
        try {
            M4sllNegocios result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllNegocios findById( M4sllNegociosId id) {
        log.debug("getting M4sllNegocios instance with id: " + id);
        try {
            M4sllNegocios instance = entityManager.find(M4sllNegocios.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

