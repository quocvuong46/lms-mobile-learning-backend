package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.TeacherMonitoringService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/dev/teachers/{teacherId}/courses/{courseId}")
public class TeacherMonitoringController {
    private final TeacherMonitoringService service;
    public TeacherMonitoringController(TeacherMonitoringService service) { this.service = service; }
    @GetMapping("/students")
    public List<Map<String, Object>> students(@PathVariable Long teacherId, @PathVariable Long courseId) {
        return service.roster(teacherId, courseId);
    }
    @GetMapping("/students/{userId}")
    public Map<String, Object> student(@PathVariable Long teacherId, @PathVariable Long courseId, @PathVariable Long userId) {
        return service.studentDetail(teacherId, courseId, userId);
    }
    @GetMapping("/assignments")
    public List<Map<String, Object>> assignments(@PathVariable Long teacherId, @PathVariable Long courseId) {
        return service.activities(teacherId, courseId, "assignment");
    }
    @GetMapping("/assignments/{assignmentId}/students")
    public List<Map<String, Object>> assignmentStudents(@PathVariable Long teacherId, @PathVariable Long courseId, @PathVariable Long assignmentId) {
        return service.activityStudents(teacherId, courseId, "assignment", assignmentId);
    }
    @GetMapping("/quizzes")
    public List<Map<String, Object>> quizzes(@PathVariable Long teacherId, @PathVariable Long courseId) {
        return service.activities(teacherId, courseId, "quiz");
    }
    @GetMapping("/quizzes/{quizId}/students")
    public List<Map<String, Object>> quizStudents(@PathVariable Long teacherId, @PathVariable Long courseId, @PathVariable Long quizId) {
        return service.activityStudents(teacherId, courseId, "quiz", quizId);
    }
}
