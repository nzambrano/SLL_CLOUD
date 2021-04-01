package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:10:53 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpStaDet.
 * @see com.prosegur.sllpe.domain.M4sllTpStaDet
 * @author Hibernate Tools
 */

public class M4sllTpStaDetHome {

    private static final Log log = LogFactory.getLog(M4sllTpStaDetHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpStaDet transientInstance) {
        log.debug("persisting M4sllTpStaDet instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpStaDet persistentInstance) {
        log.debug("removing M4sllTpStaDet instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpStaDet merge(M4sllTpStaDet detachedInstance) {
        log.debug("merging M4sllTpStaDet instance");
        try {
            M4sllTpStaDet result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpStaDet findById( M4sllTpStaDetId id) {
        log.debug("getting M4sllTpStaDet instance with id: " + id);
        try {
            M4sllTpStaDet instance = entityManager.find(M4sllTpStaDet.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

