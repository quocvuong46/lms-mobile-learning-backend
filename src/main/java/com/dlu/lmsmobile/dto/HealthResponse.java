package com.dlu.lmsmobile.dto;

public class HealthResponse {
    private String status;
    private String database;

    public HealthResponse() {
    }

    public HealthResponse(String status, String database) {
        this.status = status;
        this.database = database;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDatabase() {
        return database;
    }

    public void setDatabase(String database) {
        this.database = database;
    }
}
