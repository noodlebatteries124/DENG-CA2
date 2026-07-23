DROP DATABASE IF EXISTS CA2DW2B2407;
CREATE DATABASE CA2DW2B2407;
USE CA2DW2B2407;

-- 1. Date Dimension
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY, 
    FullDate DATE NOT NULL,
    DayOfWeek INT NOT NULL,
    DayName VARCHAR(10) NOT NULL,
    DayOfMonth INT NOT NULL,
    Month INT NOT NULL,
    MonthName VARCHAR(10) NOT NULL,
    Quarter INT NOT NULL,
    Year INT NOT NULL
);

CREATE TABLE DimMember (
    MemberKey INT AUTO_INCREMENT PRIMARY KEY,
    MemberID CHAR(10) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Contact BIGINT NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(10) NOT NULL,
    Occupation VARCHAR(50) NULL,
    RegistrationDatetime DATETIME NOT NULL,
    TierName VARCHAR(20) NOT NULL,
    TierLevel INT NOT NULL,
    BorrowLimit INT NOT NULL,
    DOB DATETIME NOT NULL,
    TierID CHAR(10) NOT NULL
);

CREATE TABLE DimStaff (
    StaffKey INT AUTO_INCREMENT PRIMARY KEY,
    StaffID CHAR(10) NOT NULL,
    StaffName VARCHAR(100) NOT NULL,
    Gender CHAR(10) NOT NULL,
    Contact VARCHAR(100) NOT NULL,
    EmploymentType VARCHAR(20) NOT NULL,
    StartDate DATETIME NOT NULL,
    Department VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL
);

CREATE TABLE DimBook (
    BookKey INT AUTO_INCREMENT PRIMARY KEY,
    BookID CHAR(10) NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    MinTierID CHAR(10) NOT NULL
);

CREATE TABLE FactLoan (
    LoanKey INT AUTO_INCREMENT PRIMARY KEY,
    MemberKey INT NOT NULL,
    StaffKey INT NOT NULL,
    BookKey INT NOT NULL,
    CopySeqNo INT NOT NULL,
    StartDate INT NOT NULL,
    DueDate INT NOT NULL,
    ReturnDate INT NULL,

    LoanDurationDay INT NULL,
    IsReturnedLate INT NOT NULL,
    LoanCount INT DEFAULT 1,

    FOREIGN KEY (MemberKey) REFERENCES DimMember(MemberKey),
    FOREIGN KEY (StaffKey) REFERENCES DimStaff(StaffKey),
    FOREIGN KEY (BookKey) REFERENCES DimBook(BookKey),
    FOREIGN KEY (StartDate) REFERENCES DimDate(DateKey),
    FOREIGN KEY (DueDate) REFERENCES DimDate(DateKey),
    FOREIGN KEY (ReturnDate) REFERENCES DimDate(DateKey)
);