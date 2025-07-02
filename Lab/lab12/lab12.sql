CREATE TABLE finals AS
  SELECT "RSF" AS hall, "61A" as course UNION
  SELECT "Wheeler"    , "61A"           UNION
  SELECT "Pimentel"   , "61A"           UNION
  SELECT "Li Ka Shing", "61A"           UNION
  SELECT "Stanley"    , "61A"           UNION
  SELECT "RSF"        , "61B"           UNION
  SELECT "Wheeler"    , "61B"           UNION
  SELECT "Morgan"     , "61B"           UNION
  SELECT "Wheeler"    , "61C"           UNION
  SELECT "Pimentel"   , "61C"           UNION
  SELECT "Soda 310"   , "61C"           UNION
  SELECT "Soda 306"   , "10"            UNION
  SELECT "RSF"        , "70";

CREATE TABLE sizes AS
  SELECT "RSF" AS room, 900 as seats    UNION
  SELECT "Wheeler"    , 700             UNION
  SELECT "Pimentel"   , 500             UNION
  SELECT "Li Ka Shing", 300             UNION
  SELECT "Stanley"    , 300             UNION
  SELECT "Morgan"     , 100             UNION
  SELECT "Soda 306"   , 80              UNION
  SELECT "Soda 310"   , 40              UNION
  SELECT "Soda 320"   , 30;

CREATE TABLE sharing AS
  SELECT a.course ,count(distinct a.hall)  from  finals as a, finals as b where a.hall=b.hall and a.course<> b.course group by a.course;

CREATE TABLE pairs AS
  SELECT  a.room||" and " ||b.room||" together have "||(a.seats+b.seats)||" seats"         as rooms  from  sizes as a, sizes as b where a.room<b.room and (a.seats+b.seats)>=1000 order by (a.seats+b.seats)  DESC;

CREATE TABLE big AS
  SELECT  course   as course  from finals,sizes where room=hall  group by course having sum(seats)>=1000;  

CREATE TABLE remaining AS
  SELECT  course as course,      sum(seats)-max(seats ) as remaining    from finals ,sizes where room =hall group by course ;

