USE Db1
SELECT * FROM sp;

-- QUERIES -- 

-- 1. What is the highest opening price and by which brand was this stock issued? -- 
SELECT Brand_Name, Opening_price, Date
FROM sp
WHERE Opening_price = (SELECT MAX(Opening_price) FROM sp);

-- 2. What is the average trading volume per company? --
SELECT Brand_Name, AVG(Volume) AS Avg_volume
FROM sp
GROUP BY Brand_Name
ORDER BY Avg_volume DESC; 

-- 3. What is the average trading volume per industry? --
SELECT Industry_Tag, AVG(Volume) AS Avg_volume
FROM sp
GROUP BY Industry_Tag
ORDER BY Avg_volume DESC;

-- 4. What are the highest and lowest closing prices recorded annually? --
SELECT YEAR(Date) AS 'year', MAX(Closing_price) AS max_cp, MIN(Closing_price) AS min_cp FROM sp
GROUP BY YEAR(Date)
ORDER BY YEAR(Date);

-- 5. How many stocks have been issued annually since 2000? -- 
SELECT YEAR(Date) AS 'year', COUNT(*) AS count
FROM sp
GROUP BY YEAR(Date)
ORDER BY YEAR(Date);

-- 6. What is the distribution of stocks issued by each country? --
SELECT COUNT(*) AS count, Country
FROM sp
GROUP BY Country
ORDER BY count DESC;

-- 7. Which stocks should investors be wary of this month? -- 
SELECT TOP 50 Brand_Name, Lowest_price
FROM sp 
WHERE Date LIKE '2023-09-%'
GROUP BY Brand_Name, Lowest_price
ORDER BY Lowest_price ASC;

-- 8. What is the highest price that each brands stock has reached this month? --
SELECT MAX(Highest_price) AS Max_price, Brand_Name FROM sp
WHERE Date LIKE '2023-09-%'
GROUP BY Brand_Name
ORDER BY Max_price DESC;

-- 9. What are the top 10 highest trading companies this month? --
SELECT TOP 10 Brand_Name, SUM(Volume) AS Total_volume
FROM sp
WHERE Date LIKE '2023-09-%'
GROUP BY Brand_Name
ORDER BY Total_volume DESC;

-- 10. What is the 50 Day SMA for Google's Stock in 2023? --
SELECT Date, Ticker,
    AVG(Closing_price) OVER(ORDER BY Date 
        ROWS BETWEEN 49 PRECEDING AND
CURRENT ROW)
        AS moving_avg
FROM sp
WHERE Date LIKE '2023%' AND Ticker = 'GOOGL'