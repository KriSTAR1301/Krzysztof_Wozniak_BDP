-- raster2pgsql -s 27700 -I -N -32767 -t 100x100 -C -M  "C:\Users\krz12\Desktop\Krzysztof_Wozniak_BDP\ras250_gb\data\*.tif" raster.uk_250k | psql -d CW7 -h localhost -U postgres -p 5432

SELECT * FROM raster.uk_250k;

-- 3. 
CREATE TABLE raster.uk_250k_union AS
SELECT ST_Union(rast)
FROM raster.uk_250k 

--6.

CREATE TABLE raster.uk_lake_district AS 
SELECT ST_Union(ST_Clip(a.rast, b.geom, true)) AS rast
FROM uk_250k AS a, national_parks AS b
WHERE ST_Intersects(a.rast, b.geom) AND b.id = '1';

SELECT * FROM uk_lake_district;
--7.
CREATE TABLE raster.tmp_out AS
SELECT lo_from_bytea(0,
ST_AsGDALRaster(ST_Union(rast), 'GTiff', ARRAY['COMPRESS=DEFLATE','PREDICTOR=2', 'PZLEVEL=9'])) AS loid
FROM raster.uk_lake_district;

