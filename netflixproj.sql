select * from netflix.netflix_titles;
select * from netflix.netflix_titles limit 5;
-- unique titles that released year after 2020  --
select distinct(show_id) from netflix.netflix_titles;
select distinct(title) from netflix.netflix_titles where release_year>2020;
-- specific unique  titlt blood and water   or release year >2021 kota factory country != india---
select distinct(title) from netflix.netflix_titles where release_year>2020 and title='blood and water ' or title ="kota factory "or release_year>2020 and country!="india"; 
select title as namet  from netflix.netflix_titles order by title;
select count(release_year) as release_uni, min(release_year) as min_year, max(release_year) as max_year,
Round(avg(release_year),2),sum(release_year) from netflix.netflix_titles limit 1;
select country from netflix.netflix_titles where country like "%ia";
select * from netflix.netflix_titles where country in ("India " ,"United States","Australia") order by country;