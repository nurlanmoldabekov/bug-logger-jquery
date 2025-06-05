package com.bet99.bet99test.repository;

import com.bet99.bet99test.entity.BugEntity;
import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


@Repository
public interface BugRepository extends JpaRepository<BugEntity, Long> {

    @Query("""
            SELECT b FROM BugEntity b WHERE
            (:query IS NULL OR b.bugTitle LIKE %:query% OR b.description LIKE %:query%) AND
            (:severity IS NULL OR b.severity = :severity) AND
            (:status IS NULL OR b.status = :status)
            """)
    Page<BugEntity> findAllWithFilter(String query,
                                      Severity severity,
                                      Status status,
                                      Pageable pageable);
}