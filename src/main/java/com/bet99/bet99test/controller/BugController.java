package com.bet99.bet99test.controller;

import com.bet99.bet99test.entity.Bug;
import com.bet99.bet99test.entity.enums.Severity;
import com.bet99.bet99test.entity.enums.Status;
import com.bet99.bet99test.service.BugService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class BugController {


    private final BugService bugService;

    @GetMapping("/")
    public String home() {
        return "bug"; // this resolves to /WEB-INF/views/bugs.jsp
    }

    @ResponseBody
    @GetMapping("/bugs")
    public List<Bug> getBugs(
            @RequestParam(required = false) String query,
            @RequestParam(required = false) Severity severity,
            @RequestParam(required = false) Status status,
            @RequestParam(required = false, defaultValue = "0") Integer page,
            @RequestParam(required = false, defaultValue = "5") Integer pageSize,
            @RequestParam(required = false, defaultValue = "id") String sortBy,
            @RequestParam(required = false, defaultValue = "ASC") String sortDirection) {
        return bugService.findAll(query, severity, status, page, pageSize, sortBy, sortDirection);
    }

    @ResponseBody
    @PostMapping("/bugs")
    public Bug saveBug(@RequestBody Bug bug) {
        return bugService.save(bug);
    }
}