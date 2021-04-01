package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllMtoRiesgos.
 * @see com.prosegur.sllpe.domain.M4sllMtoRiesgos
 * @author Hibernate Tools
 */

public class M4sllMtoRiesgosHome {

    private static final Log log = LogFactory.getLog(M4sllMtoRiesgosHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllMtoRiesgos transientInstance) {
        log.debug("persisting M4sllMtoRiesgos instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllMtoRiesgos persistentInstance) {
        log.debug("removing M4sllMtoRiesgos instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllMtoRiesgos merge(M4sllMtoRiesgos detachedInstance) {
        log.debug("merging M4sllMtoRiesgos instance");
        try {
            M4sllMtoRiesgos result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllMtoRiesgos findById( M4sllMtoRiesgosId id) {
        log.debug("getting M4sllMtoRiesgos instance with id: " + id);
        try {
            M4sllMtoRiesgos instance = entityManager.find(M4sllMtoRiesgos.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

