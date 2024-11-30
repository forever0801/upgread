package com.upgread.upgread.model.dao;

import com.upgread.upgread.model.dto.LoginDTO;

public interface UserDao {
    Integer selectUserId(LoginDTO user);
}
