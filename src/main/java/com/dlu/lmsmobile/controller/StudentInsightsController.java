package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.GoalService;
import com.dlu.lmsmobile.service.InsightsService;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * Personal learning insights and goals. Like the other /dev routes, the path user id stands in
 * for the signed-in student until authentication is re-enabled; every query is scoped to it.
 */
@RestController
@RequestMapping("/api/v1/dev/students/{userId}")
public class StudentInsightsController {
    private final InsightsService insights;
    private final GoalService goals;

    public StudentInsightsController(InsightsService insights, GoalService goals) {
        this.insights = insights;
        this.goals = goals;
    }

    @GetMapping("/insights")
    public Map<String, Object> getInsights(@PathVariable Long userId, @RequestParam(defaultValue = "56") int days) {
        return insights.getStudentInsights(userId, days);
    }

    @GetMapping("/goals")
    public List<Map<String, Object>> getGoals(@PathVariable Long userId) {
        return goals.list(userId);
    }

    @PostMapping("/goals")
    public ResponseEntity<Map<String, Object>> createGoal(@PathVariable Long userId, @RequestBody GoalRequest request) {
        Map<String, Object> created = goals.create(userId, request.goalType(), request.targetValue(),
            request.courseId(), request.startDate(), request.endDate());
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PostMapping("/goals/{goalId}/cancel")
    public Map<String, Object> cancelGoal(@PathVariable Long userId, @PathVariable Long goalId) {
        return goals.cancel(userId, goalId);
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record GoalRequest(
        @JsonProperty("goal_type") String goalType,
        @JsonProperty("target_value") BigDecimal targetValue,
        @JsonProperty("course_id") Long courseId,
        @JsonProperty("start_date") LocalDate startDate,
        @JsonProperty("end_date") LocalDate endDate) {
    }
}
