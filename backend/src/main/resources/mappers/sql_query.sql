use UpgRead;

-- 회원가입
insert into Users (email,password,username,birth,gender,city)
value (이메일,비번,닉네임,생년월일,성별,도시);

-- 로그인
select user_id, email, username
from Users
where email=이메일 and password=비번;

-- 책추천
-- --장르별로 보기
SELECT 
    b.book_id,
    b.title,
    b.author,
    b.publisher,
    b.published_year,
    b.rate,
    b.pages,
    g.name AS genre_name
FROM 
    Books AS b
JOIN 
    Genres AS g
ON 
    b.genre_id = g.genre_id
WHERE 
    g.name = '장르' -- 'Fiction','Non-Fiction','Science Fiction','Biography','Fantasy'),
                   -- 'Mystery','Romance','History','Self-Help','Children' 
ORDER BY 
    b.title ASC; -- 제목순으로 기본정렬
-- 정렬선택 
ORDER BY b.published_year DESC; -- 최신순
ORDER BY b.pages ASC; -- 페이지 수가 적은 순
ORDER BY b.rate DESC; -- 평점이 높은 순

-- -- 난이도별로 보기
SELECT 
    b.book_id,
    b.title,
    b.author,
    b.publisher,
    b.published_year,
    b.rate,
    b.pages,
    b.difficulty
FROM 
    Books AS b
WHERE 
    b.difficulty = '난이도' -- 난이도 선택: easy, medium, hard 중 하나
ORDER BY 
    b.title ASC; -- 기본 정렬: 제목순
-- 정렬선택 
ORDER BY b.published_year DESC; -- 최신순
ORDER BY b.pages ASC; -- 페이지 수가 적은 순
ORDER BY b.rate DESC; -- 평점이 높은 순

-- -- 검색하기
SELECT 
    b.book_id,
    b.title,
    b.author,
    b.publisher,
    b.published_year,
    b.rate,
    b.pages,
    g.name AS genre_name
FROM 
    Books AS b
JOIN 
    Genres AS g
ON 
    b.genre_id = g.genre_id
WHERE 
    b.title LIKE '%검색어%' -- 제목 부분 검색
    OR b.author LIKE '%검색어%' -- 저자 이름 부분 검색
    OR b.publisher LIKE '%검색어%'; -- 출판사 이름 부분 검색

-- 챌린지
-- -- 모든 챌린지 조회
SELECT 
    c.challenge_id,
    c.title,
    c.description,
    c.duration,
    c.type,
    c.goal,
    COUNT(uc.user_id) AS participant_count,
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM UserChallenges 
            WHERE user_id = ? -- 현재 사용자 ID
            AND challenge_id = c.challenge_id
        ) THEN 'joined'
        ELSE 'not_joined'
    END AS participation_status
FROM Challenges AS c
LEFT JOIN UserChallenges AS uc ON c.challenge_id = uc.challenge_id
GROUP BY c.challenge_id, c.created_at
ORDER BY c.created_at DESC;

-- -- 챌린지 참여
INSERT INTO UserChallenges (user_id, challenge_id, start_date)
VALUES (현재사용자,선택한챌린지, CURDATE());

-- -- 챌린지 생성
INSERT INTO Challenges (title, description, creator, type, goal, duration)
VALUES (제목, 설명, 현재사용자, 페이지or책, 목표, 기간);

-- -- 참여중인 챌린지 목록
SELECT 
    c.challenge_id,
    c.title,
    c.description,
    c.duration,
    c.type,
    c.goal,
    ROUND((uc.total_progress / c.goal) * 100, 2) AS progress_percentage,
    DATEDIFF(uc.start_date + INTERVAL c.duration DAY, CURDATE()) AS days_left
FROM 
    Challenges AS c
JOIN 
    UserChallenges AS uc
ON 
    c.challenge_id = uc.challenge_id
WHERE 
    uc.user_id = 현재사용자 AND uc.status = 'in_progress' ;
    
-- 참여한 챌린지 내부
SELECT 
    c.challenge_id,
    c.title,
    c.description,
    c.duration,
    c.type,
    c.goal,
    ROUND((uc.total_progress / c.goal) * 100, 2) AS my_progress_percentage, -- 진행 퍼센트
    DATEDIFF(uc.start_date + INTERVAL c.duration DAY, CURDATE()) AS days_left, -- 남은 기간
    u.username AS participant -- 참여자 이름
FROM 
    Challenges AS c
JOIN 
    UserChallenges AS uc
ON 
    c.challenge_id = uc.challenge_id
JOIN 
    Users AS u
ON 
    uc.user_id = u.user_id
WHERE 
    c.challenge_id = 선택된 챌린지;
    
-- 진행상황 입력
INSERT INTO ProgressLogs (user_challenge_id, date, progress)
VALUES (현재사용자, CURDATE(), 새진행상황);

-- -- 챌린지 탈퇴
DELETE FROM UserChallenges
WHERE user_id = 현재사용자 AND challenge_id = 선택한챌린지;

-- 챌린지 기록 보기
SELECT 
    c.challenge_id,
    c.title,
    uc.status,
    ROUND((uc.total_progress / c.goal) * 100, 2) AS progress_percentage,
    uc.start_date,
    (uc.start_date + INTERVAL c.duration DAY) AS end_date
FROM 
    Challenges AS c
JOIN 
    UserChallenges AS uc
ON 
    c.challenge_id = uc.challenge_id
WHERE 
    uc.user_id = 현재사용자 AND uc.status IN ('completed', 'expired') 
ORDER BY 
    end_date DESC; -- 종료 날짜 최신순

-- 설정
-- -- 닉네임 변경
UPDATE Users
SET username = 새닉네임
WHERE user_id = 현재사용자;

-- -- 비밀번호 변경
UPDATE Users
SET password = 새비번
WHERE user_id = 현재사용자;









