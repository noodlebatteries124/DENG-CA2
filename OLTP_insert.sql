USE CA22B2407;
SET GLOBAL local_infile = 1;
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO MembershipTier (TierID, TierName, TierLevel, BorrowLimit)
VALUES ('T0001', 'Basic', 1, 20),
       ('T0002', 'Advanced', 2, 30),
       ('T0003', 'Premium', 3, 50),
       ('T9999', 'SuperAdmin', 9999, 9999);


LOAD DATA LOCAL INFILE 'C:/Users/kayde/OneDrive/DAEN/CA2/DENG-CA2/cleaned_members.csv'
INTO TABLE Member
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(MemberID, Name, @number, @email, DOB, @gender, Occupation, RegistrationDatetime, TierID)
SET 
    Contact = CONCAT(@number,'-', @email),
    Gender = LEFT(@gender, 1);

LOAD DATA LOCAL INFILE 'C:/Users/kayde/OneDrive/DAEN/CA2/DENG-CA2/cleaned_staff.csv'
INTO TABLE Staff
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(StaffID, Name, @gender, Contact, EmploymentType, StartDate, Department, DOB)
SET 
    Gender = LEFT(@gender, 1);

LOAD DATA LOCAL INFILE 'C:/Users/kayde/OneDrive/DAEN/CA2/DENG-CA2/cleaned_books.csv'
INTO TABLE Book
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/kayde/OneDrive/DAEN/CA2/DENG-CA2/cleaned_bookcopies.csv'
INTO TABLE BookCopy
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/kayde/OneDrive/DAEN/CA2/DENG-CA2/cleaned_loans.csv'
INTO TABLE Loan
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(MemberID,BookID,CopySeqNo,StaffID,StartDatetime,DueDate,ReturnDatetime);

SET FOREIGN_KEY_CHECKS = 1;

SELECT 'MembershipTier' AS TableName, COUNT(*) AS RowCount
FROM MembershipTier
UNION ALL
SELECT 'Member', COUNT(*) FROM Member
UNION ALL
SELECT 'Staff', COUNT(*) FROM Staff
UNION ALL
SELECT 'Book', COUNT(*) FROM Book
UNION ALL
SELECT 'BookCopy', COUNT(*) FROM BookCopy
UNION ALL
SELECT 'Loan', COUNT(*) FROM Loan;

SELECT COUNT(*) AS IncorrectDueDates
FROM Loan
WHERE DATEDIFF(DueDate, DATE(StartDatetime)) <> 14;

SELECT COUNT(*) AS MissingReturnDates
FROM Loan
WHERE ReturnDatetime IS NULL;