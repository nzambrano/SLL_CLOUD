package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:06:54 AM by Hibernate Tools 5.2.0.Final



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpDocLitig.
 * @see com.prosegur.sllpe.domain.M4sllTpDocLitig
 * @author Hibernate Tools
 */

public class M4sllTpDocLitigHome {

    private static final Log log = LogFactory.getLog(M4sllTpDocLitigHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpDocLitig transientInstance) {
        log.debug("persisting M4sllTpDocLitig instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpDocLitig persistentInstance) {
        log.debug("removing M4sllTpDocLitig instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpDocLitig merge(M4sllTpDocLitig detachedInstance) {
        log.debug("merging M4sllTpDocLitig instance");
        try {
            M4sllTpDocLitig result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpDocLitig findById( M4sllTpDocLitigId id) {
        log.debug("getting M4sllTpDocLitig instance with id: " + id);
        try {
            M4sllTpDocLitig instance = entityManager.find(M4sllTpDocLitig.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

