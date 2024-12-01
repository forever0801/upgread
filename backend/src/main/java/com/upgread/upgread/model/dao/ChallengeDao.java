package com.upgread.upgread.model.dao;

import com.upgread.upgread.model.dto.Challenge;

import java.util.List;

public interface ChallengeDao {
    List<Challenge> selectAll(int userId);
}
