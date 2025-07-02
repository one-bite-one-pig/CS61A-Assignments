CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child AS chill FROM parents,dogs AS pup, dogs AS father WHERE pup.name=child  AND father.name =parent Order by -father.height ;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name,size from dogs,sizes where   height>min and height<=max;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT little.child AS small,big.child AS large FROM parents AS little, parents AS big,dogs AS l,dogs AS b where little.parent=big.parent and l.name< b.name and l.name=little.child and b.name=big.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, "||small||" and "||large||", have the same size: "||little.size from siblings,size_of_dogs AS little, size_of_dogs AS big where small=little.name and large=big.name and little.size=big.size
  ;
s

-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur,max(height)-min(height) from dogs group by fur having avg(height)*1.3>=max(height) and avg(height)*0.7 <=min(height);

