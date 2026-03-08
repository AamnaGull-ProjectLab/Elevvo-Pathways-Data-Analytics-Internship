-- 1. Top-Selling Products by Revenue
SELECT 
    t.TrackId,
    t.Name AS Product_Name,
    SUM(il.UnitPrice * il.Quantity) AS Total_Revenue
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 2. Top-Selling Products by Quantity Sold
SELECT 
    t.TrackId,
    t.Name AS Product_Name,
    SUM(il.Quantity) AS Total_Quantity_Sold
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;


-- 3. Revenue Per Country
SELECT 
    c.Country,
    SUM(i.Total) AS Total_Revenue
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY c.Country
ORDER BY Total_Revenue DESC;


-- 4. Revenue Per City
SELECT 
    c.City,
    c.Country,
    SUM(i.Total) AS Total_Revenue
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY c.City, c.Country
ORDER BY Total_Revenue DESC;


-- 5. Monthly Sales Performance
SELECT 
    strftime('%Y-%m', InvoiceDate) AS Year_Month,
    SUM(Total) AS Monthly_Revenue
FROM Invoice
GROUP BY Year_Month
ORDER BY Year_Month;


-- 6. Revenue Per Genre
SELECT 
    g.Name AS Genre,
    SUM(il.UnitPrice * il.Quantity) AS Total_Revenue
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY Total_Revenue DESC;

-- 7. Rank Products by Revenue using Window Function
SELECT 
    Product_Name,
    Total_Revenue,
    RANK() OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM (
    SELECT 
        t.Name AS Product_Name,
        SUM(il.UnitPrice * il.Quantity) AS Total_Revenue
    FROM InvoiceLine il
    JOIN Track t ON il.TrackId = t.TrackId
    GROUP BY t.Name
);