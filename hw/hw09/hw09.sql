CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs as a, sizes as b WHERE b.min<a.height and b.max>=a.height;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child as name FROM parents as a, dogs as b WHERE a.parent = b.name ORDER BY -b.height;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  select a.child as k1, b.child as k2, c.size as size
		 from parents as a,parents as b, size_of_dogs as c, size_of_dogs as d
		 where a.parent=b.parent and a.child<b.child and a.child=c.name and b.child=d.name and c.size=d.size;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, "||k1||" plus "||k2||" have the same size: "||size FROM siblings;

