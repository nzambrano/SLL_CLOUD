package com.prosegur.sllpe.domain;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Home object for domain model class M4sllTpRoles.
 * @see com.prosegur.sllpe.domain.M4sllTpRoles
 * @author Hibernate Tools
 */

public class M4sllTpRolesHome {

    private static final Log log = LogFactory.getLog(M4sllTpRolesHome.class);

    @PersistenceContext private EntityManager entityManager;

    public void persist(M4sllTpRoles transientInstance) {
        log.debug("persisting M4sllTpRoles instance");
        try {
            entityManager.persist(transientInstance);
            log.debug("persist successful");
        } catch (RuntimeException re) {
            log.error("persist failed", re);
            throw re;
        }
    }

    public void remove(M4sllTpRoles persistentInstance) {
        log.debug("removing M4sllTpRoles instance");
        try {
            entityManager.remove(persistentInstance);
            log.debug("remove successful");
        } catch (RuntimeException re) {
            log.error("remove failed", re);
            throw re;
        }
    }

    public M4sllTpRoles merge(M4sllTpRoles detachedInstance) {
        log.debug("merging M4sllTpRoles instance");
        try {
            M4sllTpRoles result = entityManager.merge(detachedInstance);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
    }

    public M4sllTpRoles findById( M4sllTpRolesId id) {
        log.debug("getting M4sllTpRoles instance with id: " + id);
        try {
            M4sllTpRoles instance = entityManager.find(M4sllTpRoles.class, id);
            log.debug("get successful");
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
}

