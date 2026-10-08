package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.exception.ResourceNotFoundException;
import com.dlu.lmsmobile.repository.StudentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StudentService {
    public List<Map<String, Object>> getContinueLearning(Long userId, Long courseId) {
        return studentRepository.findContinueLearning(userId, courseId);
    }
    public List<Map<String, Object>> getAllTasks(Long userId) {
        return studentRepository.findAllTasks(userId);
    }

    private final StudentRepository studentRepository;

    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    public Map<String, Object> getStudentDashboard(Long userId) {
        return studentRepository.findDashboardByUserId(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Student dashboard not found for userId: " + userId));
    }

    public List<Map<String, Object>> getStudentCourses(Long userId) {
        return studentRepository.findCoursesByUserId(userId);
    }

    public Map<String, Object> getStudentCourseAnalytics(Long userId, Long courseId) {
        return studentRepository.findCourseAnalyticsByUserIdAndCourseId(userId, courseId)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Student course analytics not found for userId: " + userId + " and courseId: " + courseId));
    }

    public List<Map<String, Object>> getStudentLearningItems(Long userId, Long courseId) {
        return studentRepository.findLearningItemsByUserIdAndCourseId(userId, courseId);
    }

    public List<Map<String, Object>> getStudentGrades(Long userId, Long courseId) {
        return studentRepository.findGradesByUserIdAndCourseId(userId, courseId);
    }

    public List<Map<String, Object>> getStudentGradeCategories(Long userId, Long courseId) {
        return studentRepository.findGradeCategoriesByUserIdAndCourseId(userId, courseId);
    }

    public Map<String, Object> getStudentAttendance(Long userId, Long courseId) {
        return studentRepository.findAttendanceByUserIdAndCourseId(userId, courseId)
                .orElse(null);
    }

    public List<Map<String, Object>> getStudentTasks(Long userId, Long courseId) {
        return studentRepository.findTasksByUserIdAndCourseId(userId, courseId);
    }
}
