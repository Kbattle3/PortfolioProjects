select *
from PortfolioProject..CovidDeaths 
where continent is not null
order by 3,4

select *
from PortfolioProject..[Covid Vaccinations]
order by 3,4
-- select data we are going to be using

select location, date, total_cases, new_cases, total_deaths, population 
from PortfolioProject..CovidDeaths
order by 1,2

--looking at Total cases vs Total Deaths
--shows likelihood of dying if you get covid in your country

select location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths 
where location like'%states%'
order by 1,2

-- looking at totalcase vs population
--shows what percentage of population got covid
select location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage
from PortfolioProject..CovidDeaths 
where location like'%states%'
order by 1,2

--Looking at countries with highest infection rate compared to population

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths 
--where location like'%states%'
group by  location, population
order by PercentPopulationInfected desc

--showing countries with the highest death count per population

select location, max(cast(Total_deaths as int)) as TotalDeathCount 
from PortfolioProject..CovidDeaths
--where location like'%states%'
where continent is not null
group by  location 
order by TotalDeathCount desc

-- LETS BREAK THINGS DOWN BY CONTINENT 
	


--Showing the Continents with the Highest Death Count per population


select continent, max(cast(Total_deaths as int)) as TotalDeathCount 
from PortfolioProject..CovidDeaths
--where location like'%states%'
where continent is not null
group by  continent
order by TotalDeathCount desc

-- Global Numbers

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths 
--where location like'%states%'
where continent is not null
--group by date
order by 1,2

-- looking a total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, convert(date, dea.date)) as RollingPeopleVaccinated,
--(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..[Covid Vaccinations] vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 2,3


--use cte 


with PopvsVac (continent, location, date, population, new_vaccinations, rollingpeoplevaccinated) 
as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,convert(date, dea.date)) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..[Covid Vaccinations] vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac 







-- TEMP TABLE
--drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,convert(date, dea.date)) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..[Covid Vaccinations] vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


--creating view to store data for later visualizations
create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,convert(date, dea.date)) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..[Covid Vaccinations] vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select* 
from PercentPopulationVaccinated



create view TotalDeaths as
select continent, max(cast(Total_deaths as int)) as TotalDeathCount 
from PortfolioProject..CovidDeaths
--where location like'%states%'
where continent is not null
group by  continent
--order by TotalDeathCount desc


create view PercentPopulationInfected as
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths 
--where location like'%states%'
group by  location, population
--order by PercentPopulationInfected desc