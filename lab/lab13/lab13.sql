.read data.sql


CREATE TABLE average_prices AS
  SELECT category, avg(MSRP) as average_price FROM products group by category;


CREATE TABLE lowest_prices AS
  SELECT store, item, min(price) FROM inventory GROUP BY item ;

CREATE TABLE best_deal AS
  SELECT name as best, min(MSRP/rating) from products GROUP BY category;

CREATE TABLE shopping_list AS
  SELECT best,store FROM best_deal as a, lowest_prices as b WHERE a.best = b.item;


CREATE TABLE total_bandwidth AS
  SELECT sum(b.Mbs) FROM shopping_list as a, stores as b WHERE a.store = b.store;

