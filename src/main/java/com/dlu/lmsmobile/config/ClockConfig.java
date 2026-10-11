package com.dlu.lmsmobile.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Clock;
import java.time.ZoneId;

/**
 * Clock used by learning-analytics services. The zone defines what "today", a "day" and a
 * "week" mean for streaks, heatmaps and weekly trends (Vietnam local time).
 */
@Configuration
public class ClockConfig {
    public static final ZoneId ANALYTICS_ZONE = ZoneId.of("Asia/Ho_Chi_Minh");

    @Bean
    public Clock analyticsClock() {
        return Clock.system(ANALYTICS_ZONE);
    }
}
