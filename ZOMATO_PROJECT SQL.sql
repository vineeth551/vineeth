Create database Zomato_Sales_Analysis;
select * from main1;
select * from countrydetails;
select * from currency;

--------- Build a Calendar Table using the Column Datekey
select year(Date) years,
month(Date)  months,
day(Date) day ,
monthname(Date) monthname,Quarter(Date)as quarter,
concat(year(Date),'-',monthname(Date)) yearmonth, 
weekday(Date) weekday,
dayname(date)dayname, 
case when monthname(date) in ('January' ,'February' ,'March' )then 'Q1'
when monthname(date) in ('April' ,'May' ,'June' )then 'Q2'
when monthname(date) in ('July' ,'August' ,'September' )then 'Q3'
else  'Q4' end as quarters,

case when monthname(date)='January' then 'FM10' 
when monthname(date)='January' then 'FM11'
when monthname(date)='February' then 'FM12'
when monthname(date)='March' then 'FM1'
when monthname(date)='April'then'FM2'
when monthname(date)='May' then 'FM3'
when monthname(date)='June' then 'FM4'
when monthname(date)='July' then 'FM5'
when monthname(date)='August' then 'FM6'
when monthname(date)='September' then 'FM7'
when monthname(date)='October' then 'FM8'
when monthname(date)='November' then 'FM9'
when monthname(date)='December'then 'FM10'
end Financial_months,
case when monthname(date) in ('January' ,'February' ,'March' )then 'FQ4'
when monthname(date) in ('April' ,'May' ,'June' )then 'FQ1'
when monthname(date) in ('July' ,'August' ,'September' )then 'FQ2'
else  'FQ3' end as financial_quarters

from main1;

----- Find the Numbers of Resturants based on City and Country.

select City, Count(RestaurantID) As Number_of_Restaurants from main1
group by city ;

select cd.Countryname,count(RestaurantID) As Number_of_Restaurants from main1 m 
join countrydetails cd 
ON m.CountryCode =cd.CountryCode
group by cd.Countryname ;

-----  Numbers of Resturants opening based on Year , Quarter , Month
----- Total Restaurants Open year wise

SELECT distinct year(Date) As year_name,
count(*) from main1 
group by year(Date) ;
   
   ----- Total Restaurants Open Month wise
    
SELECT distinct MonthName(Date) As month_name,
count(*) from main1 
group by MonthName(Date) ;

----- Total Restaurants Open Quarter Wise

SELECT Quarter ,count(*) As RestaurantCount from main1 
where Quarter is NOT NULL
group by Quarter 
order by Quarter;

------ Percentage of Resturants based on "Has_Table_booking"

SELECT 
    Has_Table_booking, 
    COUNT(*) AS TotalRestaurants,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM main), 2) AS Percentage
FROM 
    main1
GROUP BY 
    Has_Table_booking;

------ Percentage of Restaurants based on "Has_Online_Delivery"

SELECT 
    Has_Online_delivery, 
    COUNT(*) AS TotalRestaurants,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM main), 2) AS Percentage
FROM 
    main1
GROUP BY 
    Has_Online_delivery;
    
------- Count of Resturants based on Average Ratings    
select Rating As RatingBin,
Count(*) As Count_of_Restaurants
From main1
where Rating is NOT NULL
Group by Rating
Order by Rating Asc ;
    
------ Total Cuisines
select Cuisines,count(Cuisines) from main1
group by Cuisines;

----- Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

Select Cost_Range,count(*) As TotalRestaurants
from (Select 
          Case 
              When Average_Cost_for_two between 0 and 300 then '0-300'
              When Average_Cost_for_two between 301 and 600 then '301-600'
              When Average_Cost_for_two between 601 and 1000 then '601-1000'
              When Average_Cost_for_two between 1001 and 430000 then '1001-430000'
              Else 'Other'
			End As Cost_Range 
	from main1 ) As Subquery group by Cost_Range;




