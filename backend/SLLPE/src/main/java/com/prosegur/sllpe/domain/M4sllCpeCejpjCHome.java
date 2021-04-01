package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllCpeCejpjC.
 * @see com.prosegur.sllpe.domain.M4sllCpeCejpjC
 * @author Hibernate Tools
 */

public class M4sllCpeCejpjCHome {

    private static final Log log = LogFactory.getLog(M4sllCpeCejpjCHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllCpeCejpjC transientInstance) {
        log.debug("persisting M4sllCpeCejpjC instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllCpeCejpjC persistentInstance) {
        log.debug("removing M4sllCpeCejpjC instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllCpeCejpjC merge(M4sllCpeCejpjC detachedInstance) {
        log.debug("merging M4sllCpeCejpjC instance");
        try {
            M4sllCpeCejpjC result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllCpeCejpjC findById( M4sllCpeCejpjCId id) {
        log.debug("getting M4sllCpeCejpjC instance with id: " + id);
        try {
            M4sllCpeCejpjC instance = entityManager.find(M4sllCpeCejpjC.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

