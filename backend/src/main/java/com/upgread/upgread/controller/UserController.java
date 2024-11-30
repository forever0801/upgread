package com.upgread.upgread.controller;

import com.upgread.upgread.model.dao.UserDao;
import com.upgread.upgread.model.dto.JoinDTO;
import com.upgread.upgread.model.dto.LoginDTO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserDao userDao;

    @GetMapping("/login")
    public ResponseEntity<String> isLoggedin(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId != null) {
            return ResponseEntity.status(HttpStatus.OK).body("로그인 상태입니다");
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 상태가 아닙니다");
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginDTO user, HttpSession session) {

        if (user.getEmail() == null || user.getPassword() == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이메일과 비밀번호를 입력해주세요");
        }

        Integer userId = userDao.selectUserId(user);

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("이메일 또는 비밀번호가 맞지 않습니다");
        }

        session.setAttribute("userId", userId);
        return ResponseEntity.status(HttpStatus.OK).body("로그인이 완료되었습니다");
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 상태가 아닙니다");
        }

        session.invalidate();
        return ResponseEntity.status(HttpStatus.OK).body("로그아웃 되었습니다");
    }

    @PostMapping("/join")
    public ResponseEntity<?> join(@RequestBody JoinDTO user) {
        boolean success = userDao.insertUser(user) == 1;

        if (success) {
            return ResponseEntity.status(HttpStatus.OK).body("회원가입에 성공했습니다");
        }

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("회원가입에 실패했습니다");
    }
}
