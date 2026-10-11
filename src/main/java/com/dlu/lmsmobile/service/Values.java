package com.dlu.lmsmobile.service;

import java.time.Instant;
import java.time.LocalDate;
import java.util.Date;

/** Null-safe conversions for the untyped rows returned by JdbcTemplate. */
final class Values {
    private Values() {
    }

    static Double num(Object value) {
        return value instanceof Number n ? n.doubleValue() : null;
    }

    static long lng(Object value) {
        return value instanceof Number n ? n.longValue() : 0L;
    }

    static String str(Object value) {
        return value == null ? null : value.toString();
    }

    static Double round1(Double value) {
        return value == null ? null : Math.round(value * 10.0) / 10.0;
    }

    static LocalDate date(Object value) {
        if (value instanceof LocalDate d) return d;
        if (value instanceof java.sql.Date d) return d.toLocalDate();
        return null;
    }

    /** ISO-8601 instant for timestamp columns, or null. */
    static String instant(Object value) {
        if (value instanceof java.sql.Timestamp t) return t.toInstant().toString();
        if (value instanceof Instant i) return i.toString();
        if (value instanceof java.time.OffsetDateTime o) return o.toInstant().toString();
        if (value instanceof Date d) return d.toInstant().toString();
        return null;
    }
}
