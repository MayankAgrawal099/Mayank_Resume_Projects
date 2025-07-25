# Question Set 1 - Easy
# 1. Who is the senior most employee based on job title?

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;


# 2. Which countries have the most Invoices?

SELECT billing_country, COUNT(*) AS C
FROM invoice
GROUP BY billing_country
ORDER BY C DESC;


# 3. What are top 3 values of total invoice?

SELECT total FROM invoice
ORDER BY total DESC
LIMIT 3;


# 4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

SELECT billing_city, SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc;


# 5. Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total_spent
FROM customer 
JOIN invoice on  invoice.customer_id = customer.customer_id 
GROUP BY customer.customer_id
ORDER BY total_spent DESC
LIMIT 1;


# Question Set 2 - Moderate
# 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A

SELECT DISTINCT customer.email, customer.first_name, customer.last_name
From customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
    JOIN genre ON genre.genre_id = track.genre_id
    WHERE genre.name LIKE 'ROCK'
)    
ORDER BY email; 

# 2. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT artist.artist_id, artist.name, count(artist.artist_id) AS total_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY artist.artist_id
ORDER BY total_songs DESC
LIMIT 10;


# 3. Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

SELECT name, milliseconds 
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_song_length
    FROM track)
ORDER BY milliseconds DESC;



