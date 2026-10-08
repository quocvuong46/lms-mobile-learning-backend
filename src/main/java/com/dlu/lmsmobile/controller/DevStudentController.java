package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.StudentService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/dev/students")
public class DevStudentController {
    @GetMapping("/{userId}/continue-learning")
    public List<Map<String, Object>> getContinueLearning(@PathVariable Long userId, @RequestParam(required = false) Long courseId) {
        return studentService.getContinueLearning(userId, courseId);
    }
    @GetMapping("/{userId}/tasks")
    public List<Map<String, Object>> getAllTasks(@PathVariable Long userId) {
        return studentService.getAllTasks(userId);
    }

    private final StudentService studentService;

    public DevStudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping("/{userId}/dashboard")
    public Map<String, Object> getDashboard(@PathVariable Long userId) {
        return studentService.getStudentDashboard(userId);
    }

    @GetMapping("/{userId}/courses")
    public List<Map<String, Object>> getCourses(@PathVariable Long userId) {
        return studentService.getStudentCourses(userId);
    }

    @GetMapping("/{userId}/courses/{courseId}/analytics")
    public Map<String, Object> getCourseAnalytics(
            @PathVariable Long userId,
            @PathVariable Long courseId) {
        return studentService.getStudentCourseAnalytics(userId, courseId);
    }

    @GetMapping("/{userId}/courses/{courseId}/learning-items")
    public List<Map<String, Object>> getLearningItems(
            @PathVariable Long userId,
            @PathVariable Long courseId) {
        return studentService.getStudentLearningItems(userId, courseId);
    }

    @GetMapping("/{userId}/courses/{courseId}/grades")
    public List<Map<String, Object>> getGrades(
            @PathVariable Long userId,
            @PathVariable Long courseId) {
        return studentService.getStudentGrades(userId, courseId);
    }

    @GetMapping("/{userId}/courses/{courseId}/grade-categories")
    public List<Map<String, Object>> getGradeCategories(
            @PathVariable Long userId,
            @PathVariable Long courseId) {
        return studentService.getStudentGradeCategories(userId, courseId);
    }

    @GetMapping("/{userId}/courses/{courseId}/attendance")
    public Map<String, Object> getAttendance(
            @PathVariable Long userId,
            @PathVariable Long courseId) {
        return studentService.getStudentAttendance(userId, courseId);
    }

    @GetMapping("/{userId}/courses/{courseId}/tasks")
    public List<Map<String, Object>> getTasks(
            @PathVariable Long userId,
            @PathVariable Long courseId) {
        return studentService.getStudentTasks(userId, courseId);
    }
}
