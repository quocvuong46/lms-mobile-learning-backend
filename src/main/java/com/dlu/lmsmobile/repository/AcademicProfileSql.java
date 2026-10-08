package com.dlu.lmsmobile.repository;

/** Optional academic metadata. The existing monitoring/dashboard row remains authoritative. */
final class AcademicProfileSql {
    private AcademicProfileSql() { }

    // Only repository-owned SQL expressions are passed here, never request values.
    static String leftJoin(String userIdExpression) {
        return """
            LEFT JOIN LATERAL (
                SELECT p.student_code, p.cohort_code, p.class_code, p.major_name
                FROM derived.student_academic_profile p
                WHERE p.userid = %s
                ORDER BY p.student_code NULLS LAST, p.cohort_code NULLS LAST,
                         p.class_code NULLS LAST, p.major_name NULLS LAST
                LIMIT 1
            ) sap ON TRUE
            """.formatted(userIdExpression);
    }
}
