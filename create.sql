CREATE TABLE book (
	book_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    author_id INT,
    title VARCHAR(255),
    isbn INT,
    available BOOL,
    genre_id INT
);
CREATE TABLE author(
	author_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    birthday DATE,
    deathday DATE
);
CREATE TABLE patron(
	patron_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    loan_id INT
);
CREATE TABLE reference_books(
	reference_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    edition INT,
    book_id INT,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON UPDATE SET NULL ON DELETE SET NULL
);
INSERT INTO reference_books(edition, book_id) VALUES(5,32);
CREATE TABLE genre(
	genre_id INTEGER PRIMARY KEY,
    genres VARCHAR(100)
);
CREATE TABLE loan(
	loan_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    patron_id INT,
    date_out DATE,
    date_in DATE,
	book_id INT,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON UPDATE SET NULL ON DELETE SET NULL
);
DELIMITER //
CREATE PROCEDURE checkOut(IN patronID INT, IN bookID INT)
BEGIN
	INSERT INTO loan(patron_id,date_out,book_id)
    VALUES (patronID,CURDATE(),bookID);
    UPDATE book SET available=false WHERE book_id=bookID;
    UPDATE patron INNER JOIN loan SET patron.loan_id = (SELECT MAX(loan_id) FROM loan WHERE patron_id=patronID AND date_in IS NULL) WHERE patron.patron_id=patronID;
END//
CREATE PROCEDURE checkIn(IN patronID INT, IN bookID INT)
BEGIN
	UPDATE loan SET date_in = CURDATE();
    UPDATE book SET available=true WHERE book_id=bookID;
    UPDATE patron SET patron.loan_id = NULL WHERE patron.patron_id=patronID;
END//
DELIMITER ;