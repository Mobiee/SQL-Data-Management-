
update house_data
SET SaleDate=STR_TO_DATE(SaleDate,"%M %d,%y") ;


-- Converting date format to M %d,%y
select SaleDate,STR_TO_DATE(SaleDate,"%M %d,%y") from house_data;

UPDATE
    `house_data`
SET
    `SaleDate` = STR_TO_DATE(`SaleDate`, "%M %d, %Y");




    SELECT
    a.ParcelID,
    a.PropertyAddress,
    b.ParcelID,
    b.PropertyAddress
FROM
    `house_data` a
JOIN house_data b ON
    a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE
    a.PropertyAddress IS NULL


-- breaking out the address into seperate columns(Address,city and state)
SELECT
    SUBSTRING(
        PropertyAddress,
        1,
        LOCATE(",", PropertyAddress) -1
    ) AS Address,
    SUBSTRING(
        PropertyAddress,
        LOCATE(",", PropertyAddress) +1
    ) AS city
FROM
    house_data;




--Seperating columns for Address and city 
ALTER TABLE
    house_data ADD SplittedPropertyAddress VARCHAR(255);
UPDATE
    house_data
SET SplittedPropertyAddress=SUBSTRING(
        PropertyAddress,
        1,
        LOCATE(",", PropertyAddress) -1
    ) ;
ALTER TABLE
    house_data ADD SplittedPropertyCity VARCHAR(255);
UPDATE
    house_data
SET SplittedPropertyCity=SUBSTRING(
        PropertyAddress,
        LOCATE(",", PropertyAddress) +1
    );
    

    -- correct version of seperating owners adress

  SELECT
    OwnerAddress,
     SUBSTRING_INDEX(OwnerAddress, ',', +1) AS address,
     SUBSTRING_INDEX( SUBSTRING_INDEX( OwnerAddress, ',', +2 ),',', -1) as state,
   	 SUBSTRING_INDEX(OwnerAddress, ',', -1) AS city  
FROM
    house_data;





-- Adding sepaerated owners address into separate columns of address, satate nd city.
     
ALTER TABLE
    house_data ADD OwnersSplittedAddress VARCHAR(255);
UPDATE
    house_data
SET OwnersSplittedAddress=SUBSTRING_INDEX(OwnerAddress, ',', +1) ;
ALTER TABLE
    house_data ADD  OwnersSplittedCity VARCHAR(255);
UPDATE
    house_data
SET OwnersSplittedCity=SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', +1));
    
    ALTER TABLE
    house_data ADD  OwnersSplittedState VARCHAR(255);
UPDATE
    house_data
SET  OwnersSplittedState=SUBSTRING_INDEX(OwnerAddress, ',', -1);





-- Analaysing all the nasers of YES are as Yes instaed og Y and all No are No instead of N
SELECT DISTINCT(SoldAsVacant),count(SoldAsVacant)
from house_data
GROUP by SoldAsVacant
order by 2;




-- Replacing Y to Yes and N to No

SELECT  SoldAsVacant ,
CASE 
    WHEN SoldAsVacant = 'N' then 'No'
    WHEN SoldAsVacant = 'Y' then 'Yes'
    ELSE SoldAsVacant
END

FROM house_data;


-- updating table with the above query
UPDATE
    house_data
SET
    SoldAsVacant = CASE WHEN SoldAsVacant = "Y" THEN "Yes" WHEN SoldAsVacant = "N" THEN "No" ELSE SoldAsVacant





-- Remove Duplicates

WITH ROW_NumCTE as (
    select *,
    Row_number() over(
    PARTITION by ParcelID,
    				PropertyAddress,
                    SalePrice,
                    SaleDate,
                    LegalReference
                    order by 
                    UniqueID)
                    row_num
          from house_data
          )
         selct *
         from ROW_NumCTE
         where row_num >1
         ORDER by PropertyAddress




END;