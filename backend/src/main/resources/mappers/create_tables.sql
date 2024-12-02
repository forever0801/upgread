create database UpgRead;
use UpgRead;

create table if not exists Users(
user_id int auto_increment primary key,
email varchar(100) not null unique,
password varchar(225) not null,
username varchar(50) not null unique,
birth date,
gender enum('male','female') default 'male',
city varchar(100),
created_at timestamp default current_timestamp,
updated_at timestamp default current_timestamp on update current_timestamp,
constraint chk_email_format check (email like '%_@_%._%' and email not like '% %'),
constraint chk_password_complexity check (password REGEXP
'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,20}$'),
constraint chk_username_format CHECK (username REGEXP '^[A-Za-z0-9]{1,19}$'));
create index idx_created_at on Users (created_at);

DELIMITER $$
CREATE TRIGGER validate_birth_date
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    IF NEW.birth < '1900-01-01' OR NEW.birth > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Birth date must be between 1900-01-01 and today.';
    END IF;
END$$
DELIMITER ;

INSERT INTO Users (email, password, username, birth, gender, city)
VALUES
('john.doe@example.com', 'Password1!', 'JohnDoe', '1990-05-15', 'male', 'New York'),
('jane.smith@example.com', 'Secure#123', 'JaneSmith', '1985-12-20', 'female', 'Los Angeles'),
('mike.johnson@example.com', 'MikePass@2', 'MikeJohnson', '2000-01-10', 'male', 'Chicago'),
('emily.brown@example.com', 'Emily#Pass9', 'EmilyBrown', '1995-07-25', 'female', 'Houston'),
('william.lee@example.com', 'Will!2023', 'WilliamLee', '1980-03-30', 'male', 'San Francisco'),
('olivia.wilson@example.com', 'Olivia$Safe1', 'OliviaWilson', '1998-11-15', 'female', 'Miami'),
('james.taylor@example.com', 'James@Strong7', 'JamesTaylor', '1975-09-05', 'male', 'Seattle'),
('sophia.moore@example.com', 'Sophia!Top3', 'SophiaMoore', '1990-02-14', 'female', 'Denver'),
('daniel.white@example.com', 'Daniel#2023', 'DanielWhite', '1987-08-08', 'male', 'Boston'),
('isabella.green@example.com', 'Isabella@45!', 'IsabellaGreen', '2002-06-18', 'female', 'Atlanta');

create table if not exists Challenges(
challenge_id int auto_increment primary key,
title varchar(255) not null unique,
description text not null check(length(description)<=1000),
creator int,
type enum('pages','books') not null default 'pages',
goal int not null check (goal>0),
duration int not null check (duration>0),
created_at timestamp default current_timestamp,
foreign key (creator) references Users(user_id) ON DELETE set null);

INSERT INTO Challenges (title, description, creator, type, goal, duration)
VALUES
('책 읽는 습관 들이기', '세 달동안 10권의 책을 읽자', 1, 'books', 10, 90),
('새해에는 책읽기', '한 달 동안 500페이지를 읽자', 2, 'pages', 500, 30),
('한 주 동안 열심히 책읽자', '매 주 100페이지를 읽자', 3, 'pages', 100, 7),
('책 마라톤', '한 달 안에 5권의 책을 읽자', 1, 'books', 5, 30),
('매일매일 책읽기', '한 달 동안 매일매일 20페이지를 읽자', 4, 'pages', 600, 30);

create table if not exists UserChallenges(
user_challenge_id int auto_increment primary key,
user_id int not null,
challenge_id int not null,
start_date date not null,
total_progress int default 0,
status enum('in_progress','completed','expired') default 'in_progress',
foreign key (user_id) references Users(user_id)
on delete cascade on update cascade,
foreign key (challenge_id) references Challenges(challenge_id)
on update cascade,
unique (user_id,challenge_id));

DELIMITER $$
CREATE TRIGGER update_status_on_completion
BEFORE UPDATE ON UserChallenges
FOR EACH ROW
BEGIN
    DECLARE goal_value INT;
    SELECT goal INTO goal_value
    FROM Challenges
    WHERE challenge_id = NEW.challenge_id;
    IF NEW.total_progress >= goal_value THEN
        SET NEW.status = 'completed';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE EVENT update_expired_status
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE UserChallenges
    SET status = 'expired'
    WHERE status = 'in_progress'
    AND DATEDIFF(start_date + INTERVAL (
        SELECT duration FROM Challenges WHERE challenge_id = UserChallenges.challenge_id
    ) DAY, CURDATE()) <= 0;
END$$
DELIMITER ;

INSERT INTO UserChallenges (user_id, challenge_id, start_date, status)
VALUES
(1, 1, '2024-10-01', 'in_progress'),
(2, 1, '2024-08-01', 'in_progress'),
(3, 2, '2024-11-03', 'in_progress'),
(4, 2, '2024-09-10', 'in_progress'),
(1, 2, '2024-01-30', 'in_progress'),
(2, 3, '2024-03-25', 'in_progress'),
(3, 3, '2024-02-13', 'in_progress'),
(4, 4, '2024-07-25', 'in_progress'),
(1, 5, '2024-08-04', 'in_progress'),
(2, 5, '2024-12-25', 'in_progress');

CREATE TABLE IF NOT EXISTS ProgressLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_challenge_id INT NOT NULL,
    date DATE NOT NULL,
    progress INT NOT NULL CHECK (progress > 0),
    FOREIGN KEY (user_challenge_id) REFERENCES UserChallenges(user_challenge_id) ON DELETE CASCADE
);

DELIMITER $$
CREATE TRIGGER set_default_date_on_insert
BEFORE INSERT ON ProgressLogs
FOR EACH ROW
BEGIN
    IF NEW.date IS NULL THEN
        SET NEW.date = CURDATE();
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER update_total_progress
AFTER INSERT ON ProgressLogs
FOR EACH ROW
BEGIN
    UPDATE UserChallenges
    SET total_progress = total_progress + NEW.progress
    WHERE user_challenge_id = NEW.user_challenge_id;
END$$
DELIMITER ;

create table if not exists Genres(
genre_id int auto_increment primary key,
name varchar(100) not null unique);

INSERT INTO Genres (name)
VALUES
('Fiction'),
('Non-Fiction'),
('Science Fiction'),
('Biography'),
('Fantasy'),
('Mystery'),
('Romance'),
('History'),
('Self-Help'),
('Children');

create table if not exists Books(
book_id int auto_increment primary key,
title varchar(255) not null,
author varchar(255),
publisher varchar(255),
published_year year,
rate float check(rate>=0 and rate <=5),
pages int check(pages>0),
difficulty enum('easy','medium','hard') default 'easy',
genre_id int,
foreign key (genre_id) references Genres(genre_id),
unique (title,author,publisher));
ALTER TABLE Books ADD FULLTEXT (title);
ALTER TABLE Books ADD FULLTEXT (author);
ALTER TABLE Books ADD FULLTEXT (publisher);
CREATE INDEX idx_published_year ON Books(published_year);
CREATE INDEX idx_title ON Books(title);
create index idx_genre_id on Books(genre_id);
create index idx_difficulty on Books(difficulty);
create index idx_rate on Books(rate);
create index idx_pages on Books(pages);

DELIMITER $$
CREATE TRIGGER set_difficulty
BEFORE INSERT ON Books
FOR EACH ROW
BEGIN
    IF NEW.pages <= 100 THEN
        SET NEW.difficulty = 'easy';
    ELSEIF NEW.pages BETWEEN 101 AND 400 THEN
        SET NEW.difficulty = 'medium';
    ELSE
        SET NEW.difficulty = 'hard';
    END IF;
END$$
DELIMITER ;

INSERT INTO Books (title, author, publisher, published_year, rate, pages, genre_id)
VALUES
('The Great Adventure', 'John Doe', 'Adventure House', 2015, 4.7, 300, 1),
('Understanding Physics', 'Jane Smith', 'Science Press', 2020, 4.5, 500, 3),
('Life of a Genius', 'Albert Brown', 'Biography World', 2018, 4.2, 350, 4),
('Magical Tales', 'Alice Johnson', 'Fantasy Publishers', 2019, 4.8, 250, 5),
('Detective Stories', 'Robert Miles', 'Mystery Books', 2021, 4.0, 120, 6),
('The Love Story', 'Olivia Moore', 'Romance House', 2022, 3.9, 200, 7),
('Historical Insights', 'Michael Green', 'History Experts', 2010, 4.3, 600, 8),
('How to Excel', 'David Taylor', 'Self-Help Co.', 2021, 4.6, 150, 9),
('Children’s Wonders', 'Sophia Lee', 'Kids Publishing', 2017, 4.9, 80, 10),
('Epic Space Journey', 'James Carter', 'Sci-Fi Works', 2016, 4.1, 700, 3);

