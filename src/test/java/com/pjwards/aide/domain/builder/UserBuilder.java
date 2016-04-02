package com.pjwards.aide.domain.builder;


import com.pjwards.aide.domain.User;
import com.pjwards.aide.domain.enums.Role;
import org.springframework.test.util.ReflectionTestUtils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UserBuilder {
    public static final String DAY_FORMAT = "yyyy-MM-dd";

    private User model;

    public UserBuilder(){
        model = new User();
    }

    public UserBuilder id(Long id){
        ReflectionTestUtils.setField(model, "id", id);
        return this;
    }

    public UserBuilder name(String name){
        model.update(name, model.getEmail(), model.getPassword(), model.getCreatedDate(),
                model.getLastDate(), model.getCompany(), model.getRole());
        return this;
    }

    public UserBuilder email(String email){
        model.update(model.getName(), email, model.getPassword(), model.getCreatedDate(),
                model.getLastDate(), model.getCompany(), model.getRole());
        return this;
    }

    public UserBuilder password(String password){
        model.update(model.getName(), model.getEmail(), password,model.getCreatedDate(),
                model.getLastDate(), model.getCompany(), model.getRole());
        return this;
    }

    public UserBuilder createdDate(String createdDate) throws ParseException{
        DateFormat formatter = new SimpleDateFormat(DAY_FORMAT);
        Date tempDate = model.truncateDate(formatter.parse(createdDate));
        model.update(model.getName(), model.getEmail(), model.getPassword(), tempDate, model.getLastDate(),
                model.getCompany(), model.getRole());
        return this;
    }

    public UserBuilder lastDate(String lastDate) throws ParseException{
        DateFormat formatter = new SimpleDateFormat(DAY_FORMAT);
        Date tempDate = model.truncateDate(formatter.parse(lastDate));
        model.update(model.getName(), model.getEmail(), model.getPassword(),model.getCreatedDate(),
                tempDate, model.getCompany(), model.getRole());
        return this;
    }

    public UserBuilder company(String company){
        model.update(model.getName(), model.getEmail(), model.getPassword(),model.getCreatedDate(),
                model.getLastDate(), company, model.getRole());
        return this;
    }

    public UserBuilder role(Role role){
        model.update(model.getName(), model.getEmail(), model.getPassword(), model.getCreatedDate(),
                model.getLastDate(), model.getCompany(), role);
        return this;
    }

    public User build(){
        return model;
    }
}
