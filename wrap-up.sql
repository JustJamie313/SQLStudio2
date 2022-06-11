SELECT first_name,last_name,genres FROM patron INNER JOIN genre ON genre.genre_id IN (
	SELECT book.genre_id FROM book WHERE available = false AND book.book_id IN (
		SELECT loan.book_id FROM loan WHERE loan.patron_id = patron.patron_id
    )
) WHERE patron.loan_id IS NOT NULL;