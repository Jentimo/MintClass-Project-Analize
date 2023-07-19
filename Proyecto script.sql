# Scripts for Productos Data
# Wich category has sold more units, the estimaded profit and wich ware house storage it 
#I want to know the tipe and price of the most selling category
#By Jose Timaure
select mintclassics.products.productLine as Product,
count(mintclassics.orderdetails.productCode) as Total_Oders,
sum(mintclassics.orderdetails.quantityOrdered) as Total_Unit_Sold,
round(avg(mintclassics.orderdetails.priceEach) * sum(mintclassics.orderdetails.quantityOrdered), 2) as Estimaded_Profit,
sum(mintclassics.products.quantityInStock) as totalStock,
CONCAT(
ROUND((sum(mintclassics.orderdetails.quantityOrdered) / 
( SELECT SUM(mintclassics.orderdetails.quantityOrdered) FROM mintclassics.orderdetails ) * 100 ),2 ), '%') AS porcentaje,
mintclassics.warehouses.warehouseName as Warehouse
from mintclassics.orderdetails
inner join mintclassics.products on mintclassics.orderdetails.productCode = mintclassics.products.productCode
inner join mintclassics.warehouses on mintclassics.products.warehouseCode = mintclassics.warehouses.warehouseCode
group by mintclassics.products.productLine
order by sum(mintclassics.orderdetails.quantityOrdered) DESC;


