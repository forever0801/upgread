package com.upgread.upgread.controller;

import com.upgread.upgread.model.dao.ChallengeDao;
import com.upgread.upgread.model.dto.Challenge;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/join/{challengeId}")
    public ResponseEntity<?> challengeJoin(@PathVariable int challengeId, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 상태가 아닙니다");
        }

        boolean success = challengeDao.insertUserChallenge(challengeId, userId) == 1;

        if (success) {
            return ResponseEntity.status(HttpStatus.OK).body("챌린지에 참여했습니다");
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("챌린지 참여에 실패했습니다");
    }
}
