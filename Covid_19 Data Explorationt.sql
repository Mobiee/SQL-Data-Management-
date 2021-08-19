


-- Exploring Data from covid vaccination
select * from covidvaccinations
order by 3,4

-- Exploring Data from covid death data
select * from coviddeath
order by 3,4


-- Exploring Data from covid death data
select location,date,population, total_cases,new_cases,total_deaths
from coviddeath

-- Analysing the  Total Cases vs Total Deaths

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from coviddeath
order by 1,2


-- Analysing the  Total Cases vs Total Deaths in china
select location,date,total_cases,population,(total_cases/population)*100 as DeathPercentage
from coviddeath
where location like '%china%'
order by 1,2

-- Analysing what percentage of population infected with Covid in Australia
select location,date_format(date,"%d/ %m /%y") as date,population,total_cases,(total_cases/population)*100 as Covid_Percentage
from coviddeath
where location like '%aust%'
order by 1,2

-- Analysing Countries with Highest COVID Infection Rate compared to Population
select location,population,Max(total_cases) as 'HighestCovidInfection',Max((total_cases/population))*100 as "Highest_Covid_Rate"
from coviddeath
group by population,location
order by Highest_Covid_Rate

-- Analysing Countries with Highest Death Count per Population

select location,population,Max(total_deaths) as 'Highest_Death',Max((total_deaths/population))*100 as "Highest_Death_Rate"
from coviddeath
group by location,population
order by Highest_Death_Rate desc



select location,Max(cast(total_deaths as int)) as Highest_Death
from coviddeath
where continent is not null
group by location
order by Highest_Death desc
select location,Max(cast(total_deaths as UNSIGNED)) as Highest_Death
from coviddeath
where continent is not null and not  ("Europe","South America", "North America","European Union")
group by location
order by Highest_Death desc



-- Analysing GLOBAL NUMBERS
select SUM(new_cases) AS Total_NEWCASES,
SUM(cast(new_deaths as UNSIGNED)) AS Total_NEWDEATHS,SUM(cast(new_deaths as UNSIGNED))/SUM(new_cases)*100 AS PERCENTAGE_DEATH
from coviddeath
order by 1,2




-- Analysing the Percentage of Population that has recieved at least one Covid Vaccine
Select death.location, death.continent , death.date, death.population,vacc.new_vaccinations,sum((vacc.new_vaccinations))
 OVER(PARTITION BY death.location ORDER BY death.location,death.date) as VaccinatedPepople
from covid_death_data  death
Join covid_vacanation vacc
on death.location=vacc.location 
and death.date=vacc.date


-- Using CTE to perform Calculation on Partition 


With Vacc_Pop (continent,location,Date,Population,New_vaccination,VaccinatedPepople)
as
(
Select death.location, death.continent , death.date, death.population,vacc.new_vaccinations,sum((vacc.new_vaccinations))
 OVER(PARTITION BY death.location ORDER BY death.location,death.date) as VaccinatedPepople
from covid_death_data  death
Join covid_vacanation vacc
on death.location=vacc.location 
and death.date=vacc.date
)
select *, (VaccinatedPepople/population)*100
from  Vacc_Pop


-- Using Temp Table to perform Calculation on Partition

Drop TEMPORARY TABLE if exists PopulationVaccin_Percent
Create TEMPORARY TABLE PopulationVaccin_Percent
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
VaccinatedPepople numeric
)
Insert into PopulationVaccin_Percent
Select death.location, death.continent , death.date, death.population,vacc.new_vaccinations,sum((vacc.new_vaccinations))
 OVER(PARTITION BY death.location ORDER BY death.location,death.date) as VaccinatedPepople
from covid_death_data  death
Join covid_vacanation vacc
on death.location=vacc.location 
and death.date=vacc.date
Select *, (VaccinatedPepople/population)*100
from  PopulationVaccin_Percent



-- Creating view 
create view  PopulationVaccin_Percent as
Select death.location, death.continent , death.date, death.population,vacc.new_vaccinations,sum((vacc.new_vaccinations))
 OVER(PARTITION BY death.location ORDER BY death.location,death.date) as VaccinatedPepople
from covid_death_data  death
Join covid_vacanation vacc
    on death.location=vacc.location 
    and death.date=vacc.date


