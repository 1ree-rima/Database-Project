
-- Create the database
CREATE DATABASE IF NOT EXISTS UniversityLibrary;
USE UniversityLibrary;

-- Table: Students (Members)
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    EnrollmentDate DATE NOT NULL
);

-- Table: Authors
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL
);

-- Table: Categories
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    PublishedYear YEAR,
    CategoryID INT,
    TotalCopies INT NOT NULL CHECK (TotalCopies >= 0),
    AvailableCopies INT NOT NULL CHECK (AvailableCopies >= 0),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Table: BookAuthors (Many-to-Many relationship between Books and Authors)
CREATE TABLE BookAuthors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Table: Loans (Borrowing Activity)
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    StudentID INT NOT NULL,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status ENUM('Borrowed', 'Returned', 'Overdue') DEFAULT 'Borrowed',
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
