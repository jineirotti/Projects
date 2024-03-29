/*
Covid 19 Project

*/

Select *
From Portfolio COVID..CovidDeaths
Where continent is not null 
order by 3,4


-- Select Data 

Select Location, date, total_cases, new_cases, total_deaths, population
From Portfolio COVID..CovidDeaths
Where continent is not null 
order by 1,2


-- Total Cases vs Total Deaths

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as MortalityRate
From Portfolio COVID..CovidDeaths
Where continent is not null 
order by 1,2


-- Total Cases vs Population

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Portfolio COVID..CovidDeaths
order by 1,2


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Portfolio COVID..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc


-- Countries with Highest Death Count 

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Portfolio COVID..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc



-- Showing contintents with the highest death count 

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Portfolio COVID..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc



-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as MortalityRate
From Portfolio COVID..CovidDeaths
where continent is not null 
--Group By date
order by 1,2



-- Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Portfolio COVID..CovidDeaths dea
Join Portfolio COVID..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3


