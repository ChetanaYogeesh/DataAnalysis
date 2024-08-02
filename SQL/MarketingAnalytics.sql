select campaign_id, count(distinct user_id) as users_acquired
from marketing_attribution
group by campaign_id
order by users_acquired desc;

SELECT M.CAMPAIGN_ID,
  SUM(R.FARE_AMOUNT) AS REVENUE_GENERATED
FROM MARKETING_ATTRIBUTION M
JOIN RIDES R ON M.USER_ID = R.USER_ID 
GROUP BY M.CAMPAIGN_ID
ORDER BY REVENUE_GENERATED DESC;




CREATE TABLE users (
  user_id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT NOT NULL UNIQUE,
  city TEXT,
  registration_date DATETIME NOT NULL
);

CREATE TABLE vehicles (
  vehicle_id INTEGER PRIMARY KEY,
  make TEXT NOT NULL,
  model TEXT NOT NULL,
  year INTEGER NOT NULL,
  license_plate TEXT NOT NULL UNIQUE
);

CREATE TABLE drivers (
  driver_id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT NOT NULL UNIQUE,
  city TEXT NOT NULL,
  vehicle_id INTEGER NOT NULL,
  FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id)
);

CREATE TABLE rides (
  ride_id INTEGER PRIMARY KEY,
  pickup_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  dropoff_time DATETIME NOT NULL,
  pickup_location TEXT NOT NULL,
  dropoff_location TEXT NOT NULL,
  fare_amount REAL NOT NULL,
  tip_amount REAL NOT NULL,
  distance REAL NOT NULL,
  user_id INTEGER NOT NULL,
  driver_id INTEGER NOT NULL,
  status TEXT NOT NULL DEFAULT 'completed',
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (driver_id) REFERENCES drivers (driver_id)
);

CREATE TABLE user_activity (
  activity_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  activity_type TEXT NOT NULL,
  activity_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users (user_id)
);


INSERT INTO users (first_name, last_name, email, phone, city, registration_date) VALUES
('John', 'Doe', 'johndoe@example.com', '555-1234', 'New York', '2023-01-02'),
('Jane', 'Doe', 'janedoe@example.com', '555-5678', 'Los Angeles', '2023-01-03'),
('Bob', 'Smith', 'bobsmith@example.com', '555-9012', 'Chicago', '2023-01-04'),
('Samantha', 'Johnson', 'sjohnson@example.com', '555-3456', 'San Francisco', '2023-01-05'),
('David', 'Brown', 'dbrown@example.com', '555-7890', 'Seattle', '2023-01-06'),
('Emily', 'Davis', 'edavis@example.com', '555-2345', 'Boston', '2023-01-07'),
('Michael', 'Wilson', 'mwilson@example.com', '555-6789', 'Houston', '2023-01-08'),
('Sarah', 'Garcia', 'sgarcia@example.com', '555-0123', 'Miami', '2023-01-09'),
('Daniel', 'Martinez', 'dmartinez@example.com', '555-4567', 'Atlanta', '2023-01-10'),
('Jessica', 'Lee', 'jlee@example.com', '555-8901', 'Dallas', '2023-01-11'),
('Matthew', 'Anderson', 'manderson@example.com', '555-8902', 'Detroit', '2023-01-12'),
('Ashley', 'Thomas', 'athomas@example.com', '555-8903', 'Phoenix', '2023-01-13'),
('Christopher', 'Taylor', 'ctaylor@example.com', '555-8904', 'San Diego', '2023-01-14'),
('Jennifer', 'Moore', 'jmoore@example.com', '555-8905', 'Denver', '2023-01-15'),
('Joshua', 'Jackson', 'jjackson@example.com', '555-8906', 'Portland', '2023-01-16'),
('Amanda', 'White', 'awhite@example.com', '555-8907', 'Indianapolis', '2023-01-17'),
('Andrew', 'Harris', 'aharris@example.com', '555-8908', 'Las Vegas', '2023-01-18'),
('Brittany', 'Martin', 'bmartin@example.com', '555-8909', 'Austin', '2023-01-19'),
('Brandon', 'Thompson', 'bthompson@example.com', '555-8910', 'Jacksonville', '2023-01-20'),
('Megan', 'Garcia', 'mgarcia@example.com', '555-8911', 'San Jose', '2023-01-21'),
('Justin', 'Martinez', 'jmartinez@example.com', '555-8912', 'Charlotte', '2023-01-22'),
('Melissa', 'Robinson', 'mrobinson@example.com', '555-8913', 'Fort Worth', '2023-01-23'),
('Kevin', 'Clark', 'kclark@example.com', '555-8914', 'Washington', '2023-01-24'),
('Rebecca', 'Rodriguez', 'rrodriguez@example.com', '555-8915', 'Baltimore', '2023-01-25'),
('Jacob', 'Lewis', 'jlewis@example.com', '555-8916', 'Milwaukee', '2023-01-26'),
('Michelle', 'Walker', 'mwalker@example.com', '555-8917', 'Albuquerque', '2023-01-27'),
('Ryan', 'Hall', 'rhall@example.com', '555-8918', 'Tucson', '2023-01-28'),
('Stephanie', 'Allen', 'sallen@example.com', '555-8919', 'Fresno', '2023-01-29'),
('Brian', 'Young', 'byoung@example.com', '555-8920', 'Sacramento', '2023-01-30'),
('Heather', 'King', 'hking@example.com', '555-8921', 'Kansas City', '2023-01-31');


-- Additional users from San Jose
INSERT INTO users (first_name, last_name, email, phone, city, registration_date) VALUES
('Anthony', 'Ortega', 'aortega@example.com', '505-3456', 'San Jose', '2023-01-12 08:30:00'),
('Christina', 'Henderson', 'chenderson@example.com', '505-7890', 'San Jose', '2023-01-13 10:00:00'),
('George', 'Murphy', 'gmurphy@example.com', '505-2345', 'San Jose', '2023-01-14 11:45:00'),
('Linda', 'Peterson', 'lpeterson@example.com', '505-6789', 'San Jose', '2023-01-15 16:00:00'),
('Thomas', 'Harris', 'tharris@example.com', '505-0123', 'San Jose', '2023-01-16 18:00:00');

-- Additional users from New York
INSERT INTO users (first_name, last_name, email, phone, city, registration_date) VALUES
('Jennifer', 'Thompson', 'jthompson@example.com', '515-4567', 'New York', '2023-01-17 10:30:00'),
('Robert', 'Turner', 'rturner@example.com', '515-8901', 'New York', '2023-01-18 11:00:00'),
('Maria', 'Sanchez', 'msanchez@example.com', '515-5678', 'New York', '2023-01-19 14:00:00'),
('John', 'Phillips', 'jphillips@example.com', '515-9012', 'New York', '2023-01-20 16:30:00'),
('Susan', 'Gonzalez', 'sgonzalez@example.com', '515-3456', 'New York', '2023-01-21 17:30:00');

-- Additional users from San Francisco
INSERT INTO users (first_name, last_name, email, phone, city, registration_date) VALUES
('David', 'Clark', 'dclark@example.com', '525-7890', 'San Francisco', '2023-01-22 09:00:00'),
('Nancy', 'Adams', 'nadams@example.com', '525-2345', 'San Francisco', '2023-01-23 10:45:00'),
('Joseph', 'Baker', 'jbaker@example.com', '525-6789', 'San Francisco', '2023-01-24 12:30:00'),
('Margaret', 'Taylor', 'mtaylor@example.com', '525-0123', 'San Francisco', '2023-01-25 14:15:00'),
('Charles', 'Anderson', 'canderson@example.com', '525-4567', null, '2023-01-26 15:00:00');



-- Vehicles table
INSERT INTO vehicles (make, model, year, license_plate) VALUES
('Toyota', 'Camry', 2018, 'ABC123'),
('Honda', 'Civic', 2017, 'DEF456'),
('Ford', 'F-150', 2020, 'GHI789'),
('Chevrolet', 'Malibu', 2019, 'JKL012'),
('Nissan', 'Altima', 2018, 'MNO345');

-- Drivers table
INSERT INTO drivers (first_name, last_name, email, phone, city, vehicle_id) VALUES
('Mike', 'Brown', 'mbrown@example.com', '555-2345', 'New York', 1),
('Rachel', 'Garcia', 'rgarcia@example.com', '555-6789', 'Los Angeles', 2),
('David', 'Lee', 'dlee@example.com', '555-0123', 'Chicago', 3),
('Linda', 'Martinez', 'lmartinez@example.com', '555-4567', 'San Francisco', 4),
('Alex', 'Wilson', 'awilson@example.com', '555-8901', 'Seattle', 5);

-- Rides table
INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id) VALUES
('2023-04-06 10:00:00', '2023-04-06 10:15:00', 'Central Park', 'Empire State Building', 10.50, 2.00, 3.0, 1, 1),
('2023-04-06 11:30:00', '2023-04-06 12:15:00', 'Universal Studios', 'Hollywood Walk of Fame', 25.75, 5.00, 8.0, 2, 2),
('2023-04-06 14:00:00', '2023-04-06 14:45:00', 'Millennium Park', 'Willis Tower', 15.20, 3.00, 5.5, 3, 3),
('2023-04-06 16:30:00', '2023-04-06 17:15:00', 'Golden Gate Bridge', "Fisherman's Wharf", 21.80, 4.00, 7.5, 4, 4),
('2023-04-06 18:30:00', '2023-04-06 19:00:00', 'Space Needle', 'Pike Place Market', 12.50, 2.50, 3.0, 5, 5);

-- Subsequent Insert Statements with Tip Amount
INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id, status)
VALUES ('2023-04-15 10:00:00', '2023-04-15 10:30:00', 'Central Park', 'Times Square', 10.0, 2.00, 5.0, 1, 1, 'completed');

INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id, status)
VALUES ('2023-04-15 11:00:00', '2023-04-15 11:30:00', 'Empire State Building', 'Grand Central Station', 15.0, 3.00, 7.5, 2, 2, 'completed');

INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id, status)
VALUES ('2023-04-16 10:00:00', '2023-04-16 10:30:00', 'Central Park', 'Times Square', 12.0, 2.40, 6.0, 3, 1, 'completed');

INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id, status)
VALUES ('2023-04-16 11:00:00', '2023-04-16 11:30:00', 'Empire State Building', 'Grand Central Station', 20.0, 4.00, 10.0, 4, 2, 'completed');

INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id, status)
VALUES ('2023-04-17 10:00:00', '2023-04-17 10:30:00', 'Central Park', 'Times Square', 18.0, 3.60, 9.0, 5, 1, 'completed');

INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id, status)
VALUES ('2023-04-17 11:00:00', '2023-04-17 11:30:00', 'Empire State Building', 'Grand Central Station', 25.0, 5.00, 12.5, 6, 2, 'completed');

INSERT INTO rides (pickup_time, dropoff_time, pickup_location, dropoff_location, fare_amount, tip_amount, distance, user_id, driver_id, status)
VALUES ('2023-04-18 10:00:00', '2023-04-18 10:30:00', 'Central Park', 'Times Square', 22.0, 4.40, 11.0, 7, 1, 'completed');



INSERT INTO user_activity (user_id, activity_type, activity_date)
VALUES (1, 'ride_request', '2022-01-01 12:00:00'),
       (1, 'ride_completed', '2022-01-01 13:00:00'),
       (1, 'payment_completed', '2022-01-01 13:15:00'),
       (2, 'ride_request', '2022-01-01 12:30:00'),
       (2, 'ride_cancelled', '2022-01-01 12:35:00'),
       (3, 'payment_completed', '2022-01-02 14:00:00'),
       (3, 'ride_request', '2022-01-02 14:30:00'),
       (4, 'ride_completed', '2022-01-03 10:00:00'),
       (4, 'payment_completed', '2022-01-03 10:15:00'),
       (4, 'ride_request', '2022-01-03 09:30:00'),
       (5, 'ride_request', '2022-01-03 14:00:00'),
       (5, 'ride_completed', '2022-01-03 14:30:00'),
       (5, 'payment_completed', '2022-01-03 14:45:00'),
       (6, 'ride_request', '2022-01-04 09:00:00'),
       (6, 'payment_completed', '2022-01-04 09:15:00'),
       (7, 'payment_completed', '2022-01-04 10:30:00'),
       (7, 'ride_request', '2022-01-04 10:45:00'),
       (7, 'ride_completed', '2022-01-04 11:00:00'),
       (8, 'ride_request', '2022-01-04 12:30:00'),
       (9, 'ride_request', '2022-01-05 08:00:00');


INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (1, 'ride_scheduled', '2022-03-01');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (2, 'ride_scheduled', '2022-03-02');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (3, 'ride_scheduled', '2022-03-02');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (4, 'ride_scheduled', '2022-03-03');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (5, 'ride_scheduled', '2022-03-04');

INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (1, 'payment_initiated', '2022-03-01');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (2, 'payment_initiated', '2022-03-02');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (3, 'payment_initiated', '2022-03-03');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (4, 'payment_initiated', '2022-03-03');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (5, 'payment_initiated', '2022-03-04');


INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (1, 'ride_requested', '2022-03-01');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (2, 'ride_requested', '2022-03-02');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (3, 'ride_requested', '2022-03-02');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (4, 'ride_requested', '2022-03-03');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (5, 'ride_requested', '2022-03-04');


INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (1, 'payment_completed', '2022-03-01');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (2, 'payment_completed', '2022-03-02');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (3, 'payment_completed', '2022-03-03');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (4, 'payment_completed', '2022-03-03');
INSERT INTO user_activity (user_id, activity_type, activity_date) VALUES (5, 'payment_completed', '2022-03-04');


INSERT INTO user_activity (user_id, activity_type, activity_date)
VALUES
  (1, 'ride_scheduled', '2022-03-01 10:30:00'),
  (2, 'ride_scheduled', '2022-03-01 12:45:00'),
  (3, 'ride_scheduled', '2022-03-01 18:30:00'),
  (4, 'ride_scheduled', '2022-03-02 09:15:00'),
  (5, 'ride_scheduled', '2022-03-02 14:30:00'),
  (6, 'ride_scheduled', '2022-03-02 16:30:00'),
  (7, 'ride_scheduled', '2022-03-02 19:15:00'),
  (8, 'ride_scheduled', '2022-03-03 11:30:00'),
  (9, 'ride_scheduled', '2022-03-03 13:00:00'),
  (10, 'ride_completed', '2022-03-03 15:30:00'),
  (11, 'ride_completed', '2022-03-04 10:00:00'),
  (12, 'ride_scheduled', '2022-03-04 17:30:00'),
  (13, 'ride_completed', '2022-03-04 19:45:00'),
  (1, 'ride_scheduled', '2022-03-05 10:30:00'),
  (14, 'ride_scheduled', '2022-03-05 14:00:00'),
  (15, 'ride_scheduled', '2022-03-05 16:30:00'),
  (5, 'ride_completed', '2022-03-06 13:15:00'),
  (16, 'ride_completed', '2022-03-06 15:30:00'),
  (17, 'ride_scheduled', '2022-03-06 18:45:00'),
  (18, 'ride_scheduled', '2022-03-07 11:30:00'),
  (19, 'ride_scheduled', '2022-03-07 12:30:00'),
  (2, 'ride_scheduled', '2022-03-07 20:30:00'),
  (20, 'ride_scheduled', '2022-03-08 10:30:00'),
  (6, 'ride_scheduled', '2022-03-08 12:45:00'),
  (21, 'ride_scheduled', '2022-03-08 14:30:00'),
  (11, 'ride_scheduled', '2022-03-09 09:15:00'),
  (22, 'ride_scheduled', '2022-03-09 10:30:00'),
  (23, 'ride_scheduled', '2022-03-09 18:30:00'),
  (24, 'ride_scheduled', '2022-03-10 10:00:00'),
  (25, 'ride_scheduled', '2022-03-10 12:30:00'),
  (26, 'ride_scheduled', '2022-03-10 15:45:00'),
  (27, 'ride_scheduled', '2022-03-11 09:30:00'),
  (28, 'ride_scheduled', '2022-03-11 13:00:00'),
  (29, 'ride_scheduled', '2022-03-11 17:30:00'),
  (1, 'ride_scheduled', '2022-03-12 11:15:00'),
  (30, 'ride_scheduled', '2022-03-12 13:45:00'),
  (31, 'ride_scheduled', '2022-03-12 16:30:00'),
  (32, 'ride_scheduled', '2022-03-13 10:30:00'),
  (33, 'ride_scheduled', '2022-03-13 12:45:00'),
  (34, 'ride_scheduled', '2022-03-13 15:30:00'),
  (35, 'ride_scheduled', '2022-03-14 09:15:00'),
  (36, 'ride_scheduled', '2022-03-14 14:30:00'),
  (37, 'ride_scheduled', '2022-03-14 16:30:00');


INSERT INTO user_activity (user_id, activity_type, activity_date)
VALUES
  (1, 'home_page', '2022-03-01 10:20:00'),
  (1, 'enter_pickup_location Location', '2022-03-01 10:21:00'),
  (1, 'enter_dropoff_location', '2022-03-01 10:22:00'),
  (1, 'confirm_fare', '2022-03-01 10:23:00'),
  (1, 'request_ride', '2022-03-01 10:24:00'),
  (1, 'ride_started', '2022-03-01 10:25:00'),
  (2, 'home_page', '2022-03-01 12:35:00'),
  (2, 'enter_pickup_location Location', '2022-03-01 12:36:00'),
  (2, 'enter_dropoff_location', '2022-03-01 12:37:00'),
  (2, 'confirm_fare', '2022-03-01 12:38:00');
INSERT INTO user_activity (user_id, activity_type, activity_date)
VALUES
  (3, 'home_page', '2022-03-01 18:20:00'),
  (3, 'enter_pickup_location Location', '2022-03-01 18:21:00'),
  (3, 'enter_dropoff_location', '2022-03-01 18:22:00'),
  (3, 'confirm_fare', '2022-03-01 18:23:00'),
  (3, 'request_ride', '2022-03-01 18:24:00'),
  (3, 'ride_started', '2022-03-01 18:25:00'),
  (4, 'home_page', '2022-03-02 09:05:00'),
  (4, 'enter_pickup_location Location', '2022-03-02 09:06:00'),
  (4, 'enter_dropoff_location', '2022-03-02 09:07:00'),
  (4, 'confirm_fare', '2022-03-02 09:08:00'),
  (5, 'home_page', '2022-03-02 14:20:00'),
  (5, 'enter_pickup_location Location', '2022-03-02 14:21:00'),
  (5, 'enter_dropoff_location', '2022-03-02 14:22:00'),
  (6, 'home_page', '2022-03-02 16:20:00'),
  (6, 'enter_pickup_location Location', '2022-03-02 16:21:00'),
  (7, 'home_page', '2022-03-02 19:05:00'),
  (7, 'enter_pickup_location Location', '2022-03-02 19:06:00'),
  (7, 'enter_dropoff_location', '2022-03-02 19:07:00'),
  (7, 'confirm_fare', '2022-03-02 19:08:00'),
  (7, 'request_ride', '2022-03-02 19:09:00');
INSERT INTO user_activity (user_id, activity_type, activity_date)
VALUES
  (8, 'home_page', '2022-03-15 10:30:00'),
  (9, 'home_page', '2022-03-15 14:45:00'),
  (10, 'home_page', '2022-03-15 17:00:00');
  





CREATE TABLE marketing_campaigns (
campaign_id INTEGER PRIMARY KEY,
campaign_name TEXT NOT NULL,
start_date DATETIME NOT NULL,
end_date DATETIME NOT NULL,
spend REAL NOT NULL,
revenue_generated REAL NOT NULL
);

CREATE TABLE campaign_events (
event_id INTEGER PRIMARY KEY,
campaign_id INTEGER NOT NULL,
event_name TEXT NOT NULL,
event_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
event_type TEXT NOT NULL,
event_data TEXT,
channel TEXT NOT NULL,
spend REAL NOT NULL,
revenue REAL NOT NULL,
FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns (campaign_id)
);


CREATE TABLE marketing_attribution (
attribution_id INTEGER PRIMARY KEY,
user_id INTEGER NOT NULL,
campaign_id INTEGER NOT NULL,
event_id INTEGER NOT NULL,
attribution_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users (user_id),
FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns (campaign_id),
FOREIGN KEY (event_id) REFERENCES campaign_events (event_id)
);

CREATE TABLE user_campaign_feedback (
feedback_id INTEGER PRIMARY KEY,
user_id INTEGER NOT NULL,
campaign_id INTEGER NOT NULL,
rating INTEGER NOT NULL,
comments TEXT,
feedback_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users (user_id),
FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns (campaign_id)
);



-- Inserting data into marketing_campaigns table
INSERT INTO marketing_campaigns (campaign_id, campaign_name, start_date, end_date, spend, revenue_generated) VALUES
(1, 'Spring Promo', '2022-03-01', '2022-03-31', 5000, 100000),
(2, 'Easter Special', '2022-04-01', '2022-04-30', 4000, 80000),
(3, 'May Discounts', '2022-05-01', '2022-05-31', 6000, 120000),
(4, 'Summer Sale', '2022-06-01', '2022-06-30', 7000, 140000),
(5, 'Back to School', '2022-08-01', '2022-08-31', 4500, 90000),
(6, 'Fall Festival', '2022-09-01', '2022-09-30', 3000, 60000),
(7, 'Halloween Bonanza', '2022-10-01', '2022-10-31', 5000, 100000),
(8, 'Thanksgiving Deals', '2022-11-01', '2022-11-30', 5500, 110000),
(9, 'Winter Sale', '2022-12-01', '2022-12-31', 6000, 120000),
(10, 'New Year Offers', '2023-01-01', '2023-01-31', 6500, 130000);

-- Inserting data into campaign_events table
INSERT INTO campaign_events (event_id, campaign_id, event_name, event_date, event_type, event_data, channel, spend, revenue) VALUES
(1, 1, 'Ad Click', '2022-03-03', 'click', '{"ad_platform": "Facebook", "ad_id": 1}', 'Facebook', 1000, 2000),
(2, 2, 'Video View', '2022-04-05', 'view', '{"video_platform": "YouTube", "video_id": 1}', 'YouTube', 800, 1600),
(3, 3, 'Email Open', '2022-05-10', 'open', '{"email_id": 1}', 'Email', 1200, 2400),
(4, 4, 'Ad Click', '2022-06-15', 'click', '{"ad_platform": "Google", "ad_id": 2}', 'Google', 1400, 2800),
(5, 5, 'Video View', '2022-08-20', 'view', '{"video_platform": "Vimeo", "video_id": 2}', 'Vimeo', 900, 1800),
(6, 6, 'Email Open', '2022-09-25', 'open', '{"email_id": 2}', 'Email', 600, 1200),
(7, 7, 'Ad Click', '2022-10-05', 'click', '{"ad_platform": "Facebook", "ad_id": 3}', 'Facebook', 1000, 2000),
(8, 8, 'Video View', '2022-11-10', 'view', '{"video_platform": "YouTube", "video_id": 3}', 'YouTube', 1100, 2200),
(9, 9, 'Email Open', '2022-12-15', 'open', '{"email_id": 3}', 'Email', 1200, 2400),
(10, 10, 'Ad Click', '2023-01-20', 'click', '{"ad_platform": "Google", "ad_id": 4}', 'Google', 1300, 2600);


-- Inserting data into marketing_attribution table
INSERT INTO marketing_attribution (attribution_id, user_id, campaign_id, event_id, attribution_date) VALUES
(1, 1, 1, 1, '2022-03-03'),
(2, 2, 2, 2, '2022-04-05'),
(3, 3, 3, 3, '2022-05-10'),
(4, 4, 4, 4, '2022-06-15'),
(5, 5, 5, 5, '2022-08-20'),
(6, 6, 6, 6, '2022-09-25'),
--(7, 7, 7, 7, '2022-10-05'),
(8, 8, 8, 8, '2022-11-10'),
(9, 9, 9, 9, '2022-12-15'),
(10, 10, 10, 10, '2023-01-20'),
(11, 11, 1, 1, '2022-03-03'),
(12, 12, 2, 2, '2022-04-05'),
(13, 13, 3, 3, '2022-05-10'),
(14, 14, 4, 4, '2022-06-15'),
(15, 15, 5, 5, '2022-08-20'),
(16, 16, 6, 6, '2022-09-25'),
(17, 17, 7, 7, '2022-10-05'),
(18, 18, 8, 8, '2022-11-10'),
(19, 19, 9, 9, '2022-12-15'),
(20, 20, 10, 10, '2023-01-20'),
(21, 21, 1, 1, '2022-03-03'),
(22, 22, 2, 2, '2022-04-05'),
(23, 23, 3, 3, '2022-05-10'),
(24, 24, 4, 4, '2022-06-15'),
(25, 25, 5, 5, '2022-08-20'),
(26, 26, 6, 6, '2022-09-25'),
(27, 27, 7, 7, '2022-10-05'),
(28, 28, 8, 8, '2022-11-10'),
(29, 29, 9, 9, '2022-12-15'),
(30, 30, 10, 10, '2023-01-20'),
(31, 31, 1, 1, '2022-03-03'),
(32, 32, 2, 2, '2022-04-05'),
(33, 33, 3, 3, '2022-05-10'),
(34, 34, 4, 4, '2022-06-15'),
(35, 35, 5, 5, '2022-08-20'),
(36, 36, 6, 6, '2022-09-25'),
(37, 37, 2, 2, '2022-04-09'),
(38, 38, 4, 4, '2022-06-17'),
(39, 39, 5, 5, '2022-08-23'),
(40, 40, 6, 6, '2022-09-27'),
(41, 41, 7, 7, '2022-10-07'),
(42, 42, 8, 8, '2022-11-12'),
(43, 43, 10, 10, '2023-01-23'),
(44, 44, 1, 1, '2022-03-05'),
(45, 45, 2, 2, '2022-04-11'),
(46, 46, 3, 3, '2022-05-14'),
(47, 47, 4, 4, '2022-06-20'),
(48, 48, 5, 5, '2022-08-25'),
(49, 49, 6, 6, '2022-09-29'),
(50, 50, 7, 7, '2022-10-08'),
(51, 51, 8, 8, '2022-11-13'),
--(52, 2, 7, 7, '2022-10-06'),
(53, 3, 8, 8, '2022-11-11'),
(54, 4, 9, 9, '2022-12-16'),
(55, 5, 10, 10, '2023-01-21'),
(56, 6, 1, 1, '2022-03-04'),
--(57, 7, 2, 2, '2022-04-06'),
(58, 8, 3, 3, '2022-05-11'),
(59, 9, 4, 4, '2022-06-16'),
(60, 10, 5, 5, '2022-08-21'),
(61, 1, 6, 6, '2022-09-26'),
--(62, 2, 7, 7, '2022-10-07'),
(63, 3, 8, 8, '2022-11-12'),
(64, 4, 9, 9, '2022-12-17'),
(65, 5, 10, 10, '2023-01-22'),
(66, 6, 1, 1, '2022-03-05'),
--(67, 7, 2, 2, '2022-04-07'),
(68, 8, 3, 3, '2022-05-12'),
(69, 9, 4, 4, '2022-06-17'),
(70, 10, 5, 5, '2022-08-22'),
(71, 1, 6, 6, '2022-09-28'),
--(72, 2, 7, 7, '2022-10-08'),
(73, 3, 8, 8, '2022-11-13'),
(74, 4, 9, 9, '2022-12-18'),
(75, 5, 10, 10, '2023-01-23'),
(76, 6, 1, 1, '2022-03-06'),
--(77, 7, 2, 2, '2022-04-08'),
(78, 8, 3, 3, '2022-05-13'),
(79, 9, 4, 4, '2022-06-18'),
(80, 10, 5, 5, '2022-08-23'),
(81, 1, 6, 6, '2022-09-29'),
(82, 2, 7, 7, '2022-10-09'),
(83, 3, 8, 8, '2022-11-14'),
(84, 4, 9, 9, '2022-12-19'),
(85, 5, 10, 10, '2023-01-24'),
(86, 6, 1, 1, '2022-03-07'),
(87, 87, 9, 39, '2022-12-15'),
(88, 88, 10, 40, '2023-01-20'),
(89, 89, 10, 41, '2023-01-20'),
(90, 90, 10, 42, '2023-01-20'),
(91, 91, 10, 43, '2023-01-20'),
(92, 92, 10, 44, '2023-01-20'),
(93, 93, 10, 45, '2023-01-20'),
(94, 94, 10, 46, '2023-01-20'),
(95, 95, 10, 47, '2023-01-20'),
(96, 96, 10, 48, '2023-01-20'),
(97, 97, 10, 49, '2023-01-20'),
(98, 98, 10, 50, '2023-01-20'),
(99, 99, 10, 51, '2023-01-20'),
(100, 100, 10, 52, '2023-01-20');




CREATE TABLE monthly_pass_users (
  user_id INTEGER PRIMARY KEY,
  start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  end_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  subscription_amount REAL NOT NULL
);


INSERT INTO monthly_pass_users (user_id, start_date, end_date, subscription_amount)
VALUES 
(1, '2023-02-01 00:00:00', '2023-02-28 23:59:59', 19.99),
(2, '2023-02-15 00:00:00', '2023-03-14 23:59:59', 24.99),
(3, '2023-03-01 00:00:00', '2023-03-31 23:59:59', 29.99),
(4, '2023-03-15 00:00:00', '2023-04-14 23:59:59', 34.99),
(5, '2023-04-01 00:00:00', '2023-04-30 23:59:59', 19.99),
(6, '2023-04-15 00:00:00', '2023-05-14 23:59:59', 24.99),
(7, '2023-05-01 00:00:00', '2023-05-31 23:59:59', 29.99),
(8, '2023-05-15 00:00:00', '2023-06-14 23:59:59', 34.99),
(9, '2023-06-01 00:00:00', '2023-06-30 23:59:59', 19.99),
(10, '2023-06-15 00:00:00', '2023-07-14 23:59:59', 24.99),
(11, '2023-07-01 00:00:00', '2023-07-31 23:59:59', 29.99),
(12, '2023-07-15 00:00:00', '2023-08-14 23:59:59', 34.99),
(13, '2023-08-01 00:00:00', '2023-08-31 23:59:59', 19.99),
(14, '2023-08-15 00:00:00', '2023-09-14 23:59:59', 24.99),
(15, '2023-09-01 00:00:00', '2023-09-30 23:59:59', 29.99),
(16, '2023-09-15 00:00:00', '2023-10-14 23:59:59', 34.99),
(17, '2023-10-01 00:00:00', '2023-10-31 23:59:59', 19.99),
(18, '2023-10-15 00:00:00', '2023-11-14 23:59:59', 24.99),
(19, '2023-11-01 00:00:00', '2023-11-30 23:59:59', 29.99),
(20, '2023-11-15 00:00:00', '2023-12-14 23:59:59', 34.99),
(21, '2023-12-01 00:00:00', '2023-12-31 23:59:59', 19.99),
(22, '2023-12-15 00:00:00', '2024-01-14 23:59:59', 24.99),
(23, '2024-01-01 00:00:00', '2024-01-31 23:59:59', 29.99),
(24, '2024-01-15 00:00:00', '2024-02-14 23:59:59', 34.99),
(25, '2024-02-01 00:00:00', '2024-02-29 23:59:59', 19.99),
(26, '2024-02-15 00:00:00', '2024-03-14 23:59:59', 24.99),
(27, '2024-03-01 00:00:00', '2024-03-31 23:59:59', 29.99),
(28, '2024-03-15 00:00:00', '2024-04-14 23:59:59', 34.99),
(29, '2024-04-01 00:00:00', '2024-04-30 23:59:59', 19.99),
(30, '2024-04-15 00:00:00', '2024-05-14 23:59:59', 24.99);
