--DATA INSERTION PART

INSERT INTO guests (name, email, address, phone_number, id_number)
VALUES ('Mustafa Eski', 'musatafa@gmail.com', 'Ankara', '05301658435', '12345678931');

INSERT INTO guests (name, email, address, phone_number, id_number)
VALUES ('Ayşe Kaya', 'ayse@gmail.com', 'İstanbul', '05329998877', '82223344556');

INSERT INTO guests (name, email, address, phone_number, id_number)
VALUES ('Mehmet Çelik', 'İzmir', '05347766554', '43334455667');

INSERT INTO guests (name, email, address, phone_number, id_number)
VALUES ('Zeynep Korkmaz', 'Antalya', '05312233445', '96445566778');

INSERT INTO guests (name, email, address, phone_number, id_number)
VALUES ('Can Çebi', 'Trabzon', '05378876161', '12556677889');

INSERT INTO rooms (room_number, room_type, price_per_night, capacity, floor_number)
VALUES ('121', 'Single', 500, 1, 1);

INSERT INTO rooms (room_number, room_type, price_per_night, capacity, floor_number)
VALUES ('152', 'Double', 800, 2, 1);

INSERT INTO rooms (room_number, room_type, price_per_night, capacity, floor_number)
VALUES ('225', 'Suite', 1200, 3, 2);

INSERT INTO rooms (room_number, room_type, price_per_night, capacity, floor_number)
VALUES ('202', 'Deluxe', 1500, 4, 2);

INSERT INTO rooms (room_number, room_type, price_per_night, capacity, floor_number)
VALUES ('301', 'Double', 900, 2, 3);

INSERT INTO amenities (amenity_name, description)
VALUES ('Wi-Fi', 'high-speed internet');

INSERT INTO amenities (amenity_name, description)
VALUES ('Air Conditioner', 'true temperature for comfort');

INSERT INTO amenities (amenity_name, description)
VALUES ('TV', 'Smart TV with Netflix');

INSERT INTO amenities (amenity_name, description)
VALUES ('Mini Bar', 'Stocked daily');

INSERT INTO amenities (amenity_name, description)
VALUES ('Balcony', 'Sea view');

INSERT INTO room_amenities (room_id, amenity_id) VALUES (1, 1);
INSERT INTO room_amenities (room_id, amenity_id) VALUES (2, 1);
INSERT INTO room_amenities (room_id, amenity_id) VALUES (3, 2);
INSERT INTO room_amenities (room_id, amenity_id) VALUES (4, 3);
INSERT INTO room_amenities (room_id, amenity_id) VALUES (5, 4);

INSERT INTO services (service_name, description, price)
VALUES ('Breakfast', 'Buffet breakfast', 100);

INSERT INTO services (service_name, description, price)
VALUES ('Laundry', 'cleaning service', 150);

INSERT INTO services (service_name, description, price)
VALUES ('Spa', 'Massage access', 250);

INSERT INTO services (service_name, description, price)
VALUES ('Airport Transfer', 'Hotel pickup', 300);

INSERT INTO services (service_name, description, price)
VALUES ('Gym', 'gym access', 120);

INSERT INTO reservations (guest_id, check_in_date, check_out_date, total_amount, reservation_status, description)
VALUES (1, DATE '2025-11-01', DATE '2025-11-05', 2000, 'Confirmed', '4-night stay');

INSERT INTO reservations (guest_id, check_in_date, check_out_date, total_amount, reservation_status, description)
VALUES (2, DATE '2025-11-02', DATE '2025-11-04', 1600, 'CheckedIn', '2-night stay');

INSERT INTO reservations (guest_id, check_in_date, check_out_date, total_amount, reservation_status, description)
VALUES (3, DATE '2025-11-03', DATE '2025-11-06', 2400, 'Confirmed', '3-night stay');

INSERT INTO reservations (guest_id, check_in_date, check_out_date, total_amount, reservation_status, description)
VALUES (4, DATE '2025-11-04', DATE '2025-11-07', 1800, 'CheckedOut', '3-night stay');

INSERT INTO reservations (guest_id, check_in_date, check_out_date, total_amount, reservation_status, description)
VALUES (5, DATE '2025-11-05', DATE '2025-11-09', 3600, 'Confirmed', '4-night stay');

INSERT INTO reservation_rooms VALUES (1, 1, 4);
INSERT INTO reservation_rooms VALUES (2, 2, 2);
INSERT INTO reservation_rooms VALUES (3, 3, 3);
INSERT INTO reservation_rooms VALUES (4, 4, 3);
INSERT INTO reservation_rooms VALUES (5, 5, 4);

INSERT INTO reservation_services VALUES (1, 1, 2);
INSERT INTO reservation_services VALUES (2, 2, 1);
INSERT INTO reservation_services VALUES (3, 3, 1);
INSERT INTO reservation_services VALUES (4, 4, 2);
INSERT INTO reservation_services VALUES (5, 5, 3);

INSERT INTO payments VALUES (1, 1, 'CreditCard', 'Completed', SYSDATE);
INSERT INTO payments VALUES (2, 2, 'Cash', 'Completed', SYSDATE);
INSERT INTO payments VALUES (3, 3, 'BankTransfer', 'Pending', SYSDATE);
INSERT INTO payments VALUES (4, 4, 'Crypto', 'Completed', SYSDATE);
INSERT INTO payments VALUES (5, 5, 'CreditCard', 'Completed', SYSDATE);

INSERT INTO reviews VALUES (1, 1, 1, 5, 'Perfect stay thank you!', SYSDATE);
INSERT INTO reviews VALUES (2, 2, 2, 4, 'was nice and clean.', SYSDATE);
INSERT INTO reviews VALUES (3, 3, 3, 3, 'to be honest average experience for me.', SYSDATE);
INSERT INTO reviews VALUES (4, 4, 4, 5, 'Excellent place.', SYSDATE);
INSERT INTO reviews VALUES (5, 5, 5, 4, 'Good service overall.', SYSDATE);
