package com.fullstack.backend.service;


import com.fullstack.backend.enumeration.VerificationType;

public interface EmailService {
    void sendVerificationEmail(String firstName, String email, String verificationUrl, VerificationType verificationType);
}
