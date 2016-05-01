package com.pjwards.aide.domain.validators;

import com.pjwards.aide.domain.forms.SignUpForm;
import com.pjwards.aide.service.user.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class SignUpFormValidator implements Validator {
    private static final Logger LOGGER = LoggerFactory.getLogger(SignUpFormValidator.class);
    private final UserService userService;
    private final EmailValidator emailValidator;

    @Autowired
    public SignUpFormValidator(UserService userService, EmailValidator emailValidator){
        this.userService = userService;
        this.emailValidator = emailValidator;
    }


    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.equals(SignUpForm.class);
    }

    @Override
    public void validate(Object target, Errors errors) {
        LOGGER.debug("Validating {}", target);
        SignUpForm form = (SignUpForm) target;
        validateEmailEmpty(errors, form);
        validateNameEmpty(errors, form);
        validatePasswordEmpty(errors, form);
        validatePasswordRepeatedEmpty(errors, form);
        validatePasswordLength(errors, form);
        validatePasswordRepeatedLength(errors, form);
        validatePasswords(errors, form);
        validateEmailAddress(errors, form);
        validateEmail(errors, form);
    }

    private void validateEmailEmpty(Errors errors, SignUpForm form) {
        if (form.getEmail() == null || form.getEmail().equals("")) {
            errors.reject("email.empty", "Email is empty");
        }
    }

    private void validateNameEmpty(Errors errors, SignUpForm form){
        if (form.getName() == null || form.getName().equals("")) {
            errors.reject("name.empty", "Name is empty");
        }
    }

    private void validatePasswordEmpty(Errors errors, SignUpForm form){
        if (form.getPassword() == null || form.getPassword().equals("")) {
            errors.reject("password.empty", "Password is empty");
        }
    }

    private void validatePasswordRepeatedEmpty(Errors errors, SignUpForm form){
        if (form.getPasswordRepeated() == null || form.getPasswordRepeated().equals("")) {
            errors.reject("passwordRepeated.empty", "PasswordRepeated is empty");
        }
    }

    private void validatePasswordLength(Errors errors, SignUpForm form){
        if (form.getPassword().length() < 7) {
            errors.reject("password.empty", "Password is too short (minimum is 7 characters)");
        }
    }

    private void validatePasswordRepeatedLength(Errors errors, SignUpForm form){
        if (form.getPasswordRepeated().length() < 7) {
            errors.reject("passwordRepeated.empty", "PasswordRepeated is too short (minimum is 7 characters)");
        }
    }

    private void validatePasswords(Errors errors, SignUpForm form) {
        if (!form.getPassword().equals(form.getPasswordRepeated())) {
            errors.reject("password.no_match", "Passwords do not match");
        }
    }

    private void validateEmail(Errors errors, SignUpForm form) {

        try {
            userService.findByEmail(form.getEmail()).get();
        } catch (Exception ex){
            return;
        }

        errors.reject("email.exists", "User with this email already exists");
    }

    private void validateEmailAddress(Errors errors, SignUpForm form) {
        if(!emailValidator.validate(form.getEmail())){
            errors.reject("email.no_validate", "Email does not validate");
        }
    }
}
