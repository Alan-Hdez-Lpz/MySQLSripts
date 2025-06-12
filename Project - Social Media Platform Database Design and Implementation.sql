-- 1. Databae schema
-- query to create DB
CREATE DATABASE SocialMediaPlatform;
-- query to use the DB
USE SocialMediaPlatform;

-- queries to create table and define datatypes, primary keys and foreign keys
CREATE TABLE Users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(50) NOT NULL UNIQUE,
user_email VARCHAR(100) NOT NULL UNIQUE,
user_password VARCHAR(50) NOT NULL,
date_of_birth DATE,
profile_picture VARCHAR(255)
);

CREATE TABLE Posts (
post_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
post_text TEXT,
post_date DATETIME,
media_url VARCHAR(200),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Comments (
comment_id INT AUTO_INCREMENT PRIMARY KEY,
post_id INT NOT NULL,
user_id INT NOT NULL,
comment_text TEXT NOT NULL,
comment_date DATETIME,
FOREIGN KEY (post_id) REFERENCES Posts(post_id),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Likes (
like_id INT AUTO_INCREMENT PRIMARY KEY,
post_id INT NOT NULL,
user_id INT NOT NULL,
like_date DATETIME,
FOREIGN KEY (post_id) REFERENCES Posts(post_id),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Followers (
follower_id INT NOT NULL,
following_id INT NOT NULL,
follow_date DATETIME,
PRIMARY KEY (follower_id, following_id),
FOREIGN KEY (follower_id) REFERENCES Users(user_id),
FOREIGN KEY (following_id) REFERENCES Users(user_id),
CHECK (follower_id != following_id)
);

CREATE TABLE Messages (
message_id INT AUTO_INCREMENT PRIMARY KEY,
sender_id INT NOT NULL,
receiver_id INT NOT NULL,
message TEXT NOT NULL,
message_date DATETIME,
is_read BOOLEAN,
FOREIGN KEY (sender_id) REFERENCES Users(user_id),
FOREIGN KEY (receiver_id) REFERENCES Users(user_id),
CHECK (sender_id != receiver_id)
);

CREATE TABLE Notifications (
notification_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
notification_text TEXT NOT NULL,
notification_date DATETIME,
is_read BOOLEAN,
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 2. Insert sample data
-- queries to insert data into the tables
INSERT INTO Users (user_name, user_email, user_password, date_of_birth, profile_picture) VALUES
('alice123', 'alice@example.com', 'alice123', '1990-04-12', '/images/users/alice.jpg'),
('bob_smith', 'bob@example.com', 'bob123', '2008-08-21', '/images/users/bob.jpg'),
('charlie_c', 'charlie@example.com', 'charlie123', '1995-11-02', '/images/users/charlie.jpg'),
('diana_d', 'diana@example.com', 'diana123', '1992-01-30', '/images/users/diana.jpg'),
('eve.evans', 'eve@example.com', 'eve123', '1993-07-18', '/images/users/eve.jpg'),
('frank99', 'frank@example.com', 'frank123', '1997-03-25', '/images/users/frank.jpg'),
('grace_g', 'grace@example.com', 'grace123', '2006-09-09', '/images/users/grace.jpg'),
('henry_h', 'henry@example.com', 'henry123', '1991-12-15', '/images/users/henry.jpg'),
('irene_ivy', 'irene@example.com', 'irene123', '1994-06-06', '/images/users/irene.jpg'),
('jack_jones', 'jack@example.com', 'jack123', '2009-10-22', '/images/users/jack.jpg');

INSERT INTO Posts (user_id, post_text, post_date, media_url ) VALUES
(1, 'Just got back from a great trip to the mountains!', '2025-06-01 10:00:00', '/media/posts/mountains.jpg'),
(2, 'Excited to start my new job today!', '2025-06-02 08:30:00', NULL),
(3, 'Check out this amazing sunset!', '2025-06-03 19:45:00', '/media/posts/sunset.jpg'),
(4, 'Working on a new project, can’t wait to share more!', '2025-06-04 15:20:00', NULL),
(5, 'Delicious meal at the new sushi place 🍣', '2025-06-05 13:15:00', '/media/posts/sushi.jpg'),
(6, 'Throwback to last summer!', '2025-06-06 11:00:00', '/media/posts/beach.png'),
(7, 'Feeling motivated today 💪', '2025-06-07 09:00:00', NULL),
(8, 'Meet my new puppy 🐶', '2025-06-08 14:50:00', '/media/posts/puppy.jpg'),
(9, 'Attended a fantastic concert last night!', '2025-06-09 22:30:00', '/media/posts/concert.mp4'),
(10, 'Here’s a sneak peek of my next artwork 🎨', '2025-06-10 16:45:00', '/media/posts/artwork.jpg'),
(3, 'Started learning guitar today 🎸 Wish me luck!', '2025-06-11 17:00:00', NULL),
(6, 'Captured this moment during my morning walk 🌅', '2025-06-11 06:45:00', '/media/posts/morning_walk.jpg'),
(1, 'Celebrating 1 year at my job today! Grateful for the journey 🙌', '2025-06-11 12:30:00', NULL);

INSERT INTO Comments (post_id, user_id, comment_text, comment_date) VALUES
(1, 2, 'Looks amazing! Glad you had a great trip.', '2025-06-01 12:00:00'),
(1, 3, 'I’ve been there too! Such a beautiful place.', '2025-06-01 12:30:00'),
(3, 5, 'Wow, that sunset is stunning!', '2025-06-03 20:00:00'),
(5, 6, 'Sushi is life 🍣🔥', '2025-06-05 14:00:00'),
(6, 2, 'Love the beach vibes!', '2025-06-06 12:15:00'),
(8, 1, 'Your puppy is adorable 😍', '2025-06-08 15:20:00'),
(9, 4, 'What band was playing?', '2025-06-09 23:00:00'),
(10, 7, 'Can’t wait to see the final artwork!', '2025-06-10 17:30:00'),
(11, 5, 'Good luck with the guitar! 🎸', '2025-06-11 17:15:00'),
(13, 8, 'Congrats! Here’s to many more milestones 🎉', '2025-06-11 13:00:00');

INSERT INTO Likes (post_id, user_id, like_date) VALUES
(1, 2, '2025-06-01 12:05:00'),
(1, 3, '2025-06-01 12:10:00'),
(3, 4, '2025-06-03 20:10:00'),
(5, 6, '2025-06-05 14:30:00'),
(6, 7, '2025-06-06 12:45:00'),
(8, 1, '2025-06-08 15:30:00'),
(9, 5, '2025-06-09 23:15:00'),
(10, 2, '2025-06-10 17:45:00'),
(11, 3, '2025-06-11 17:20:00'),
(13, 9, '2025-06-11 13:10:00');

INSERT INTO Followers (follower_id, following_id, follow_date) VALUES
(1, 2, '2025-05-20 10:00:00'),
(2, 3, '2025-05-21 09:30:00'),
(3, 1, '2025-05-22 14:00:00'),
(4, 1, '2025-05-23 12:15:00'),
(5, 2, '2025-05-24 16:45:00'),
(6, 4, '2025-05-25 08:20:00'),
(7, 5, '2025-05-26 11:10:00'),
(8, 6, '2025-05-27 10:50:00'),
(9, 7, '2025-05-28 13:35:00'),
(10, 8, '2025-05-29 15:05:00');

INSERT INTO Messages (sender_id, receiver_id, message, message_date, is_read) VALUES
(1, 2, 'Hey Bob, how was your trip?', '2025-06-01 09:15:00', FALSE),
(2, 1, 'It was awesome! Thanks for asking.', '2025-06-01 09:17:00', TRUE),
(3, 4, 'Can you help me with that project?', '2025-06-02 14:00:00', FALSE),
(4, 3, 'Sure, let’s talk later today.', '2025-06-02 14:10:00', TRUE),
(5, 6, 'Loved your recent post!', '2025-06-03 18:00:00', TRUE),
(6, 5, 'Thanks! Appreciate it.', '2025-06-03 18:05:00', TRUE),
(7, 8, 'Are you attending the concert this weekend?', '2025-06-04 13:45:00', FALSE),
(8, 7, 'Yes! Got my ticket already.', '2025-06-04 14:00:00', TRUE),
(9, 10, 'Let’s catch up soon.', '2025-06-05 20:00:00', FALSE),
(10, 9, 'Sounds good. How about Saturday?', '2025-06-05 20:10:00', FALSE);

INSERT INTO Notifications (user_id, notification_text, notification_date, is_read) VALUES
(1, 'Bob Smith liked your post.', '2025-06-01 12:06:00', FALSE),
(1, 'Charlie commented on your trip photo.', '2025-06-01 12:35:00', TRUE),
(3, 'Diana started following you.', '2025-06-02 09:00:00', FALSE),
(4, 'You have a new message from Charlie.', '2025-06-02 14:00:00', TRUE),
(5, 'Frank liked your sushi post.', '2025-06-05 14:35:00', TRUE),
(6, 'You have a new follower: Grace.', '2025-06-06 11:30:00', FALSE),
(8, 'Henry liked your puppy photo.', '2025-06-08 15:35:00', FALSE),
(9, 'You have a new message from Jack.', '2025-06-05 20:00:00', TRUE),
(10, 'Irene started following you.', '2025-05-29 15:10:00', FALSE),
(2, 'Alice commented on your post.', '2025-06-01 09:20:00', TRUE);

-- 3. Queries
-- query to retrieve the posts and activities of a user's timeline
SELECT p.post_text, p.media_url,p.post_date
FROM Posts p
INNER JOIN Users u ON p.user_id = u.user_id
WHERE p.user_id = 1 
ORDER BY p.post_date DESC;

SELECT c.comment_text, p.post_text AS 'Post commented', c.comment_date
FROM Comments c
INNER JOIN Users u ON c.user_id = u.user_id
INNER JOIN Posts p ON c.post_id = p.post_id
WHERE c.user_id = 1 
ORDER BY c.comment_date DESC;

SELECT p.post_text AS 'Post liked', l.like_date
FROM Likes l
INNER JOIN Users u ON l.user_id = u.user_id
INNER JOIN Posts p ON l.post_id = p.post_id
WHERE l.user_id = 1 
ORDER BY l.like_date DESC;

SELECT u.user_name AS 'Followed', f.follow_date
FROM Followers f
INNER JOIN Users u ON f.following_id = u.user_id
WHERE f.follower_id = 1
ORDER BY f.follow_date DESC;

SELECT m.message, u.user_name AS 'Messaged to', m.message_date
FROM Messages m
INNER JOIN Users u ON m.receiver_id = u.user_id
WHERE m.sender_id = 1
ORDER BY m.message_date DESC;

-- query to retrieve the comments and likes for a specific post.
SELECT p.post_text, p.media_url, p.post_date, c.comment_text
FROM Posts p
INNER JOIN Comments c ON p.post_id = c.post_id
WHERE p.post_id = 1;

SELECT COUNT(l.post_id) 
FROM Likes l 
INNER JOIN Posts p ON  l.post_id = p.post_id
WHERE l.post_id = 1;

-- query to retrieve the list of followers for a user.
SELECT u.user_name AS 'Follower'
FROM Followers f
INNER JOIN Users u ON f.follower_id = u.user_id
WHERE f.following_id = 1;

-- Retrieve unread messages for a user.
SELECT m.message, u.user_name AS 'Messaged from', m.message_date
FROM Messages m
INNER JOIN Users u ON m.sender_id = u.user_id
WHERE m.receiver_id = 2 AND m.is_read = FALSE;

-- query to retrieve the most liked posts.
SELECT p.post_text, COUNT(l.post_id) AS 'Likes'
FROM Likes l 
INNER JOIN Posts p ON  l.post_id = p.post_id
GROUP BY l.post_id
LIMIT 10;

-- query to retrieve the latest notifications for a user.
SELECT n.notification_text, n.notification_date
FROM Notifications n
INNER JOIN Users u ON n.user_id = u.user_id
WHERE n.user_id = 1
ORDER BY n.notification_date DESC
LIMIT 10;

-- 4. Data modification
-- query to add a new post to the platform.
INSERT INTO Posts (user_id, post_text, post_date, media_url ) VALUES
(1,'Just visited the Grand Canyon – absolutely breathtaking!','2025-06-10 14:30:00','https://example.com/media/grand-canyon.jpg');

-- query to comment on a post.
INSERT INTO Comments (post_id, user_id, comment_text, comment_date) VALUES
(14, 2, 'Looks amazing! Glad you had a great trip.', '2025-06-11 12:00:00');

-- query to update user profile information.
UPDATE Users SET profile_picture = '/images/users/alice_new.jpg'
WHERE user_id = 1;

-- query to remove a like from a post.
DELETE FROM Likes WHERE user_id = 9 AND post_id = 13;

-- 5. Complex queries
-- query to identify users with the most followers.
SELECT u.user_name, COUNT(f.follower_id) AS 'Followers'
FROM Followers f
INNER JOIN Users u ON f.following_id = u.user_id
GROUP BY u.user_name
LIMIT 5;

-- query to find the most active users based on post count and interaction.
SELECT 
    u.user_id,
    u.user_name,
    COUNT(DISTINCT p.post_id) AS post_count,
    COUNT(DISTINCT c.comment_id) AS comment_count,
    COUNT(DISTINCT l.like_id) AS like_count,
    (
        COUNT(DISTINCT p.post_id) +
        COUNT(DISTINCT c.comment_id) +
        COUNT(DISTINCT l.like_id)
    ) AS activity_score
FROM 
    Users u
INNER JOIN Posts p ON u.user_id = p.user_id
INNER JOIN Comments c ON u.user_id = c.user_id
INNER JOIN Likes l ON u.user_id = l.user_id
GROUP BY 
    u.user_id
ORDER BY 
    activity_score DESC
LIMIT 10;

-- query to calculate the average number of comments per post.
SELECT COUNT(c.comment_id)/COUNT(DISTINCT p.post_id) AS avg_comments_per_post
FROM Posts p
LEFT JOIN Comments c ON p.post_id = c.post_id;

-- 6. Advanced topics
-- store procedure to automatically notify users of new messages.
DELIMITER //
CREATE PROCEDURE NewMessageNotification(IN new_message_id INT)
BEGIN
	DECLARE sender_value VARCHAR(50);
    DECLARE receiver_id_value INT;
    DECLARE message_text_value TEXT;

    SELECT u.user_name AS 'sender', m.receiver_id, m.message
    INTO sender_value, receiver_id_value, message_text_value
    FROM Messages m
    INNER JOIN Users u ON m.sender_id = u.user_id
    WHERE message_id = new_message_id;

	INSERT INTO Notifications (user_id, notification_text, notification_date, is_read) VALUES
	(receiver_id_value, CONCAT('You have a new message from ', sender_value, ': "', message_text_value, '"'), NOW(), FALSE);
END//
DELIMITER ;

CALL NewMessageNotification(1);

-- store procedure to update post counts and follower counts for users.
DELIMITER //
CREATE PROCEDURE UpdatePostAndFollowerCounts()
BEGIN
	SELECT 
        u.user_id,
        u.user_name,
        COUNT(DISTINCT p.post_id) AS posts,
        COUNT(DISTINCT f.follower_id) AS followers
    FROM Users u
    LEFT JOIN Posts p ON u.user_id = p.user_id
    LEFT JOIN Followers f ON u.user_id = f.following_id
    GROUP BY 
        u.user_id, u.user_name
    ORDER BY 
        posts DESC, followers DESC;
END//
DELIMITER ;

CALL UpdatePostAndFollowerCounts();

-- store procedure to generate personalized recommendations for users to follow.
DELIMITER //
CREATE PROCEDURE UsersRecommendationsToFollow(IN user_id_to_give_recommendations INT)
BEGIN
    SELECT 
        u.user_id,
        u.user_name,
        COUNT(f.follower_id) AS followers
    FROM Users u
    LEFT JOIN Followers f ON u.user_id = f.following_id
    WHERE u.user_id != user_id_to_give_recommendations -- exclude the user that will receive recommendations
    AND u.user_id NOT IN (  -- exclude users already followed
            SELECT following_id FROM Followers WHERE follower_id = user_id_to_give_recommendations
        )
    GROUP BY 
        u.user_id
	LIMIT 5;
END//
DELIMITER ;

CALL UsersRecommendationsToFollow(6);