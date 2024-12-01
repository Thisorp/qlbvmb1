CREATE TABLE `admin` (
  `Id` int AUTO_INCREMENT PRIMARY KEY,
  `Username` varchar(255),
  `Password` varchar(255),
  `Email` varchar(255),
  `Phone` varchar(255),
  `Role` varchar(255)
);

CREATE TABLE `airline` (
  `AirlineID` int AUTO_INCREMENT PRIMARY KEY,
  `Name` varchar(255),
  `ContactInfo` varchar(255)
);

CREATE TABLE `airport` (
  `AirportID` int AUTO_INCREMENT PRIMARY KEY,
  `Name` varchar(255),
  `Location` varchar(255),
  `ContactInfo` varchar(255)
);

CREATE TABLE `customer` (
  `CustomerID` int AUTO_INCREMENT PRIMARY KEY,
  `Name` varchar(255),
  `Email` varchar(255),
  `Phone` varchar(255),
  `Password` varchar(255)
);

CREATE TABLE `flight` (
  `FlightID` int AUTO_INCREMENT PRIMARY KEY,
  `AirlineID` int,
  `FromAirportID` int,
  `ToAirportID` int,
  `DepartureTime` datetime,
  `ArrivalTime` datetime,
  `Gate` varchar(255)
);

CREATE TABLE `seat` (
  `SeatID` int AUTO_INCREMENT PRIMARY KEY,
  `FlightID` int,
  `SeatNumber` varchar(255),
  `IsAvailable` boolean,
  `Price` decimal
);

CREATE TABLE `booking` (
  `BookingID` int AUTO_INCREMENT PRIMARY KEY,
  `CustomerID` int,
  `FlightID` int,
  `SeatID` int,
  `BookingDate` datetime,
  `Status` boolean
);

CREATE TABLE `flight_statistics` (
  `FlightID` int PRIMARY KEY,
  `AirlineID` int,
  `TotalSeatsBooked` int,
  `AvailableSeats` int
);

CREATE TABLE `flight_revenue` (
  `FlightID` int PRIMARY KEY,
  `AirlineID` int,
  `TotalRevenue` decimal(10,2)
);

ALTER TABLE `flight` ADD FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`AirlineID`);

ALTER TABLE `flight` ADD FOREIGN KEY (`FromAirportID`) REFERENCES `airport` (`AirportID`);

ALTER TABLE `flight` ADD FOREIGN KEY (`ToAirportID`) REFERENCES `airport` (`AirportID`);

ALTER TABLE `seat` ADD FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`);

ALTER TABLE `booking` ADD FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);

ALTER TABLE `booking` ADD FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`);

ALTER TABLE `booking` ADD FOREIGN KEY (`SeatID`) REFERENCES `seat` (`SeatID`);

ALTER TABLE `flight_statistics` ADD FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`);

ALTER TABLE `flight_statistics` ADD FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`AirlineID`);

ALTER TABLE `flight_revenue` ADD FOREIGN KEY (`FlightID`) REFERENCES `flight` (`FlightID`);

ALTER TABLE `flight_revenue` ADD FOREIGN KEY (`AirlineID`) REFERENCES `airline` (`AirlineID`);

-- Insert data into admin table
INSERT INTO `admin` (`Id`, `Username`, `Password`, `Email`, `Phone`, `Role`) VALUES
(1, 'admin1', '123456', 'admin1@example.com', '1234567890', 'admin'),
(2, 'admin2', '123456', 'admin2@example.com', '0987654321', 'airline'),
(3, 'admin3', '123456', 'admin3@example.com', '0987654321', 'airport');

-- Insert data into airline table
INSERT INTO `airline` (`AirlineID`, `Name`, `ContactInfo`) VALUES
(1, 'Airline A', 'contact@airlinea.com'),
(2, 'Airline B', 'contact@airlineb.com'),
(3, 'Airline C', 'contact@airlinec.com'),
(4, 'Airline D', 'contact@airlined.com'),
(5, 'Airline E', 'contact@airlinee.com');

-- Insert data into airport table
INSERT INTO `airport` (`AirportID`, `Name`, `Location`, `ContactInfo`) VALUES
(1, 'Airport A', 'Location A', 'contact@airporta.com'),
(2, 'Airport B', 'Location B', 'contact@airportb.com'),
(3, 'Airport C', 'Location C', 'contact@airportc.com'),
(4, 'Airport D', 'Location D', 'contact@airportd.com'),
(5, 'Airport E', 'Location E', 'contact@airporte.com');

-- Insert data into customer table
INSERT INTO `customer` (`CustomerID`, `Name`, `Email`, `Phone`, `Password`) VALUES
(1, 'Customer A', 'customerA@example.com', '1112223333', '123456'),
(2, 'Customer B', 'customerB@example.com', '4445556666', '123456'),
(3, 'Customer C', 'customerC@example.com', '7778889999', '123456'),
(4, 'Customer D', 'customerD@example.com', '2223334444', '123456'),
(5, 'Customer E', 'customerE@example.com', '5556667777', '123456');

-- Insert data into flight table
INSERT INTO `flight` (`FlightID`, `AirlineID`, `FromAirportID`, `ToAirportID`, `DepartureTime`, `ArrivalTime`, `Gate`) VALUES
(1, 1, 1, 2, '2023-10-01 10:00:00', '2023-10-01 12:00:00', 'A1'),
(2, 2, 2, 3, '2023-10-02 14:00:00', '2023-10-02 16:00:00', 'B1'),
(3, 3, 3, 4, '2023-10-03 09:00:00', '2023-10-03 11:00:00', 'C1'),
(4, 4, 4, 5, '2023-10-04 08:00:00', '2023-10-04 10:00:00', 'D1'),
(5, 5, 5, 1, '2023-10-05 07:00:00', '2023-10-05 09:00:00', 'E1');

-- Insert data into seat table
INSERT INTO `seat` (`SeatID`, `FlightID`, `SeatNumber`, `IsAvailable`, `Price`) VALUES
(1, 1, '1A', TRUE, 100.00),
(2, 1, '1B', TRUE, 100.00),
(3, 2, '2A', TRUE, 150.00),
(4, 2, '2B', TRUE, 150.00),
(5, 3, '3A', TRUE, 200.00),
(6, 3, '3B', TRUE, 200.00),
(7, 4, '4A', TRUE, 250.00),
(8, 4, '4B', TRUE, 250.00),
(9, 5, '5A', TRUE, 300.00),
(10, 5, '5B', TRUE, 300.00);

-- Insert data into booking table
INSERT INTO `booking` (`BookingID`, `CustomerID`, `FlightID`, `SeatID`, `BookingDate`, `Status`) VALUES
(1, 1, 1, 1, '2023-09 -30 09:00:00', TRUE),
(2, 2, 2, 3, '2023-10-01 13:00:00', TRUE),
(3, 3, 3, 5, '2023-10-02 10:00:00', TRUE),
(4, 4, 4, 7, '2023-10-03 11:00:00', TRUE),
(5, 5, 5, 9, '2023-10-04 12:00:00', TRUE);

-- Insert data into flight_statistics table
INSERT INTO `flight_statistics` (`FlightID`, `AirlineID`, `TotalSeatsBooked`, `AvailableSeats`) VALUES
(1, 1, 1, 1),  -- 1 booking, 1 seat booked, 1 seat available
(2, 2, 1, 1),  -- 1 booking, 1 seat booked, 1 seat available
(3, 3, 1, 1),  -- 1 booking, 1 seat booked, 1 seat available
(4, 4, 1, 1),  -- 1 booking, 1 seat booked, 1 seat available
(5, 5, 1, 1);  -- 1 booking, 1 seat booked, 1 seat available

-- Insert data into flight_revenue table
INSERT INTO `flight_revenue` (`FlightID`, `AirlineID`, `TotalRevenue`) VALUES
(1, 1, 100.00),  -- Total revenue from flight 1
(2, 2, 150.00),  -- Total revenue from flight 2
(3, 3, 200.00),  -- Total revenue from flight 3
(4, 4, 250.00),  -- Total revenue from flight 4
(5, 5, 300.00);  -- Total revenue from flight 5