package com.bet99.bet99test.repository;

import com.bet99.bet99test.entity.Bug;
import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BugRepository extends JpaRepository<Bug, Long> {

    @Query("""
            SELECT b FROM Bug b WHERE
            (:query IS NULL OR b.bugTitle LIKE %:query% OR b.description LIKE %:query%) AND
            (:severity IS NULL OR b.severity = :severity) AND
            (:status IS NULL OR b.status = :status)
            """)
    List<Bug> findAllWithFilter(String query,
                                Severity severity,
                                Status status,
                                Pageable pageable);
}