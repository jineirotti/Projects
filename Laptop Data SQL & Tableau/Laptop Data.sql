select *
from laptop_data

-- cleaning data. removing GB and Kg from RAM and Weight columns

SELECT *
FROM laptop_data
WHERE weight NOT LIKE '%kg%';

select *
from laptop_data
where Ram not like '%GB%'

UPDATE laptop_data
SET weight = REPLACE(weight, 'kg', '')
where weight like '%kg%'

select weight
from laptop_data

update  laptop_data 
set Ram = replace (ram, 'GB', '')
where ram like '%GB%'

select ram
from laptop_data

select *
from laptop_data


-- checking which brand and Type is more expensive

SELECT Typename, COUNT(*) AS LaptopTypes
FROM laptop_data
GROUP BY Typename;


SELECT Typename, round(avg(Price),0) as avgpriceTN
FROM laptop_data
GROUP BY Typename
order by avgpriceTN

select Company, count(*) as Companycount
from laptop_data
group by Company 
order by -Companycount

select Company, round(avg(price),0) as avgpriceCompany
from laptop_data
group by Company
order by -avgpriceCompany

-- checking which brand occupies more markets

select Company, round(min(price),0), round(max(price),0), round(max(price)-min(Price) ,0), round((max(price)-min(Price))/min(price),0) as mktvar
from laptop_data
group by	Company 
order by -round((max(price)-min(Price))/min(price),0) 

create table Mktvtytable,
Company = company from laptop_data




-- checking the correlation between screen size and price

select inches, round(avg(price),0)
from laptop_data
group by Inches 
order by -round(avg(price),0)

-- most expensive system

select Opsys, round(avg(price),0)
from laptop_data ld 
group by OpSys 
order by -round(avg(price),0)


-- add price mktvar to original table

WITH MktVar_CTE AS (SELECT Company, ROUND((MAX(price) - MIN(Price)) / MIN(price), 0) AS mktvar
    FROM 
        laptop_data
    GROUP BY
        Company 
)

SELECT 
    ld.*,
    mvt.mktvar
FROM 
    laptop_data ld
INNER JOIN 
    MktVar_CTE mvt ON ld.Company = mvt.Company
ORDER BY 
    mvt.mktvar;


   select *
   from laptop_data
   order by -Ram  