package com.upgread.upgread.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class JoinDTO {
    String email;
    String password;
    String username;
    Date birth;
    Gender gender;
    String city;
}
