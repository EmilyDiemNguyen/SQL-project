/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/
SELECT *
FROM CovidDeaths
WHERE continent is not null

SELECT *
FROM CovidDeaths
WHERE continent is not null
ORDER BY 3,4

SELECT *
FROM CovidVaccinations
WHERE continent is not null
ORDER BY 3,4

-- Select Data that I am going to be starting with

SELECT location, date, population, total_cases, new_cases, total_deaths
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRatio
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1,2

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRatio
FROM CovidDeaths
WHERE continent is not null
	AND location = 'Canada'
ORDER BY 1,2

-- When some first cases reported on 26 Jan 2020, no one died because of Covid19. About 2 months later, there were some people died, the death ratio increase gradually and reached the peak 8.5% chance you could die from being infected Covid in Jun 2020. After that, people got vaccinated then this ratio decreased gradually to 1.1% in Jan 2022.

---- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT location, date, population, total_cases, (total_cases/population)*100 as InfectedRatio
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1,2

SELECT location, date, population, total_cases, (total_cases/population)*100 as InfectedRatio
FROM CovidDeaths
WHERE continent is not null
	AND location = 'Canada'
ORDER BY 1,2

-- Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) as HighestInfection, MAX((total_cases/population))*100 as InfectedRatio
FROM CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY InfectedRatio DESC

-- 42% of Andorra population has gotten Covid it has been reported. It is not surprised because Andorra is a small population country. But looking at 
Some of countries have high percentage rates, we did not keep it under control. A large amount of population has gotten Covid. Canada is 7.5% in 99th order.

-- Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths as bigint)) as TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

-- US is the leading in most people died because of Covid with 865,968ppl. 

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

SELECT location, MAX(CAST(total_deaths as bigint)) as TotalDeathCount
FROM CovidDeaths
WHERE continent is null 
GROUP BY location
HAVING location in ('Europe', 'Asia', 'North America', 'South America', 'Africa', 'Oceania')
ORDER BY TotalDeathCount DESC

SELECT continent, MAX(CAST(total_deaths as bigint)) as TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS

Select SUM(new_cases) as TotalCasesCount, SUM(cast(new_deaths as bigint)) as TotalDeathsCount, SUM(cast(new_deaths as bigint))/SUM(New_Cases)*100 as DeathRatio
From CovidDeaths
WHERE continent is not null

-- -- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT Death.continent, Death.location, Death.date, population, new_vaccinations, 
SUM(CONVERT(bigint, new_vaccinations)) OVER (Partition By Death.location 
												Order By Death.location, Death.date) as VaccinationAccumulate
FROM CovidDeaths Death
JOIN CovidVaccinations Vac
	ON Death.location = Vac.location
	AND Death.date = Vac.date
WHERE Death.continent is not null
	--AND Death.location = 'Canada'
ORDER BY 2,3

---- Using CTE to perform Calculation on Partition By in previous query

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, VaccinationAccumulate)
as
(SELECT Death.continent, Death.location, Death.date, population, new_vaccinations, 
SUM(CONVERT(bigint, new_vaccinations)) OVER (Partition By Death.location 
												Order By Death.location, Death.date) as VaccinationAccumulate
FROM CovidDeaths Death
JOIN CovidVaccinations Vac
	ON Death.location = Vac.location
	AND Death.date = Vac.date
WHERE Death.continent is not null)

SELECT *, (VaccinationAccumulate/Population)*100 as VacRatio
FROM PopvsVac
--WHERE Location = 'Canada'


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS #PopulationVaccinated
CREATE TABLE #PopulationVaccinated 
(Continent nvarchar(255),
Location nvarchar(255), 
Date datetime,
Population numeric,
New_Vaccinations numeric,
VaccinationAccumulate numeric)

INSERT INTO #PopulationVaccinated 
SELECT Death.continent, Death.location, Death.date, population, new_vaccinations, 
SUM(CONVERT(bigint, new_vaccinations)) OVER (Partition By Death.location 
												Order By Death.location, Death.date) as VaccinationAccumulate
FROM CovidDeaths Death
JOIN CovidVaccinations Vac
	ON Death.location = Vac.location
	AND Death.date = Vac.date
WHERE Death.continent is not null

SELECT *, (VaccinationAccumulate/Population)*100 as VacRatio
FROM #PopulationVaccinated
--WHERE Location = 'Vietnam'

-- Creating View to store data for later visualizations

CREATE VIEW PopulationVaccinated as
SELECT Death.continent, Death.location, Death.date, population, new_vaccinations, 
SUM(CONVERT(bigint, new_vaccinations)) OVER (Partition By Death.location 
												Order By Death.location, Death.date) as VaccinationAccumulate
FROM CovidDeaths Death
JOIN CovidVaccinations Vac
	ON Death.location = Vac.location
	AND Death.date = Vac.date
WHERE Death.continent is not null

SELECT *
FROM PopulationVaccinated