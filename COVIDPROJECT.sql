Select *
From PortfolioProject..CovidDeaths
order by  3, 4

--Select *
--From PortfolioProject..CovidVaccinations
--order by  3, 4


-- Select the data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by  1, 2


-- Looking at the total cases vs Total Deaths
--Shows the likelihood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
From PortfolioProject..CovidDeaths
where Location like '%states%'
order by  1, 2


--Look at the total cases vs the population
--Shows what percentage of populationa as got Covid
Select Location, date, total_cases, population, (total_cases/population)*100 AS PopulationPercentage
From PortfolioProject..CovidDeaths
where Location like '%states%'
order by  1, 2


--Looking at countries with highest infection rates compared to the Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
From PortfolioProject..CovidDeaths
--where Location like '%states%'
Group by Location, Population
order by  PercentPopulationInfected desc


--SShowing countries with the highest Death Count Per Population
Select Location, MAX(cast(Total_Deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where Location like '%states%'
Where continent is not null
Group by Location
order by  TotalDeathCount desc


--LETS BREAK THINGS DOWN BY CONTINENT 
Select continent, MAX(cast(Total_Deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where Location like '%states%'
Where continent is not  null
Group by continent
order by  TotalDeathCount desc



--GLOBAL NUMBERS
Select  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases) * 100 as DeathPercentage
From PortfolioProject..CovidDeaths
--where Location like '%states%'
where continent is not null
-- Group By date
order by  1, 2

--Looking at Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3


--Rolling Count
Select dea.continent, dea.location, dea.date, dea.population, new_vaccinations, SUM(Cast(new_vaccinations as int)) OVER (Partition by  dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated,
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3



--USE CTE2
WITH PopsVac (Continent, Location, Date, Population, NewVaccinations, RollingPeopleVaccinated) AS
(
    SELECT 
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        new_vaccinations, 
        SUM(CAST(new_vaccinations AS INT)) OVER (
            PARTITION BY dea.location 
            ORDER BY dea.location, dea.date
        ) AS RollingPeopleVaccinated
    FROM 
        PortfolioProject..CovidDeaths dea
    JOIN 
        PortfolioProject..CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopsVac

 --TEMP TABLE
 DROP TABLE if exists #PercentPopulationVaccinated
 Create Table #PercentPopulationVaccinated
 (
 Continent nvarchar(255),
 Location nvarchar(255),
 Date datetime,
 Population numeric,
 New_vaccinations numeric, 
 RollingPeopleVaccinated numeric
 )

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, new_vaccinations , SUM(Cast(new_vaccinations as int)) OVER (Partition by  dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location
	 and dea.date = vac.date
-- where dea.continent is not null
order by 2,3
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


--Creating View to store data fpr later visualisations

Create View dbo.PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, new_vaccinations , SUM(Cast(new_vaccinations as int)) OVER (Partition by  dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
--- order by 2,3

























































































Select dea.continent, dea.location, dea.date, dea.population, new_vaccinations, SUM(Cast(new_vaccinations as int)) OVER (Partition by  dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated,
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null
order by 2,3




Select *
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location
	 and dea.date = vac.date








