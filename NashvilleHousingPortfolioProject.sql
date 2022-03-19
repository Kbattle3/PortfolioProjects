/* 

Cleaning Data in SQL Queries



*/
----------------------------------------------------------------------------------------------------------------------------------

select *
from PortfolioProject.dbo.[Nashville Housing]



-- Standardize Date Format 

select SaleDate, convert(date,saledate)
from PortfolioProject.dbo.[Nashville Housing]

update [Nashville Housing]
set SaleDate = convert(date,saledate)

alter table [Nashville Housing]
add saledateconverted date;


update [Nashville Housing]
set SaleDateConverted = convert(date,saledate)

select SaleDateConverted, convert(date,saledate)
from PortfolioProject.dbo.[Nashville Housing]

---------------------------------------------------------------------------------

-- Populate Property Address data



select *
from PortfolioProject.dbo.[Nashville Housing]
--where PropertyAddress is null
order by ParcelID


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.[Nashville Housing] a
join PortfolioProject.dbo.[Nashville Housing] b
on a.ParcelID = b.ParcelID 
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null



Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.[Nashville Housing] a
join PortfolioProject.dbo.[Nashville Housing] b
on a.ParcelID = b.ParcelID 
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null




----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (address, City, State)



select PropertyAddress
from PortfolioProject.dbo.[Nashville Housing]
--where PropertyAddress is null
--order by ParcelID



SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) AS ADDRESS
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) AS ADDRESS

from PortfolioProject.dbo.[Nashville Housing]




alter table [Nashville Housing]
add PropertySplitAddress Nvarchar(255);

update [Nashville Housing]
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


alter table [Nashville Housing]
add PropertySplitCity Nvarchar(255);


update [Nashville Housing]
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))


Select *

from PortfolioProject.dbo.[Nashville Housing]


Select OwnerAddress
From PortfolioProject.dbo.[Nashville Housing]


Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProject.dbo.[Nashville Housing]







alter table [Nashville Housing]
add OwnerSplitAddress Nvarchar(255);

update [Nashville Housing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

alter table [Nashville Housing]
add OwnerSplitCity Nvarchar(255);


update [Nashville Housing]
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

alter table [Nashville Housing]
add OwnerSplitState Nvarchar(255);

update [Nashville Housing]
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field


Select distinct(SoldAsVacant), count(SoldAsVacant)
from PortfolioProject.dbo.[Nashville Housing]
group by SoldAsVacant
order by 2

select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
       when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end
from PortfolioProject.dbo.[Nashville Housing]

update [Nashville Housing]
set SoldAsVacant =  case when SoldAsVacant = 'Y' then 'Yes'
       when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
   ROW_NUMBER() Over(
   PARTITION BY ParcelID,
                PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				Order By
				UniqueID
				) row_num
		     


from PortfolioProject.dbo.[Nashville Housing]
--order by ParcelID
) 
select *
From RowNumCTE
where row_num > 1
--order by PropertyAddress

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Delete Unused Columns


select *
from PortfolioProject.dbo.[Nashville Housing]



ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress



ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
DROP COLUMN SaleDate







































 