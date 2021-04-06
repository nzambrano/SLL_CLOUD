package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpValEco.
 * @see com.prosegur.sllpe.domain.M4sllTpValEco
 * @author Hibernate Tools
 */

public class M4sllTpValEcoHome {

    private static final Log log = LogFactory.getLog(M4sllTpValEcoHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpValEco transientInstance) {
        log.debug("persisting M4sllTpValEco instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpValEco persistentInstance) {
        log.debug("removing M4sllTpValEco instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpValEco merge(M4sllTpValEco detachedInstance) {
        log.debug("merging M4sllTpValEco instance");
        try {
            M4sllTpValEco result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpValEco findById( M4sllTpValEcoId id) {
        log.debug("getting M4sllTpValEco instance with id: " + id);
        try {
            M4sllTpValEco instance = entityManager.find(M4sllTpValEco.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

