
--converting SaleDate column to proper date format

UPDATE NewTable
SET saledate = strftime('%Y-%m-%d', 
                       substr(saledate, instr(saledate, ',')+2)||'-'||
                       CASE 
                           WHEN instr(saledate, 'January') THEN '01'
                           WHEN instr(saledate, 'February') THEN '02'
                           WHEN instr(saledate, 'March') THEN '03'
                           WHEN instr(saledate, 'April') THEN '04'
                           WHEN instr(saledate, 'May') THEN '05'
                           WHEN instr(saledate, 'June') THEN '06'
                           WHEN instr(saledate, 'July') THEN '07'
                           WHEN instr(saledate, 'August') THEN '08'
                           WHEN instr(saledate, 'September') THEN '09'
                           WHEN instr(saledate, 'October') THEN '10'
                           WHEN instr(saledate, 'November') THEN '11'
                           WHEN instr(saledate, 'December') THEN '12'
                       END||'-'||
                       CASE 
                           WHEN length(substr(saledate, instr(saledate, ' ')+1, instr(saledate, ',')-instr(saledate, ' ')-1)) = 1 THEN '0'||substr(saledate, instr(saledate, ' ')+1, instr(saledate, ',')-instr(saledate, ' ')-1)
                           ELSE substr(saledate, instr(saledate, ' ')+1, instr(saledate, ',')-instr(saledate, ' ')-1)
                       END
                      );
                      
SELECT SaleDate
from NewTable


---- Populate Property Address data


UPDATE NewTable 
SET PropertyAddress = (SELECT a.PropertyAddress from NewTable a where ParcelID = a.ParcelID and a.PropertyAddress !='' LIMIT 1)
WHERE PropertyAddress =''



SELECT *
from NewTable
where PropertyAddress =''


Select *
from NewTable
where PropertyAddress != ''


--Splitting adress into multiple columns (Adress, city, state) for PropertyAddress and OwnerAdress

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From NewTable

ALTER TABLE NewTable 
Add PropertySplitAddress Nvarchar(255);

Update NewTable 
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NewTable 
Add PropertySplitCity Nvarchar(255);

Update NewTable 
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From NewTable

ALTER TABLE NewTable 
Add OwnerSplitAddress Nvarchar(255);

Update NewTable 
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NewTable 
Add OwnerSplitCity Nvarchar(255);

Update NewTable 
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NewTable 
Add OwnerSplitState Nvarchar(255);

Update NewTable 
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


Select *
From NewTable


-- deleting columns that have become obsolete (propertyaddress and Owneraddress)

Select *
From NewTable


ALTER table newtable
drop column propertyaddress owneraddress

ALTER table newtable
drop column owneraddress

SELECT *
from NewTable

