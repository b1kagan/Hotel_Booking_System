--QUERIES FOR ACADEMIC STUDIES ON SQL DATABASE

-- Query 5
SELECT reservation_id, reservation_status
FROM reservations
WHERE check_in_date = DATE '2024-10-15';

-- Query 6
SELECT reservation_id, guest_id, check_in_date, check_out_date, total_amount
FROM reservations
WHERE total_amount > 1000
ORDER BY total_amount DESC;

-- Query 7
SELECT room_id, room_number, room_type, price_per_night
FROM rooms
WHERE room_type = 'Deluxe'
ORDER BY price_per_night DESC
FETCH FIRST 1 ROW ONLY;

-- Query 8
SELECT rr.reservation_id,
       COUNT(DISTINCT rr.room_id) AS room_count,
       SUM(r.price_per_night * rr.number_of_nights) AS calculated_total_price
FROM reservation_rooms rr
JOIN rooms r ON rr.room_id = r.room_id
GROUP BY rr.reservation_id
HAVING COUNT(DISTINCT rr.room_id) > 1
ORDER BY calculated_total_price DESC;

-- Query 9
SELECT r.room_id, r.room_number, r.room_type, r.price_per_night, rr.number_of_nights
FROM reservation_rooms rr
JOIN rooms r ON rr.room_id = r.room_id
WHERE rr.reservation_id = 2;

-- Query 10
SELECT g.guest_id, g.name, COUNT(r.reservation_id) AS reservation_count
FROM reservations r
JOIN guests g ON r.guest_id = g.guest_id
GROUP BY g.guest_id, g.name
ORDER BY reservation_count DESC
FETCH FIRST 1 ROW WITH TIES;

-- Query 11
SELECT DISTINCT r.room_id, r.room_number, r.room_type, r.price_per_night
FROM rooms r
JOIN room_amenities ra ON r.room_id = ra.room_id
JOIN amenities a ON ra.amenity_id = a.amenity_id
WHERE UPPER(a.amenity_name) LIKE UPPER('Wi-Fi');

-- Query 12
SELECT rs.reservation_id,
       s.service_id,
       s.service_name,
       rs.quantity,
       s.price,
       (s.price * rs.quantity) AS total_line_price
FROM reservation_services rs
JOIN services s ON rs.service_id = s.service_id
WHERE rs.reservation_id = 5;

-- Query 13
SELECT r.room_id, r.room_number, r.room_type, r.price_per_night
FROM rooms r
LEFT JOIN reservation_rooms rr ON r.room_id = rr.room_id
WHERE rr.reservation_room_id IS NULL;

-- Query 14
SELECT rr.room_id, r.room_number, r.room_type, COUNT(*) AS reservation_count
FROM reservation_rooms rr
JOIN rooms r ON rr.room_id = r.room_id
GROUP BY rr.room_id, r.room_number, r.room_type
ORDER BY reservation_count DESC
FETCH FIRST 1 ROW WITH TIES;

-- Query 15
SELECT SUM(s.price * rs.quantity) AS total_spa_revenue
FROM reservation_services rs
JOIN services s ON rs.service_id = s.service_id
WHERE UPPER(s.service_name) LIKE '%SPA%';

-- Query 16
SELECT r1.reservation_id
FROM reservation_services r1
JOIN services s1 ON r1.service_id = s1.service_id
JOIN reservation_services r2 ON r1.reservation_id = r2.reservation_id
JOIN services s2 ON r2.service_id = s2.service_id
WHERE UPPER(s1.service_name) LIKE '%ROOM%'
  AND UPPER(s2.service_name) LIKE UPPER('%AIRPORT TRANSFER%')
GROUP BY r1.reservation_id;

-- Query 17
SELECT g.guest_id, g.name, COUNT(r.reservation_id) AS reservation_count
FROM reservations r
JOIN guests g ON r.guest_id = g.guest_id
GROUP BY g.guest_id, g.name
HAVING COUNT(r.reservation_id) > 1
ORDER BY reservation_count DESC;

-- Query 18
DECLARE
    v_guest_id NUMBER;
    v_reservation_id NUMBER;
BEGIN
    -- new guest
    INSERT INTO guests (name, email, address, phone_number, id_number)
    VALUES ('İbrahim Yattara', 'yattara@gmail.com', 'Guinea', '049554367287', '1355434135468')
    RETURNING guest_id INTO v_guest_id;

    -- new reservation
    INSERT INTO reservations (
        guest_id,
        check_in_date,
        check_out_date,
        total_amount,
        reservation_status,
        description
    )
    VALUES (
        v_guest_id,
        DATE '2025-12-01',
        DATE '2025-12-03',
        1500,
        'Confirmed',
        '2-night stay'
    )
    RETURNING reservation_id INTO v_reservation_id;

    -- adding 2 services to reservation
    INSERT INTO reservation_services (reservation_id, service_id, quantity)
    VALUES (v_reservation_id, 1, 1);

    INSERT INTO reservation_services (reservation_id, service_id, quantity)
    VALUES (v_reservation_id, 3, 2);
END;
/

-- 1. Pending Payments
SELECT payment_id, reservation_id, payment_status
FROM payments
WHERE payment_status <> 'Completed';

-- 2. Upcoming Check-ins
SELECT reservation_id, guest_id, check_in_date, reservation_status
FROM reservations
WHERE check_in_date > DATE '2025-06-15'
ORDER BY check_in_date;

-- 3. Guest vs Reservation
SELECT g.guest_id, g.name, r.reservation_id, r.reservation_status
FROM guests g
LEFT JOIN reservations r ON g.guest_id = r.guest_id
ORDER BY g.guest_id;

-- 4. Revenue by Status
SELECT reservation_status,
       COUNT(*) AS reservation_count,
       SUM(total_amount) AS total_revenue
FROM reservations
GROUP BY reservation_status
ORDER BY reservation_count DESC;

-- 5. Above-average Room Rates
SELECT room_id, room_number, price_per_night
FROM rooms
WHERE price_per_night > (
    SELECT AVG(price_per_night)
    FROM rooms
)
ORDER BY price_per_night DESC;
