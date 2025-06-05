package com.bet99.bet99test.service;

import com.bet99.bet99test.entity.BugEntity;
import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import org.springframework.data.domain.Page;

public interface BugService {

    BugEntity save(BugEntity bugEntity);

    Page<BugEntity> findAll(final String query,
                            final Severity severity,
                            final Status status,
                            final Integer page,
                            final Integer pageSize,
                            final String sortBy,
                            final String sortDirection);

}