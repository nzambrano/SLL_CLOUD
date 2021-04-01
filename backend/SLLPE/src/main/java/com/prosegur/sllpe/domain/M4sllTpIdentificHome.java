package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpIdentific.
 * @see com.prosegur.sllpe.domain.M4sllTpIdentific
 * @author Hibernate Tools
 */

public class M4sllTpIdentificHome {

    private static final Log log = LogFactory.getLog(M4sllTpIdentificHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpIdentific transientInstance) {
        log.debug("persisting M4sllTpIdentific instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpIdentific persistentInstance) {
        log.debug("removing M4sllTpIdentific instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpIdentific merge(M4sllTpIdentific detachedInstance) {
        log.debug("merging M4sllTpIdentific instance");
        try {
            M4sllTpIdentific result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpIdentific findById( M4sllTpIdentificId id) {
        log.debug("getting M4sllTpIdentific instance with id: " + id);
        try {
            M4sllTpIdentific instance = entityManager.find(M4sllTpIdentific.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

