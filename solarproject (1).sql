CREATE DATABASE SOLAR_ENERGY_PROJECT


--import flat file as csv

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--showing all data
SELECT * FROM [dbo].[egypt_digital_sun]

-- showing top 100 raws from data
SELECT TOP 100 * FROM egypt_digital_sun

-- total numbers of raws
SELECT COUNT(*) AS total_records FROM egypt_digital_sun


--average radiation for every city
SELECT city, AVG(solar_radiation) AS avg_radiation
FROM [dbo].[egypt_digital_sun]
GROUP BY city
ORDER BY avg_radiation DESC;


--renaming columns 
EXEC sp_rename 'egypt_digital_sun.ALLSKY_SFC_SW_DWN', 'solar_radiation', 'COLUMN';

EXEC sp_rename 'egypt_digital_sun.WD10M', 'wind_direction', 'COLUMN';

EXEC sp_rename 'egypt_digital_sun.WD10M', 'wind_direction', 'COLUMN';




--Max solar radiation
Create View Max_Radiation AS
SELECT city,solar_radiation
FROM egypt_digital_sun
where solar_radiation = (select max(solar_radiation)
from egypt_digital_sun)

--Min solar radiation
SELECT city,solar_radiation
FROM egypt_digital_sun
where solar_radiation = (select min(solar_radiation)
from egypt_digital_sun)


-- ترتيب متوسط الاشعاع الشمسي بشهور السنة
SELECT MONTH AS month, AVG(solar_radiation) as avg_radiation
FROM [dbo].[egypt_digital_sun]
GROUP BY month
ORDER BY avg_radiation

--تأثير حالة السماء
SELECT sky_status, AVG(solar_radiation) as avg_radiation
FROM [dbo].[egypt_digital_sun]
GROUP BY sky_status;


--تأثير درجات الحرارة  
SELECT [temperature], solar_radiation
FROM [dbo].[egypt_digital_sun]
ORDER BY [temperature]  DESC;


--annual trend
SELECT YEAR AS year, AVG(solar_radiation) as avg_radiation
FROM [dbo].[egypt_digital_sun]
GROUP BY year;

--
CREATE VIEW solar_summary AS
SELECT 
    city,
    AVG(solar_radiation) AS avg_radiation,
    AVG(Temperature) AS avg_temp,
    AVG(RH2M) AS avg_humidity
FROM [dbo].[egypt_digital_sun]
GROUP BY city 




--the best season in solar radiation production 
SELECT *
FROM(
    SELECT 
        season,
        solar_radiation
    FROM [dbo].[egypt_digital_sun]
) AS SourceTable

PIVOT
(
    AVG(solar_radiation)
    FOR season IN ([Winter], [Spring], [Summer], [Autumn])
) AS PivotTable;
   


--متوسط درجة الحرارة لكل مدينة حسب الفصول
SELECT *
FROM
(
    SELECT 
        city,
        season,
        [temperature]
    FROM [dbo].[egypt_digital_sun]
) AS SourceTable

PIVOT
(
    AVG(Temperature)
    FOR season IN ([Winter], [Spring], [Summer], [Autumn])
) AS PivotTable;



--متوسط الاشعاع الشمسي حسب الشهور
SELECT *
FROM
(SELECT  month,solar_radiation
    FROM [dbo].[egypt_digital_sun]
) AS SourceTable

PIVOT
(
    AVG(solar_radiation)
    FOR month IN (
        [1],[2],[3],[4],[5],[6],
        [7],[8],[9],[10],[11],[12]
    )
) AS PivotTable;




--متوسط الاشعاع الشمسي لكل مدينة علي حسب الفصول
SELECT *
FROM
(
    SELECT 
        city,
        season,
        solar_radiation
    FROM [dbo].[egypt_digital_sun]
) AS SourceTable

PIVOT
(
    AVG(solar_radiation)
    FOR season IN ([Winter], [Spring], [Summer], [Autumn])
) AS PivotTable
ORDER BY [Summer] DESC;









      






















































