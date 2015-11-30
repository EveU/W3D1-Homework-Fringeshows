-- ############ Section 1 ############

-- Revision of concepts that we've learnt in SQL today

-- 1. Select the names of all users.
-- SELECT name FROM users;
--        name       
-- ------------------
--  Rick Henri
--  Jay Chetty
--  Keith Douglas
--  Callum Dougan
--  Andrew Insley
--  Daniel Gillespie
--  Bethany Fraser
--  Nick Ridell
--  Evelyn Utterson
--  Sky Su
--  Nicholas Hill
--  Michael McLeod
--  Callum Hogg
--  Chris Sloan
--  Gary Carmichael
--  Oscar Brooks
--  Ross Galloway
--  Paul MacLean
--  Stuart Ramsay
--  Peter Forbes
--  Euan Walls
--  Aine Dunphy
-- (22 rows)

-- 2. Select the names of all shows that cost less than £15.
-- SELECT name FROM shows WHERE price < 15;
--              name             
-- ------------------------------
--  Le Haggis
--  Paul Dabek Mischief 
--  Best of Burlesque
--  Two become One
--  Urinetown
--  Two girls, one cup of comedy
-- (6 rows)

-- 3. Insert a user with the name "Val Gibson" into the users table.
-- INSERT INTO users (name) VALUES ('Val Gibson');
-- INSERT 0 1

-- 4. Select the id of the user with your name.
-- SELECT id FROM users WHERE name = 'Evelyn Utterson';
--  id 
-- ----
--   9
-- (1 row)

-- 5. Insert a record that Val Gibson wants to attend the show "Two girls, one cup of comedy".
-- SELECT id FROM users WHERE name = 'Val Gibson'; (23)

-- SELECT id FROM shows WHERE name = 'Two girls, one cup of comedy'; (12)

-- INSERT INTO shows_users (show_id, user_id) VALUES (12, 23);
-- INSERT 0 1

-- 6. Updates the name of the "Val Gibson" user to be "Valerie Gibson".
-- UPDATE users SET name = 'Valerie Gibson' WHERE id = 23;
-- UPDATE 1

-- 7. Deletes the user with the name 'Valerie Gibson'.
-- DELETE FROM users WHERE name = 'Valerie Gibson';
-- DELETE 1

-- 8. Deletes the shows for the user you just deleted.
-- DELETE FROM shows_users WHERE user_id = 23;
-- DELETE 1

-- ############ Section 2 ############

-- This section involves more complex queries. You will need to go and find out about aggregate funcions in SQL to answer some of the next questions.

-- 1. Select the names and prices of all shows, ordered by price in ascending order.
-- SELECT name,price FROM shows ORDER BY price;
--                    name                    | price 
-- -------------------------------------------+-------
--  Two girls, one cup of comedy              |  6.00
--  Best of Burlesque                         |  7.99
--  Two become One                            |  8.50
--  Urinetown                                 |  8.50
--  Paul Dabek Mischief                       | 12.99
--  Le Haggis                                 | 12.99
--  Joe Stilgoe: Songs on Film â€“ The Sequel | 16.50
--  Game of Thrones - The Musical             | 16.50
--  Shitfaced Shakespeare                     | 16.50
--  Aaabeduation â€“ A Magic Show             | 17.99
--  Camille O'Sullivan                        | 17.99
--  Balletronics                              | 32.00
--  Edinburgh Royal Tattoo                    | 32.99
-- (13 rows)

-- 2. Select the average price of all shows.
-- SELECT AVG(price) FROM shows;
--          avg         
-- ---------------------
--  15.9569230769230769
-- (1 row)

-- 3. Select the price of the least expensive show.
-- SELECT MIN(price) FROM shows;
--  min  
-- ------
--  6.00
-- (1 row)

-- 4. Select the sum of the price of all shows.
-- SELECT SUM(price) FROM shows;
--   sum   
-- --------
--  207.44
-- (1 row)

-- 5. Select the sum of the price of all shows whose prices is less than £20.
-- SELECT SUM(price) FROM shows WHERE price < 20;
--   sum   
-- --------
--  142.45
-- (1 row)

-- 6. Select the name and price of the most expensive show.
-- SELECT name, price FROM shows WHERE price = (SELECT MAX(price) FROM shows);
--           name          | price 
-- ------------------------+-------
--  Edinburgh Royal Tattoo | 32.99
-- (1 row)

-- 7. Select the name and price of the second from cheapest show.
-- SELECT name, price FROM shows ORDER BY price LIMIT 1 OFFSET 1;
--        name        | price 
-- -------------------+-------
--  Best of Burlesque |  7.99
-- (1 row)

-- 8. Select the names of all users whose names start with the letter "N".
-- SELECT name FROM users WHERE name LIKE 'N%';
--      name      
-- ---------------
--  Nicholas Hill
--  Nick Riddell
-- (2 rows)

-- 9. Select the names of users whose names contain "mi".
-- SELECT name FROM users WHERE name LIKE '%mi%';
--       name       
-- -----------------
--  Gary Carmichael
-- (1 row)

-- SELECT name FROM users WHERE name LIKE '%mi%' OR name LIKE '%Mi%';
--       name       
-- -----------------
--  Michael McLeod
--  Gary Carmichael
-- (2 rows)

-- ############ Section 3 ############

-- The following questions can be answered by using nested SQL statements but ideally you should learn about JOIN clauses to answer them.

-- 1. Select the time for the Edinburgh Royal Tattoo.
-- SELECT time FROM times INNER JOIN shows ON times.show_id = shows.id WHERE shows.name = 'Edinburgh Royal Tattoo';
--  time  
-- -------
--  22:00
-- (1 row)

-- 2. Select the number of users who want to see "Shitfaced Shakespeare".
-- SELECT COUNT(user_id) FROM shows_users INNER JOIN shows ON shows_users.show_id = shows.id WHERE shows.name = 'Shitfaced Shakespeare';
--  count 
-- -------
--      7
-- (1 row)

-- 3. Select all of the user names and the count of shows they're going to see.
-- SELECT name, COUNT(shows_users.show_id) FROM users INNER JOIN shows_users ON shows_users.user_id = users.id GROUP BY users.id;
--        name       | count 
-- ------------------+-------
--  Nick Riddell     |     5
--  Nicholas Hill    |     5
--  Oscar Brooks     |     4
--  Keith Douglas    |     6
--  Chris Sloan      |     4
--  Ross Galloway    |     5
--  Gary Carmichael  |     4
--  Callum Dougan    |     4
--  Michael McLeod   |     6
--  Rick Henri       |     5
--  Sky Su           |     5
--  Callum Hogg      |     4
--  Evelyn Utterson  |     7
--  Daniel Gillespie |     4
--  Jay Chetty       |     5
--  Andrew Insley    |     4
--  Bethany Fraser   |     4
-- (17 rows)

-- 4. SELECT all users who are going to a show at 17:15.
-- SELECT users.name, shows.name, times.time FROM users INNER JOIN shows_users ON users.id = shows_users.user_id INNER JOIN times ON shows_users.show_id = times.show_id INNER JOIN shows ON shows.id = shows_users.show_id WHERE times.time = '17:15';
--       name       |                   name                    | time  
-- -----------------+-------------------------------------------+-------
--  Rick Henri      | Camille O'Sullivan                        | 17:15
--  Keith Douglas   | Camille O'Sullivan                        | 17:15
--  Andrew Insley   | Camille O'Sullivan                        | 17:15
--  Nick Riddell    | Camille O'Sullivan                        | 17:15
--  Evelyn Utterson | Camille O'Sullivan                        | 17:15
--  Callum Hogg     | Camille O'Sullivan                        | 17:15
--  Gary Carmichael | Camille O'Sullivan                        | 17:15
--  Nicholas Hill   | Joe Stilgoe: Songs on Film â€“ The Sequel | 17:15
--  Michael McLeod  | Joe Stilgoe: Songs on Film â€“ The Sequel | 17:15
--  Callum Hogg     | Joe Stilgoe: Songs on Film â€“ The Sequel | 17:15
--  Oscar Brooks    | Joe Stilgoe: Songs on Film â€“ The Sequel | 17:15
--  Ross Galloway   | Joe Stilgoe: Songs on Film â€“ The Sequel | 17:15
-- (12 rows)



-- ############ Hints ############

-- As with anything, if you get stuck, move on, then go back if you have time.
-- Don't spend all night on it!
-- Use resources online to solve harder ones - there are solutions to these questions that work with what we've learnt today, but other tools exist in SQL that could make the queries 'better' or 'easier'.