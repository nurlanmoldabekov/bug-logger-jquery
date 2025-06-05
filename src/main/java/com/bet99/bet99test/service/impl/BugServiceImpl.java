package com.bet99.bet99test.service.impl;

import com.bet99.bet99test.entity.BugEntity;
import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import com.bet99.bet99test.repository.BugRepository;
import com.bet99.bet99test.service.BugService;
import com.bet99.bet99test.util.PageUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BugServiceImpl implements BugService {

    private final BugRepository bugRepository;

    @Override
    public BugEntity save(BugEntity bugEntity) {
        return bugRepository.save(bugEntity);
    }

    @Override
    public Page<BugEntity> findAll(final String query,
                                   final Severity severity,
                                   final Status status,
                                   final Integer page,
                                   final Integer pageSize,
                                   final String sortBy,
                                   final String sortDirection) {

        return bugRepository.findAllWithFilter(query, severity, status, PageRequest.of(page, pageSize, PageUtil.getSort(sortBy, sortDirection)));
    }

}