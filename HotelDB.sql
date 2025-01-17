CREATE DATABASE hotelDB;
USE hotelDB;


CREATE TABLE Staff (
    sid INT PRIMARY KEY IDENTITY,
    name VARCHAR(10) NOT NULL,
    position VARCHAR(10) NOT NULL,
    contactNum VARCHAR(10) NOT NULL,
    hotelWork VARCHAR(10) NOT NULL
);


CREATE TABLE hotel (
    hotelId INT PRIMARY KEY IDENTITY,
    name VARCHAR(10) NOT NULL,
    location VARCHAR(10) NOT NULL,
    contactNum VARCHAR(10) NOT NULL,
    Sid INT,
    FOREIGN KEY (Sid) REFERENCES Staff(sid) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UC_HotelName UNIQUE (name),
    CONSTRAINT UC_HotelContact UNIQUE (contactNum)
);


CREATE TABLE room (
    roomID INT PRIMARY KEY IDENTITY,
    name VARCHAR(10) NOT NULL,
    roomNum INT NOT NULL,
    type VARCHAR(10) NOT NULL CHECK (type IN ('Single', 'Double', 'Suite')),
    price FLOAT NOT NULL CHECK (price > 0),
    aviStatus VARCHAR(10) NOT NULL DEFAULT 'TRUE',
    hotelID INT,
    FOREIGN KEY (hotelID) REFERENCES hotel(hotelId) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UC_RoomNumber UNIQUE (roomNum)
);

CREATE TABLE Gust (
    gustID INT PRIMARY KEY IDENTITY,
    name VARCHAR(10) NOT NULL,
    contactNum VARCHAR(10) NOT NULL,
    idProof VARCHAR(10) NOT NULL,
    reviewsRate DECIMAL(10, 2) CHECK (reviewsRate BETWEEN 1 AND 5),
    FOREIGN KEY (reviewsRate) REFERENCES reviews(rating) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT UC_GustEmail UNIQUE (contactNum)
);


CREATE TABLE reviews (
    rating DECIMAL(10, 2) PRIMARY KEY CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(50) DEFAULT 'No comments',
    date DATE NOT NULL
);

CREATE TABLE booking (
    date INT PRIMARY KEY,
    checkIN TIME NOT NULL,
    checkOut TIME NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('Pending', 'Confirmed', 'Canceled', 'Check-in', 'Check-out')) DEFAULT 'Pending',
    totalCost FLOAT NOT NULL CHECK (totalCost > 0),
    gustId INT,
    roomId INT,
    FOREIGN KEY (roomId) REFERENCES room(roomID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (gustId) REFERENCES Gust(gustID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Payment (
    pid INT PRIMARY KEY IDENTITY,
    date DATE NOT NULL,
    amount FLOAT NOT NULL CHECK (amount > 0),
    method VARCHAR(10) NOT NULL,
    bookDate INT,
    FOREIGN KEY (bookDate) REFERENCES booking(date) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TRIGGER trg_check_in_check_out
ON booking
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @checkIn TIME, @checkOut TIME;

    SELECT @checkIn = checkIn, @checkOut = checkOut FROM inserted;

    IF @checkIn > @checkOut
    BEGIN

        RAISERROR ('Check-in date must be less than or equal to Check-out date.', 16, 1);
        ROLLBACK TRANSACTION; 
    END
END;
