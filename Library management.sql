-- create table Publisher
create table Publishers
(
PublisherID nvarchar(50) not null Primary Key ,
PublisherName nvarchar(50),
Address nvarchar(50), 
);
 
-- Create table Librarian
create table Librarian 
(
LibrarianID nvarchar(50) not null PRIMARY KEY,
LibrarianName char(50),
Availability char(50)
);
 
-- Create table Copies
create table Copiess 
(
BookID nvarchar(50) not null Primary Key,
CopiesNumber int,
PublisherID nvarchar(50) foreign key references Publishers(PublisherID),
CopiesLeft int,
Title varchar(50),
ISBN nvarchar(50),
);
 
-- Create table Books
create table Books 
(  
Author varchar (50) not null primary key,
Description varchar(200),
Genre varchar(50),
Loanability varchar(50),
Category varchar(50),
Title varchar(100),
PublisherID nvarchar(50) foreign key references Publishers(PublisherID),
BookID nvarchar(50) foreign key references Copiess(BookID),
);
 
-- Create table Members
create table Members 
(
MembersID nvarchar(50) not null Primary Key,
Country nvarchar(50),
MembersName nvarchar(50),
BooksBorrowed nvarchar(50),
Activeness nvarchar(50),
);
 
 -- Create table Fines
create table Fines 
(
OverDueDays int,
FineAmount decimal(10,2),
MembersID nvarchar(50) FOREIGN KEY REFERENCES Members(MembersID),
);
 
 
-- Create table Loan
create table Loan
(
LoanID nvarchar(50) not null primary key,
CheckoutDate date,
ReturnDate date,
Periods int,
Reservation nvarchar(50),
BookID nvarchar(50) foreign key references Copiess(BookID),
LibrarianID nvarchar(50) foreign key references Librarian(LibrarianID),
MembersID nvarchar(50) foreign key references Members(MembersID),
Title varchar(50),
Category varchar(50)
);
 
-- Create table Enrollment
create table Enrollment
(
BookID nvarchar(50) not null primary key,
LoanID nvarchar(50) foreign key references Loan(LoanID)
);
 
-- values for Publisher
insert into Publishers(PublisherID, PublisherName, Address) values
('P01','Hachette Book Group','Kuala Lumpur'),
('P02','HarperCollins','Johor'),
('P03','Macmillan','Pahang'),
('P04','Penguin Random House','Sabah'),
('P05','Simon and Schuster','Selangor'),
('P06','Pelangi','Perak');
 
-- values for Librarian
insert into Librarian(LibrarianID, LibrarianName, Availability) values 
('L01','Lee Kah Meng','Yes'),
('L02','Mohammed Taufik','Yes'),
('L03','Malik James','Yes'),
('L04','Yap Zhi Qian','No'),
('L05','Dugesh A/L Praveen','Yes'),
('L06','Siti Nur Khadijah','Yes'),
('L07','Sam Lee','Yes'),
('L08','Lai Jia Hao','No'),
('L09','Sygrak Omalagrak','Yes');
 
-- values for Copies
insert into Copiess(BookID, CopiesNumber, PublisherID, CopiesLeft, Title,ISBN) values 
('B01','1','P01','1','House of Secrets','9780062192462'),
('B02','1','P02','0','Mathematics for Computer Science','9783642298417'),
('B03','1','P02','1','Mathematics for Computer Science','9783642298417'),
('B04','1','P02','0','Python programming language book','9781491946008'),
('B05','1','P02','0','Python programming language book','9781491946008'),
('B06','1','P02','0','C programming language book','9781718501041'),
('B07','1','P06','1','Knowledge Encyclopedia','9780241287316'),
('B08','1','P05','1','Positivity Journal(Positive thoughts)','9781072565642'),
('B09','1','P05','1','Amazing Rocket Science','9780347652123'),
('B10','1','P03','1','Computer Systems Architecture','9780321340795'),
('B11','1','P03','0','The Martian','9781785031137');
 
-- values for Books
insert into Books(Author, Description, Genre, Loanability, Category, Title, PublisherID, BookID) values 
('Chirs Columbus','Three children were suddenly trapped in a novel and they found a lot of strange things. They went crazy adventure and want to find they way out.',
'Novel','Yes','Green','House of Secrets','P01','B01'),
('Gordon J. Pace','Computer science mathematics','Maths','Yes','Yellow','Mathematics for Computer Science','P02','B02'),
('Luciano Ramalho','Python programming language book','Programming language','No','Yellow','Fluent Python','P02','B04'),
('Robert C. Seacord','C programming language book','Programming language','No','Yellow','Effective C: An Introduction to Professional C Programming',
'P02','B06'),
('Rahim Abu Bakar','Reference book for children that contains of thousands interesting facts.','Reference Book','Not for loan','Red','Knowledge Encyclopedia',
'P06','B07'),
('Nancy Lee Brushett','Recipe For Positive Thoughts and Feel Confident, High Self Esteem, Motivational and Love Yourself.','Journal','Not for loan','Red',
'Positivity Journal(Positive thoughts)','P05','B08'),
('Kevin Lim','Students project about building small size rocket without flammable fuel.','Student Project','Not for loan','Red','Amazing Rocket Science',
'P05','B09'),
('Aharon Yadin','Computer Systems Architecture provides IT professionals and students with the necessary understanding of computer hardware.','Computer Science',
'Yes','Yellow','Computer Systems Architecture','P03','B10'),
('Andy Weir','The story follows an American astronaut, Mark Watney, as he becomes stranded alone on Mars in 2035 and must improvise in order to survive',
'Science Fiction','No','Green','The Martian','P04','B11');
 
-- values for Members
insert into Members(MembersID,Country,MembersName,BooksBorrowed,Activeness) values
('M01','Bangladesh','Raiyan','11','Active'),
('M02','Malaysia','Cheng Hui Yin','3','Inactive'),
('M03','Egypt','Abdul Ajib','4','Inactive'),
('M04','Singapore','Kaylee','3','Inactive'),
('M05','China','Lee Kah Hui','16','Active'),
('M06','Indonesia','Ramdin','10','Active'),
('M07','Malaysia','Muthu A/L Musan','1','Inactive');
 
-- values for Fines
-- Fines for 0.50 per day
insert into Fines(OverDueDays,FineAmount,MembersID) values
('5','2.50','M03'),
('43','21.50','M07'),
('82','41.00','M04');
 
 
-- values for Loan
-- reservation is for next person who wants to borrow the book
-- Loan periods for different colour-tagged are: green(90days), yellow(30days), red(Not for loan)
insert into Loan(LoanID, CheckoutDate, ReturnDate, Periods, Reservation, BookID, LibrarianID, MembersID,Title,Category) values 
('LN01','3 March 2023','15 March 2023','12',NULL,'B02','L02','M01','Mathematics for Computer Science','Yellow'),
('LN02','1 April 2023','6 May 2023','35',NULL,'B04','L01','M03','Python programming language book','Yellow'),
('LN03','5 April 2023','19 April 2023','19','M01','B05','L01','M05','Python programming language book','Yellow'),
('LN04','21 January 2023','4 April 2023','73',NULL,'B06','L03','M07','C programming language book','Yellow'),
('LN05','11 December 2022','1 June 2023','172','M06','B11','L08','M04','The Martian','Green');
 
-- values for Enrollment
insert into Enrollment(BookID, LoanID) values 
('B01',NULL),
('B02','LN01'),
('B03',NULL),
('B04','LN02'),
('B05','LN03'),
('B06','LN04'),
('B07',NULL),
('B08',NULL),
('B09',NULL),
('B10',NULL),
('B11','LN05');
 

----Q(i) What is the total count of books available for loan in each category, considering only those books labeled as loanable?
SELECT Category, COUNT(*) AS TotalBooks
FROM Books
WHERE Loanability = 'Yes'
GROUP BY Category
ORDER BY TotalBooks DESC;
 
---Q(ii) What is the genre of the most frequently occurring book, and how many books are available in that genre?
SELECT TOP 1 Genre, COUNT(*) AS BookCount
FROM Books
GROUP BY Genre
ORDER BY BookCount DESC;
 
---Q(iii) Which members have borrowed more than two books from the library?
SELECT MembersID, MembersName
FROM Members
WHERE BooksBorrowed > 2;
 
---Q(iv) Which members have borrowed books but failed to return them by the due date?
SELECT DISTINCT Members.MembersID, Members.MembersName
FROM Members
JOIN Loan ON Members.MembersID = Loan.MembersID
WHERE Loan.ReturnDate < GETDATE() 
 
---Q(v) Which books have been loaned the most, and how many times has each book been loaned?

SELECT Books.Title, COUNT(*) AS LoanCount 
FROM Loan 
JOIN Books ON Loan.BookID = Books.BookID 
GROUP BY Books.Title ORDER BY LoanCount DESC; 
 
---Q(vi) Which books have reservations placed on them, and what are their titles, sorted in ascending order?
SELECT Title
FROM Loan
WHERE Reservation is not NULL ORDER BY Title ASC;