package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.TeacherService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/dev/teachers")
public class DevTeacherController {

    private final TeacherService teacherService;

    public DevTeacherController(TeacherService teacherService) {
        this.teacherService = teacherService;
    }

    @GetMapping("/{teacherId}/courses")
    public List<Map<String, Object>> getCourses(@PathVariable Long teacherId) {
        return teacherService.getTeacherCourses(teacherId);
    }

    @GetMapping("/{teacherId}/courses/{courseId}/analytics")
    public Map<String, Object> getCourseAnalytics(
            @PathVariable Long teacherId,
            @PathVariable Long courseId) {
        return teacherService.getTeacherCourseAnalytics(teacherId, courseId);
    }
}
