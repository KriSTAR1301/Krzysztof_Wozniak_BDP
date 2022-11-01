--zad.1
SELECT DISTINCT COUNT(t2019_kar_buildings.polygon_id) FROM t2018_kar_buildings 
FULL JOIN t2019_kar_buildings  ON t2018_kar_buildings.polygon_id=t2019_kar_buildings.polygon_id 
WHERE (t2018_kar_buildings.type IS NULL AND t2019_kar_buildings.type IS NOT NULL)
OR (t2019_kar_buildings.height != t2018_kar_buildings.height) OR
t2019_kar_buildings.geom > t2018_kar_buildings.geom OR t2019_kar_buildings.geom < t2018_kar_buildings.geom
--zad.2
CREATE TABLE renovated_buildings AS 
SELECT b9.* FROM t2018_kar_buildings b8 
FULL JOIN t2019_kar_buildings b9 ON b8.polygon_id=b9.polygon_id 
WHERE (b8.type IS NULL AND b9.type IS NOT NULL OR b9.height != b8.height) OR b8.geom < b9.geom
SELECT * FROM cw3.renovated_buildings
--zad.3
UPDATE T2019_KAR_STREETS SET geom = St_Transform(geom, 4326)
SELECT gid, link_id, st_name, ref_in_id, nref_in_id, func_class, speed_cat, fr_speed_l, to_speed_l, dir_travel,
		ST_TRANSFORM(geom, 3068)
INTO TABLE streets_reprojected
FROM t2019_kar_streets;
--zad.4

DROP TABLE input_points
CREATE TABLE input_points(
	id SERIAL PRIMARY KEY,
	geom geometry NOT NULL	
);


INSERT INTO input_points VALUES (DEFAULT, ST_GeomFromText('POINT(8.36093 49.03174)'));
INSERT INTO input_points VALUES (DEFAULT, ST_GeomFromText('Point(8.39876 49.00644)'));


SELECT UpdateGeometrySRID('input_points','geom',4326)

SELECT ST_AsText(geom) FROM input_points

SELECT ST_Srid(geom) FROM input_points

SELECT * FROM input_points
--zad.5
UPDATE input_points SET geom = St_Transform(geom, 3068)
SELECT ST_Srid(geom) FROM input_points

SELECT ST_AsText(geom) FROM input_points
SELECT * FROM input_points

--zad.6

SELECT UpdateGeometrySRID('t2019_kar_street_node','geom',4326)
SELECT * FROM t2019_kar_street_node
WHERE ST_Within(ST_Transform(t2019_kar_street_node.geom, 4326), 
                ST_Buffer(ST_ShortestLine((SELECT geom FROM input_points WHERE id = 1),
                       (SELECT geom FROM input_points WHERE id = 2)), 200));

--zad.7
SELECT DISTINCT p.poi_name, p.type 
FROM public.t2019_kar_poi_table p,
public.t2019_kar_land_use_a f 
WHERE ST_DWithin(f.geom, p.geom, 0.0027) AND p.type = 'Sporting Goods Store' AND f.type='Park (City/County)';

 --zad.8
 
  SELECT DISTINCT ST_Intersection(t2019_kar_railways.geom, t2019_kar_water_lines.geom) 
  INTO T2019_KAR_BRIDGES
 FROM t2019_kar_railways , t2019_kar_water_lines    
SELECT * FROM T2019_KAR_BRIDGES

