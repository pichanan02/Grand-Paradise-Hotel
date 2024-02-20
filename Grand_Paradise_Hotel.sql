-- ##### Hotel Business Grand Paradise Hotel ##### --
SELECT *
FROM reservations;

SELECT *
FROM rooms;

-- 1. Retrieve room type information and the number of rooms available in each category
SELECT room_type, COUNT(status) AS rooms_available
FROM rooms
WHERE status = 'available'
GROUP BY room_type;


-- 2. Calculate the average price that customers pay.
SELECT AVG(amount_paid) AS average_price
FROM reservations;


-- 3. Which days (Monday - Sunday) are the highest number of room reservations?
SELECT
    EXTRACT(DOW FROM check_in_date) AS day_of_week,
    CASE
        WHEN EXTRACT(DOW FROM check_in_date) = 0 THEN 'Sunday'
        WHEN EXTRACT(DOW FROM check_in_date) = 1 THEN 'Monday'
        WHEN EXTRACT(DOW FROM check_in_date) = 2 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM check_in_date) = 3 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM check_in_date) = 4 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM check_in_date) = 5 THEN 'Friday'
        WHEN EXTRACT(DOW FROM check_in_date) = 6 THEN 'Saturday'
    END AS day_name,
    COUNT(*) AS num_of_reservations
FROM reservations
GROUP BY day_of_week
ORDER BY num_of_reservations DESC;
-------

SELECT
CASE
WHEN strftime('%w', check_in_date) = '0' THEN 'Sunday'
WHEN strftime('%w', check_in_date) = '1' THEN 'Monday'
WHEN strftime('%w', check_in_date) = '2' THEN 'Tuesday'
WHEN strftime('%w', check_in_date) = '3' THEN 'Wednesday'
WHEN strftime('%w', check_in_date) = '4' THEN 'Thursday'
WHEN strftime('%w', check_in_date) = '5' THEN 'Friday'
WHEN strftime('%w', check_in_date) = '6' THEN 'Saturday'
END AS day_of_week,
COUNT(*) AS booking_count
FROM reservations
GROUP BY day_of_week
ORDER BY booking_count DESC;


-- 4. Which customer has the highest spending amount of all time and how many times have they booked a room?
SELECT customer_id, COUNT(*) AS booking_count, SUM(amount_paid) AS spending_amount
FROM reservations
GROUP BY customer_id
ORDER BY spending_amount DESC
LIMIT 1;


-- 5. Calculate the occupancy rate (Occupancy Rate).
-- Occupancy Rate = (Number of rooms with status ‘occupied’ / Total number of rooms) * 100
SELECT
    SUM(CASE
        WHEN status = 'available' THEN 0
        WHEN status = 'occupied' THEN 1 END) * 1.0 / COUNT(*) * 100 AS occupancy_rate
FROM rooms
-----

