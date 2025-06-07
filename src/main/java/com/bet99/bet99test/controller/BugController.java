package com.bet99.bet99test.controller;

import com.bet99.bet99test.entity.BugEntity;
import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import com.bet99.bet99test.service.BugService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequiredArgsConstructor
public class BugController {

    private final BugService bugService;

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @ResponseBody
    @GetMapping("/bugs")
    public ResponseEntity<Page<BugEntity>> getBugs(
            @RequestParam(required = false) String query,
            @RequestParam(required = false) Severity severity,
            @RequestParam(required = false) Status status,
            @RequestParam(required = false, defaultValue = "0") Integer page,
            @RequestParam(required = false, defaultValue = "5") Integer pageSize,
            @RequestParam(required = false, defaultValue = "id") String sortBy,
            @RequestParam(required = false, defaultValue = "ASC") String sortDirection) {
        return ResponseEntity.ok(bugService.findAll(query, severity, status, page, pageSize, sortBy, sortDirection));
    }

    @ResponseBody
    @PostMapping("/bugs")
    public ResponseEntity<BugEntity> saveBug(@Valid @RequestBody BugEntity bugEntity) {
        return ResponseEntity.ok(bugService.save(bugEntity));
    }
}