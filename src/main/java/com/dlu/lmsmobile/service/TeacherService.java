package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.exception.ResourceNotFoundException;
import com.dlu.lmsmobile.repository.TeacherRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TeacherService {

    private final TeacherRepository teacherRepository;

    public TeacherService(TeacherRepository teacherRepository) {
        this.teacherRepository = teacherRepository;
    }

    public List<Map<String, Object>> getTeacherCourses(Long teacherId) {
        return teacherRepository.findCoursesByTeacherId(teacherId);
    }

    public Map<String, Object> getTeacherCourseAnalytics(Long teacherId, Long courseId) {
        return teacherRepository.findCourseAnalyticsByTeacherIdAndCourseId(teacherId, courseId)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Teacher course analytics not found for teacherId: " + teacherId + " and courseId: " + courseId));
    }
}
