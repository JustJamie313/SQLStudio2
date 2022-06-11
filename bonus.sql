SELECT genres,COUNT(*) FROM book LEFT JOIN genre ON genre.genre_id = book.genre_id GROUP BY book.genre_id;
ALTER TABLE book ADD is_reference BOOL;

UPDATE book SET is_reference=TRUE,available=false WHERE book.book_id IN (SELECT reference_books.book_id FROM reference_books);


