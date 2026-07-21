USE CA2DW2B2407;

INSERT INTO CA2DW2B2407.FactLoan (DateKey, MemberKey, StaffKey, BookCopyKey, LoanDatetime, ReturnDatetime, LoanStatus)
SELECT
    d.DateKey,
    m.MemberKey,
    s.StaffKey,
    bc.BookCopyKey,
    l.LoanDatetime,
    l.ReturnDatetime,
    CASE
        WHEN l.ReturnDatetime IS NULL THEN 'On Loan'
        WHEN l.ReturnDatetime > l.DueDate THEN 'Returned Late'
        ELSE 'Returned On Time'
    END AS LoanStatus
FROM CA22B2407.Loan l