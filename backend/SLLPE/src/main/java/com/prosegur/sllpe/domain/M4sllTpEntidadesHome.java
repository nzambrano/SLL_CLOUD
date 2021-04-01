package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpEntidades.
 * @see com.prosegur.sllpe.domain.M4sllTpEntidades
 * @author Hibernate Tools
 */

public class M4sllTpEntidadesHome {

    private static final Log log = LogFactory.getLog(M4sllTpEntidadesHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpEntidades transientInstance) {
        log.debug("persisting M4sllTpEntidades instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpEntidades persistentInstance) {
        log.debug("removing M4sllTpEntidades instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpEntidades merge(M4sllTpEntidades detachedInstance) {
        log.debug("merging M4sllTpEntidades instance");
        try {
            M4sllTpEntidades result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpEntidades findById( M4sllTpEntidadesId id) {
        log.debug("getting M4sllTpEntidades instance with id: " + id);
        try {
            M4sllTpEntidades instance = entityManager.find(M4sllTpEntidades.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

