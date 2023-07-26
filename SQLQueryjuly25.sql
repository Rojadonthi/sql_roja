---Create table Person with fields PersonID, Name, DOB, Address, Age, Country
CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Address VARCHAR(200),
    Age INT,
    Country VARCHAR(50)
);


---Insert some sample data into the table using INSERT command - minimum 4 rows

INSERT INTO Person (PersonID, Name, DOB, Address, Age, Country)
VALUES
     (1, 'Rahul Sharma', '1985-10-15', '123 Main Street, Mumbai', NULL, 'India'),
    (2, 'Priya Patel', '1990-03-22', '456 Park Avenue, Delhi', NULL, 'India'),
    (3, 'Amit Singh', '1988-07-05', '789 South Road, Bangalore', NULL, 'India'),
    (4, 'Sneha Kapoor', '1995-12-12', '101 North Avenue, Kolkata', NULL, 'India');

select * from Person

--Change name of column DOB to "Date_OF_Birth"
-----ALTER TABLE Person
-----CHANGE DOB Date_OF_Birth DATE;----

EXEC sp_rename 'Person.DOB', 'Date_OF_Birth', 'COLUMN';
--Change name of column Address to Addr_Line_1
EXEC sp_rename 'Person.Address', 'Addr_Line_1', 'COLUMN';


--Insert new column Addr_Line_2
ALTER TABLE Person
ADD Addr_Line_2 VARCHAR(200) NULL;

--Create primary key on Personid column
--ALTER TABLE Person
--ADD CONSTRAINT PK_Person PRIMARY KEY (PersonID);
--- it didnot work because i already mention the primary while creating the table


--Create unclustered key on Column Name, Date_Of_Birth
CREATE INDEX IX_Name_DateOfBirth ON Person (Name, Date_Of_Birth);

--Update Addr_Line_2 column with some value for all rows
UPDATE Person
SET Addr_Line_2 = 
    CASE 
        WHEN PersonID = 1 THEN 'Apartment 101, Tower B'
        WHEN PersonID = 2 THEN 'Flat 22, Block C'
        WHEN PersonID = 3 THEN 'Villa 7, Lakeview Gardens'
        WHEN PersonID = 4 THEN 'House 15, Hillside Avenue'
        ELSE NULL 
    END;

--Create a table Employee with EMP_ID, Name, Addr, DOB, Dept, Salary, Tax, other_Deduction

CREATE TABLE Employee 
	(EMP_ID INT PRIMARY KEY, Name VARCHAR(100) NOT NULL, Addr VARCHAR(200), DOB DATE NOT NULL, Dept VARCHAR(50),
    Salary DECIMAL(10, 2),Tax DECIMAL(10, 2),other_Deduction DECIMAL(10, 2),Gross_Salary DECIMAL(10, 2),Net_Salary DECIMAL(10, 2)
);

--Insert minimum 4 records in the table

INSERT INTO Employee (EMP_ID, Name, Addr, DOB, Dept, Salary, Tax, other_Deduction)
VALUES
    (1, 'Rahul Sharma', 'Flat 101, Gokul Apartments, Mumbai', '1990-05-15', 'IT', 50000.00, 5000.00, 2000.00),
    (2, 'Priya Patel', 'Plot 22, Sunshine Colony, Delhi', '1985-09-22', 'HR', 60000.00, 6000.00, 2500.00),
    (3, 'Amit Singh', 'No. 7, Green Garden, Bangalore', '1992-12-05', 'Finance', 70000.00, 7000.00, 3000.00),
    (4, 'Sneha Kapoor', 'House 15, Lakeview Street, Kolkata', '1988-03-12', 'Marketing', 55000.00, 5500.00, 2200.00);

	select * from Employee

--Calculate Gross_Salary and update the same table as new column and Calculate Net_Salary and update the same table as new column
CREATE PROCEDURE SP_Hwork_SQL AS
BEGIN
    -- Calculate Gross_Salary and update the table
    UPDATE Employee
    SET Gross_Salary = Salary - Tax - other_Deduction;

    -- Calculate Net_Salary and update the table
    UPDATE Employee
    SET Net_Salary = Gross_Salary - Tax;

END;

---Create Index for column EMP_ID
CREATE INDEX IX_EMP_ID ON Employee (EMP_ID);

EXEC SP_Hwork_SQL;