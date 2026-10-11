package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.ClassInsightsService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/dev/teachers/{teacherId}/courses/{courseId}")
public class TeacherInsightsController {
    private final ClassInsightsService service;

    public TeacherInsightsController(ClassInsightsService service) {
        this.service = service;
    }

    @GetMapping("/class-insights")
    public Map<String, Object> classInsights(@PathVariable Long teacherId, @PathVariable Long courseId,
                                             @RequestParam(defaultValue = "8") int weeks) {
        return service.getClassInsights(teacherId, courseId, weeks);
    }
}
