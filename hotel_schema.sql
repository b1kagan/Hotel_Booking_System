--DDL PART

CREATE TABLE guests (
    guest_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    address VARCHAR2(200) NOT NULL,
    phone_number VARCHAR2(20) NOT NULL,
    id_number VARCHAR2(50) NOT NULL
);

CREATE TABLE rooms (
    room_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number VARCHAR2(20) NOT NULL UNIQUE,
    room_type VARCHAR2(20) DEFAULT 'Single'
        CHECK (room_type IN ('Single','Double','Suite','Deluxe')) NOT NULL,
    price_per_night NUMBER(10,2) NOT NULL,
    capacity NUMBER NOT NULL
);

CREATE TABLE amenities (
    amenity_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    amenity_name VARCHAR2(200) NOT NULL,
    description VARCHAR2(500)
);

CREATE TABLE room_amenities (
    room_amenity_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_id NUMBER NOT NULL,
    amenity_id NUMBER NOT NULL,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id)
);

CREATE TABLE reservations (
    reservation_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    guest_id NUMBER NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE,
    total_amount NUMBER(10,2),
    reservation_status VARCHAR2(20) DEFAULT 'Confirmed'
        CHECK (reservation_status IN ('Confirmed','CheckedIn','CheckedOut','Cancelled')) NOT NULL,
    description VARCHAR2(500),
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id)
);

CREATE TABLE reservation_rooms (
    reservation_room_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reservation_id NUMBER NOT NULL,
    room_id NUMBER NOT NULL,
    number_of_nights NUMBER NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE services (
    service_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_name VARCHAR2(200) NOT NULL,
    description VARCHAR2(500) NOT NULL,
    price NUMBER(10,2) NOT NULL
);

CREATE TABLE reservation_services (
    reservation_service_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reservation_id NUMBER NOT NULL,
    service_id NUMBER NOT NULL,
    quantity NUMBER DEFAULT 1 NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

CREATE TABLE payments (
    payment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reservation_id NUMBER NOT NULL,
    payment_method VARCHAR2(20) NOT NULL
        CONSTRAINT chk_payment_method_v1
        CHECK (payment_method IN ('CreditCard','Cash','BankTransfer')),
    payment_status VARCHAR2(20) DEFAULT 'Pending'
        CHECK (payment_status IN ('Completed','Pending','Refunded')) NOT NULL,
    payment_date DATE DEFAULT SYSDATE NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

CREATE TABLE reviews (
    review_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    guest_id NUMBER NOT NULL,
    reservation_id NUMBER NOT NULL,
    rating NUMBER CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    review_comment VARCHAR2(500),
    review_date DATE DEFAULT SYSDATE NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

ALTER TABLE rooms ADD floor_number NUMBER;

UPDATE amenities
SET description = 'No description'
WHERE description IS NULL;

ALTER TABLE amenities MODIFY description VARCHAR2(500) NOT NULL;

ALTER TABLE reservations DROP COLUMN description;

ALTER TABLE rooms ADD CONSTRAINT chk_capacity CHECK (capacity BETWEEN 1 AND 6);

ALTER TABLE payments DROP CONSTRAINT chk_payment_method_v1;

ALTER TABLE payments
ADD CONSTRAINT CHK_PAYMENT_METHOD
CHECK (payment_method IN ('CreditCard','Cash','BankTransfer','Crypto'));

ALTER TABLE amenities MODIFY description VARCHAR2(500) NULL;

ALTER TABLE reservations ADD description VARCHAR2(500);
