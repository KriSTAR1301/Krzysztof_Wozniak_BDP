CREATE EXTENSION postgis; 


--zad. 4
SELECT COUNT(popp)
FROM popp, majrivers
WHERE ST_Distance(popp.geom, majrivers.geom) < 1000 AND popp.f_codedesc = 'Building'

SELECT popp.* INTO tableB
FROM popp, majrivers
WHERE ST_Distance(popp.geom, majrivers.geom) < 1000 AND popp.f_codedesc = 'Building'

SELECT * FROM tableB

--zad. 5
 
 
SELECT name, geom, elev INTO airportsNew 
FROM airports

SELECT * FROM airportsNew
--a
SELECT name AS lotnisko_na_wschod, ST_X(geom) 
FROM airportsNew
ORDER BY ST_X(geom) DESC
LIMIT 1;

SELECT name AS lotnisko_na_zachod, ST_X(geom) 
FROM airportsNew
ORDER BY ST_X(geom) ASC
LIMIT 1;

--b
INSERT INTO airportsNew(name,geom,elev) VALUES
(
	'airportB',
	(SELECT ST_Centroid(
		ST_ShortestLine(
			(SELECT geom FROM airportsNew WHERE name LIKE 'ANNETTE ISLAND'), 
			(SELECT geom FROM airportsNew WHERE name LIKE 'ATKA')))),
	75000);

SELECT * FROM airportsNew

--zad. 6
SELECT ST_Area(ST_Buffer(ST_ShortestLine(lakes.geom, airportsNew.geom), 1000))
	FROM lakes, airportsNew
	WHERE lakes.names = 'Iliamna Lake' AND airportsNew.name = 'AMBLER'

--zad.7
SELECT SUM(ST_Area(trees.geom)), trees.vegdesc
	FROM trees, tundra, swamp
	WHERE ST_Within(trees.geom, tundra.geom) OR ST_Within(trees.geom, swamp.geom)
	GROUP BY trees.vegdesc
