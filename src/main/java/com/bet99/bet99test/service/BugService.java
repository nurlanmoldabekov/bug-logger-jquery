package com.bet99.bet99test.service;

import com.bet99.bet99test.entity.Bug;
import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import com.bet99.bet99test.repository.BugRepository;
import com.bet99.bet99test.util.PageUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BugService {

    private final BugRepository bugRepository;

    public Bug save(Bug bug) {
        return bugRepository.save(bug);
    }

    public List<Bug> findAll(final String query,
                             final Severity severity,
                             final Status status,
                             final Integer page,
                             final Integer pageSize,
                             final String sortBy,
                             final String sortDirection) {

        return bugRepository.findAllWithFilter(query, severity, status, PageRequest.of(page, pageSize, PageUtil.getSort(sortBy, sortDirection)));
    }

}