CREATE EXTENSION postgis

CREATE TABLE drogi(id INTEGER, name VARCHAR(50), geom GEOMETRY)
CREATE TABLE budynki(id INTEGER, name VARCHAR(50), height INTEGER, geom GEOMETRY)
CREATE TABLE pktinfo(id INTEGER, name VARCHAR(50), liczprac INTEGER, geom GEOMETRY)

INSERT INTO drogi VALUES(1, 'roadX', ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)',0))
INSERT INTO drogi VALUES(2, 'roadY', ST_GeomFromText('LINESTRING(7.5 10.5, 7.5 0)',0))

INSERT INTO budynki VALUES(1, 'BuildingA', 30, ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))',0))
INSERT INTO budynki VALUES(2, 'BuildingB', 20, ST_GeomFromText('POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))',0))
INSERT INTO budynki VALUES(3, 'BuildingC', 30, ST_GeomFromText('POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))',0))
INSERT INTO budynki VALUES(4, 'BuildingD', 30, ST_GeomFromText('POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))',0))
INSERT INTO budynki VALUES(5, 'BuildingF', 10, ST_GeomFromText('POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))',0))

INSERT INTO pktinfo VALUES(1, 'G', 2, ST_GeomFromText('POINT(1 3.5)',0))
INSERT INTO pktinfo VALUES(2, 'H', 3, ST_GeomFromText('POINT(5.5 1.5)',0))
INSERT INTO pktinfo VALUES(3, 'I', 11,ST_GeomFromText('POINT(9.5 6)',0))
INSERT INTO pktinfo VALUES(4, 'J', 4, ST_GeomFromText('POINT(6.5 6)',0))
INSERT INTO pktinfo VALUES(5, 'K', 1, ST_GeomFromText('POINT(6 9.5)',0))


SELECT *, ST_AsText(geom) AS WKT FROM drogi;
SELECT *, ST_AsText(geom) AS WKT FROM budynki;
SELECT *, ST_AsText(geom) AS WKT FROM pktinfo;

SELECT * FROM budynki;
-- 1.
SELECT SUM(ST_Length(geom)) FROM drogi
-- 2.
SELECT ST_AsText(geom) as WKT, ST_Perimeter(geom) AS obwod, ST_Area(geom) AS powierzchnia FROM budynki
WHERE name LIKE 'BuildingA';
-- 3.
SELECT name, ST_Area(geom)
FROM budynki 
ORDER BY name;

-- 4.
SELECT  name, ST_Perimeter(geom) AS obwod
FROM budynki 
ORDER BY ST_Perimeter(geom) DESC
LIMIT 2;

-- 5. 
SELECT ST_Distance(budynki.geom, pktinfo.geom)
FROM pktinfo, budynki
WHERE budynki.name LIKE 'BuildingC' AND pktinfo.name LIKE 'G'

--6. 
SELECT ST_Area(ST_Difference((SELECT geom FROM Budynki WHERE name LIKE'BuildingC'),
	ST_Buffer(d.geom, 0.5))) FROM Budynki d WHERE d.name LIKE'BuildingB'

	
-- 7.
SELECT budynki.name, ST_Y(ST_Centroid(budynki.geom))
FROM budynki
WHERE  ST_Y(ST_Centroid(budynki.geom)) > ST_Y('POINT (0 4.5)')  
	
-- 8.
SELECT ST_Area(ST_SymDifference(geom, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))',0)))
	FROM budynki
	WHERE name LIKE 'BuildingC'
	
