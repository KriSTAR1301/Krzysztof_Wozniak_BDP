CREATE EXTENSION postgis;

CREATE TABLE obiekty (id INT PRIMARY KEY, name VARCHAR(25), geom GEOMETRY);

-- obiekt1
INSERT INTO obiekty(id, name, geom)  VALUES
	(1, 'obiekt1', ST_GeomFromText('MULTICURVE( (0 1, 1 1),
	CIRCULARSTRING(1 1, 2 0, 3 1), CIRCULARSTRING(3 1, 4 2, 5 1), (5 1, 6 1))'));
	
-- obiekt2
INSERT INTO obiekty(id, name, geom)  VALUES
	(2, 'obiekt2', ST_GeomFromText('CURVEPOLYGON(COMPOUNDCURVE(CIRCULARSTRING(14 6, 16 4, 14 2),
	CIRCULARSTRING(14 2, 12 0, 10 2), (10 2, 10 6, 14 6)), CIRCULARSTRING(11 2, 13 2, 11 2))'));

-- obiekt3
INSERT INTO obiekty(id, name, geom)  VALUES
	(3, 'obiekt3', ST_GeomFromText('POLYGON((7 15, 12 13, 10 17, 7 15))'));

-- obiekt4
INSERT INTO obiekty(id, name, geom)  VALUES
	(4, 'obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'));

-- obiekt5
INSERT INTO obiekty(id, name, geom)  VALUES
	(5, 'obiekt5', ST_GeomFromText('MULTIPOINT(30 30 59, 38 32 234)'));
	
-- obiekt6
INSERT INTO obiekty(id, name, geom)  VALUES
	(6, 'obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION(POINT(4 2),LINESTRING(1 1,3 2))'));
--zad.1
SELECT ST_Area(
(SELECT ST_Buffer(
(SELECT ST_ShortestLine(
(SELECT geom FROM obiekty WHERE name = 'obiekt3'), (SELECT geom FROM obiekty WHERE name = 'obiekt4'))), 5)))

--zad.2
INSERT INTO obiekty(id, name, geom)  VALUES
	(7, 'obiekt4-poligon',
	ST_MakePolygon( ST_AddPoint((SELECT geom FROM obiekty WHERE name = 'obiekt4'),
	ST_StartPoint((SELECT geom FROM obiekty WHERE name = 'obiekt4')))));
	
--zad.3
INSERT INTO obiekty(id, name, geom)  VALUES
	(8, 'obiekt7', ST_Collect((SELECT geom FROM obiekty WHERE name = 'obiekt3'), 
							  (SELECT geom FROM obiekty WHERE name = 'obiekt4')));
						
--zad.4
SELECT ST_Area(ST_Buffer(geom, 5))
	FROM obiekty
	WHERE NOT ST_HasArc(geom)
	