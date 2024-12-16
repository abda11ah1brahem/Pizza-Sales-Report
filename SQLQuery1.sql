select * from pizza_sales_excel_file
-- KPI's
--Total Revenue
select sum(total_price) 'Total Revenue' from pizza_sales_excel_file


--Average Order Value
select format((sum(total_price)/count(distinct(order_id))),'0.000') 'Average Order Value' from pizza_sales_excel_file


--Total Pizzas Sold
select sum(quantity) 'Total Pizzas Sold' from pizza_sales_excel_file

--Total Orders
select count(distinct(order_id)) 'Total Orders' from pizza_sales_excel_file


--Average Pizzas Per Order
select format(cast(sum(quantity) as decimal (10,2)) / cast(count(distinct(order_id)) as decimal(10,2)),'0.00' ) 'Average Pizzas Per Order'
from pizza_sales_excel_file

---------------------------------------------------------------------------------------------------
--Daily Trend
-- total sales by day
select DATENAME(DW,order_date) order_day,sum(total_price) total_sales
from pizza_sales_excel_file
group by DATENAME(DW,order_date)
order by 2

-- total orders by day
select DATENAME(DW,order_date) oder_day ,count(distinct order_id) total_quantity
from pizza_sales_excel_file
group by DATENAME(DW,order_date)
order by 2 desc

---------------------------------------------------------------------------------------------------
-- Monthly Trend
-- total sales by month
select DATENAME(MONTH,order_date) order_month ,sum(total_price) total_sales
from pizza_sales_excel_file
group by DATENAME(MONTH,order_date)
order by 2 desc 


-- total orders by month
select DATENAME(MONTH,order_date) oder_month ,count(distinct order_id) total_Orders
from pizza_sales_excel_file
group by DATENAME(MONTH,order_date)
order by 2 desc

---------------------------------------------------------------------------------------------------
-- % of Sales by Pizza Category
select pizza_category,format(sum(total_price),'0.00') 'Total_Sales'
,format(sum(total_price)*100 / (select sum(total_price)from pizza_sales_excel_file),'0.00') 'PCT'
from pizza_sales_excel_file
group by pizza_category
order by 2 desc

---------------------------------------------------------------------------------------------------
-- % of Sales by Pizza Size
select pizza_size,format(sum(total_price),'0.00') 'Total_Sales'
,format(sum(total_price)*100 / (select sum(total_price)from pizza_sales_excel_file),'0.00') 'PCT'
from pizza_sales_excel_file
group by pizza_size
order by 2 desc

---------------------------------------------------------------------------------------------------
--Total Pizzas Sold by Pizza Category
select pizza_category, count(quantity) 'Total Pizzas'
from pizza_sales_excel_file
group by pizza_category 
order by 2 desc


---------------------------------------------------------------------------------------------------
--Top 5 Pizzas by Revenue
select top 5 pizza_name , sum(total_price) 'total revenue'
from pizza_sales_excel_file
group by pizza_name
order by 2 desc


---------------------------------------------------------------------------------------------------
--bottom 5 Pizzas by Revenue
select top 5 pizza_name , sum(total_price) 'total revenue'
from pizza_sales_excel_file
group by pizza_name
order by 2 asc