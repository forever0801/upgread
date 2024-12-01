package com.upgread.upgread.controller;

import com.upgread.upgread.model.dao.ChallengeDao;
import com.upgread.upgread.model.dto.Challenge;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/challenge")
@RequiredArgsConstructor
public class ChallengeController {

    private final ChallengeDao challengeDao;

    @GetMapping("/all")
    public ResponseEntity<?> getAllChallenges(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            userId = 0;
        }

        List<Challenge> challenges = challengeDao.selectAll(userId);

        if (challenges.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("챌린지가 없습니다");
        }

        return ResponseEntity.status(HttpStatus.OK).body(challenges);
    }
}
