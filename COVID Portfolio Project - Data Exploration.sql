Select *
From PortofolioProject..CovidDeaths
Where continent is not null
Order by 3,4





-- Select Data that we are going to be starting with

Select location, date, total_cases,hosp_patients, total_deaths, population
From PortofolioProject..CovidDeaths
Where continent is not null
Order by 1,2





-- Hospital patients vs Total Cases
-- Shows percentage of hospitalization if you contract covid in Italy

Select location,date,total_cases,hosp_patients,(hosp_patients/total_cases)*100 as Hospitalization_Percentage
From PortofolioProject..CovidDeaths
Where location = 'Italy'
and continent is not null
Order by date





-- Total Deaths vs Population
-- Shows what percentage of population died from Covid in Greece 

Select location, date, population, total_deaths,(total_deaths/population)*100 as Percent_Population_Died
From PortofolioProject..CovidDeaths
Where location = 'Greece' 
and continent is not null
Order by date





-- Countries in Europe with Lowest Death Count compared to Population

Select location,population, Max(total_deaths) as Total_Deaths, Max((total_deaths/population))*100 as Percent_Population_Died
From PortofolioProject..CovidDeaths
Where continent = 'Europe' 
Group by location,population
Order by Percent_Population_Died





-- Top 50 Countries with Lowest Infection Rate compared to Population

Select Top 50 location,population, Max(total_cases) as  Total_Cases, Max((total_cases/population))*100 as Percent_Population_Infected
From PortofolioProject..CovidDeaths
Where continent is not null 
Group by location,population
Order by Percent_Population_Infected





-- BREAKING THINGS DOWN BY CONTINENT
-- Showing contintent with the Lowest Infection Rate

Select continent, MAX(cast(total_cases as int)) as Total_Cases
From PortofolioProject..CovidDeaths
Where continent is not null
Group by continent
order by Total_Cases desc




-- GLOBAL NUMBERS

Select SUM(new_cases) as Total_Cases,
SUM(cast(new_deaths as int)) as Total_Deaths,  SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as Death_Percentage
From PortofolioProject..CovidDeaths
where continent is not null 
--Group By date
order by 1,2





-- Total Population vs Vaccinations
-- Shows Percentage of Population that they are fully vaccinated

Select CovidDeaths.location, CovidDeaths.population, MAX(cast(CovidVaccinations.people_fully_vaccinated as int)) as fully_vaccinated,    
MAX(cast(CovidVaccinations.people_fully_vaccinated as int))/population*100 as Fully_Vaccinated_Percentage
From PortofolioProject..CovidDeaths 
Join PortofolioProject..CovidVaccinations 
	On CovidDeaths.location = CovidVaccinations.location
	and CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null 
group by CovidDeaths.location, CovidDeaths.population
order by 4





-- Creating View to store data for later visualizations
Create View onedose_fullyvaccinated as
Select CovidDeaths.location, CovidDeaths.population,MAX(cast(CovidVaccinations.people_vaccinated as int)) one_dose,    
round(MAX(cast(CovidVaccinations.people_vaccinated as int))/population*100, 2) as one_dose_Percentage,
MAX(cast(CovidVaccinations.people_fully_vaccinated as int)) as fully_vaccinated,    
round(MAX(cast(CovidVaccinations.people_fully_vaccinated as int))/population*100, 2) as fully_vaccinated_Percentage
From PortofolioProject..CovidDeaths 
Join PortofolioProject..CovidVaccinations 
	On CovidDeaths.location = CovidVaccinations.location
	and CovidDeaths.date = CovidVaccinations.date
where CovidDeaths.continent is not null 
group by CovidDeaths.location, CovidDeaths.population


