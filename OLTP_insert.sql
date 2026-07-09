-- -- Source - https://stackoverflow.com/a/61001710
-- -- Posted by nbk, modified by community. See post 'Timeline' for change history
-- -- Retrieved 2026-07-09, License - CC BY-SA 4.0
-- -- Source - https://stackoverflow.com/a/9573458
-- -- Posted by Paolo Falabella, modified by community. See post 'Timeline' for change history
-- -- Retrieved 2026-07-09, License - CC BY-SA 3.0
-- USE CA22B2407;
-- DELIMITER $$

-- DROP PROCEDURE IF EXISTS load_cleaned_csvs$$
-- CREATE PROCEDURE load_cleaned_csvs(IN p_dir VARCHAR(255), IN p_csv_list TEXT)
-- BEGIN
--     DECLARE v_csv_name VARCHAR(255);
--     DECLARE v_table_name VARCHAR(255);
--     DECLARE v_csvs TEXT;
--     DECLARE v_pos INT;
--     DECLARE v_stmt TEXT;

--     SET v_csvs = p_csv_list;

--     WHILE v_csvs <> '' DO
--         SET v_pos = POSITION(',' IN v_csvs);

--         IF v_pos = 0 THEN
--             SET v_csv_name = TRIM(v_csvs);
--             SET v_csvs = '';
--         ELSE
--             SET v_csv_name = TRIM(SUBSTRING(v_csvs, 1, v_pos - 1));
--             SET v_csvs = SUBSTRING(v_csvs, v_pos + 1);
--         END IF;

--         IF v_csv_name LIKE 'cleaned_%.csv' THEN
--             SET v_table_name = LOWER(REPLACE(REPLACE(REPLACE(v_csv_name, 'cleaned_', ''), 'ies.csv', 'y'), 's.csv', ''));
--             SET v_stmt = CONCAT(
--                 "LOAD DATA LOCAL INFILE '",
--                 REPLACE(p_dir, '\\', '/'),
--                 '/',
--                 v_csv_name,
--                 "' INTO TABLE ",
--                 v_table_name,
--                 " FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n' IGNORE 1 ROWS"
--             );

--             SET @sql = v_stmt;
--             PREPARE stmt FROM @sql;
--             EXECUTE stmt;
--             DEALLOCATE PREPARE stmt;
--         END IF;
--     END WHILE;
-- END$$

-- DELIMITER ;

-- -- Example usage:
-- -- CALL load_cleaned_csvs('C:/Users/JunHao/Downloads/DENG CA2', 'cleaned_members.csv, cleaned_staff.csv, cleaned_books.csv, cleaned_bookcopies.csv, cleaned_loans.csv');
-- CALL load_cleaned_csvs('C:/Users/JunHao/Downloads/DENG CA2',
-- 'cleaned_members.csv, cleaned_staff.csv, cleaned_books.csv, cleaned_bookcopies.csv, cleaned_loans.csv');
USE CA22B2407;
SET GLOBAL local_infile = 1;
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO MembershipTier (TierID, TierName, TierLevel, BorrowLimit)
VALUES ('T0001', 'Basic', 1, 20),
       ('T0002', 'Advanced', 2, 30),
       ('T0003', 'Premium', 3, 50),
       ('T9999', 'SuperAdmin', 9999, 9999);


LOAD DATA LOCAL INFILE 'C:/Users/JunHao/Downloads/DENG CA2/cleaned_members.csv'
INTO TABLE Member
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/JunHao/Downloads/DENG CA2/cleaned_staff.csv'
INTO TABLE Staff
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/JunHao/Downloads/DENG CA2/cleaned_books.csv'
INTO TABLE Book
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/JunHao/Downloads/DENG CA2/cleaned_bookcopies.csv'
INTO TABLE BookCopy
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/JunHao/Downloads/DENG CA2/cleaned_loans.csv'
INTO TABLE Loan
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET FOREIGN_KEY_CHECKS = 1;
