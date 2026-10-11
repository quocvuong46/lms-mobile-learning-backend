package com.dlu.lmsmobile.exception;

/** Raised when a client request is well-formed JSON but violates a business rule (HTTP 400). */
public class InvalidRequestException extends RuntimeException {
    public InvalidRequestException(String message) {
        super(message);
    }
}
