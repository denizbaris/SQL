



CREATE DATABASE LibraryDatabase;

USE LibraryDatabase


CREATE SCHEMA Book;
---
CREATE SCHEMA Person;




--create Book.Author table

CREATE TABLE [Book].[Author](
	[Author_ID] [int],
	[Author_FirstName] [nvarchar](50) Not NULL,
	[Author_LastName] [nvarchar](50) Not NULL
	);



	
--create Publisher Table

CREATE TABLE [Book].[Publisher](
	[Publisher_ID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Publisher_Name] [nvarchar](100) NULL
	);



--create Book.Book table
CREATE TABLE [Book].[Book](
	[Book_ID] [int] PRIMARY KEY NOT NULL,
	[Book_Name] [nvarchar](50) NOT NULL,
	Author_ID INT NOT NULL,
	Publisher_ID INT NOT NULL
	);



--create Person.Person table

CREATE TABLE [Person].[Person](
	[SSN] [bigint] PRIMARY KEY NOT NULL,
	[Person_FirstName] [nvarchar](50) NULL,
	[Person_LastName] [nvarchar](50) NULL
	);


--cretae Person.Person_Mail table

CREATE TABLE [Person].[Person_Mail](
	[Mail_ID] INT PRIMARY KEY IDENTITY (1,1),
	[Mail] NVARCHAR(MAX) NOT NULL,
	[SSN] BIGINT UNIQUE NOT NULL	
	);


	--cretae Person.Person_Phone table

CREATE TABLE [Person].[Person_Phone](
	[Phone_Number] INT PRIMARY KEY NOT NULL,
	[SSN] [bigint] NOT NULL	
	);



--create Person.Loan table

CREATE TABLE [Person].[Loan](
	[SSN] BIGINT NOT NULL,
	[Book_ID] INT NOT NULL,
	PRIMARY KEY ([SSN], [Book_ID])
	);



--INSERT 



INSERT INTO Person.Person (SSN, Person_FirstName, Person_LastName) VALUES (75056659595,'Zehra', 'Tekin')

INSERT Person.Person (SSN, Person_FirstName, Person_LastName) VALUES (75056659595,'Zehra', 'Tekin')


INSERT INTO Person.Person (SSN, Person_FirstName) VALUES (889623212466,'Kerem', 'ATLI')

INSERT INTO Person.Person (SSN, Person_FirstName) VALUES (889623212466,'Kerem')


INSERT INTO Person.Person VALUES (889623212886,'Kerem', NULL)


INSERT Person.Person VALUES (88232556264,'Metin','Sakin')
INSERT Person.Person VALUES (35532888963,'Ali','Tekin')


INSERT INTO Person.Person_Mail (Mail, SSN) 
VALUES ('zehtek@gmail.com', 75056659595),
	   ('meyet@gmail.com', 15078893526),
	   ('metsak@gmail.com', 35532558963)



SELECT * FROM Person.Person_Mail 



--SELECT INTO


SELECT * FROM Person.Person_2


select * into Person.Person_2 from Person.Person


---INSERT INTO SELECT

SELECT * FROM Person.Person_2


INSERT Person.Person_2 (SSN, Person_FirstName, Person_LastName)

SELECT * 
FROM Person.Person 
where Person_FirstName like 'A%'



SELECT * FROM Book.Publisher

--Insert default values

INSERT Book.Publisher
DEFAULT VALUES






UPDATE Person.Person
SET Person_LastName = B.Person_LastName
FROM Person.Person A, Person.Person_2 B
WHERE A.SSN = B.SSN and
A.SSN = 889623212886




SELECT * FROM Person.Person_2
SELECT * FROM Person.Person
UPDATE Person.Person_2 SET Person_LastName = 'DEFAULT'
UPDATE Person.Person_2 SET Person_LastName = 'Atıcı' WHERE SSN = 889623212886


UPDATE Person.Person
SET Person_LastName = B.Person_LastName
FROM Person.Person A, Person.Person_2 B
WHERE A.SSN = B.SSN
AND	A.SSN = 889623212886


UPDATE Person.Person SET Person_LastName = (SELECT Person_LastName FROM Person.Person_2 WHERE SSN = 889623212466) WHERE SSN = 889623212466

SELECT * FROM Person.Person


--DELETE
insert Book.Publisher values ('İş Bankası Kültür Yayıncılık'), ('Can Yayıncılık'), ('İletişim Yayıncılık')
SELECT * FROM Book.Publisher
DELETE FROM Book.Publisher WHERE Publisher_Name IS NULL
DELETE FROM Book.Publisher
insert Book.Publisher values ('İLETİŞİM')
---
DROP TABLE Person.Person_2;--Artık ihtiyacımız yok.
TRUNCATE TABLE Person.Person_Mail;
TRUNCATE TABLE Person.Person;
TRUNCATE TABLE Book.Publisher;



--Author
ALTER TABLE Book.Author ADD CONSTRAINT pk_author PRIMARY KEY (Author_ID)
ALTER TABLE Book.Author ALTER COLUMN Author_ID INT NOT NULL
---Book
ALTER TABLE Book.Book ADD CONSTRAINT FK_Author FOREIGN KEY (Author_ID) REFERENCES Book.Author (Author_ID)
ALTER TABLE Book.Book ADD CONSTRAINT FK_Publisher FOREIGN KEY (Publisher_ID) REFERENCES Book.Publisher (Publisher_ID)
--person.person_mail
Alter table Person.Person_Mail add constraint FK_Person4 Foreign key (SSN) References Person.Person(SSN)





-----17.11.2021 DBMD Session 4

CREATE PROCEDURE sp_sample1
AS
BEGIN

   SELECT 'HELLO THERE' col1

END



--------------------------------------------------------

CREATE TABLE ORDER_TBL
(
ORDER_ID TINYINT NOT NULL,
CUSTOMER_ID TINYINT NOT NULL,
CUSTOMER_NAME VARCHAR(50),
ORDER_DATE DATE,
EST_DELIVERY_DATE DATE--estimated delivery date
);
INSERT ORDER_TBL VALUES (1, 1, 'Adam', GETDATE()-10, GETDATE()-5 ),
						(2, 2, 'Smith',GETDATE()-8, GETDATE()-4 ),
						(3, 3, 'John',GETDATE()-5, GETDATE()-2 ),
						(4, 4, 'Jack',GETDATE()-3, GETDATE()+1 ),
						(5, 5, 'Owen',GETDATE()-2, GETDATE()+3 ),
						(6, 6, 'Mike',GETDATE(), GETDATE()+5 ),
						(7, 7, 'Rafael',GETDATE(), GETDATE()+5 ),
						(8, 8, 'Johnson',GETDATE(), GETDATE()+5 )



SELECT * FROM ORDER_TBL

CREATE TABLE ORDER_DELIVERY
(
ORDER_ID TINYINT NOT NULL,
DELIVERY_DATE DATE -- tamamlanan delivery date
);
SET NOCOUNT ON
INSERT ORDER_DELIVERY VALUES (1, GETDATE()-6 ),
				(2, GETDATE()-2 ),
				(3, GETDATE()-2 ),
				(4, GETDATE() ),
				(5, GETDATE()+2 ),
				(6, GETDATE()+3 ),
				(7, GETDATE()+5 ),
				(8, GETDATE()+5 )


SELECT * FROM ORDER_DELIVERY

----------
CREATE PROC sp_cnt_order AS
BEGIN
	SELECT COUNT (ORDER_ID) TOTAL ORDER FROM ORDER_TBL





-------IF - ELSE 
DECLARE @CUST INT 

SET @CUST = 3

IF @CUST = 3
	BEGIN 
		SELECT * FROM ORDER_TBL WHERE CUSTOMER_ID = @CUST
	END
ELSE IF @CUST = 4
	BEGIN
		SELECT * FROM ORDER_TBL WHERE CUSTOMER_ID = @CUST
	END
ELSE
	PRINT('The number is not equal to 3')

SELECT * 
FROM ORDER_TBL
WHERE CUSTOMER_ID = 3



---WHILE


DECLARE @NUM INT = 1

WHILE @NUM < 50
	BEGIN
		SELECT @NUM

		SET @NUM += 1
	END



