SELECT title,isbn FROM book WHERE genre_id IN (SELECT genre_id FROM genre WHERE genres = "Mystery");
SELECT title,first_name,last_name FROM book INNER JOIN (SELECT author_id,first_name,last_name FROM author WHERE deathday IS NULL) AS living_authors ON book.author_id=living_authors.author_id;
