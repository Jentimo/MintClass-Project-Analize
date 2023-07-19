# Scripts for Productos Data
#I want to look for patterns like, what is the most sell item over all shop 
# Wich ware house has more suplies 
#I want to know the tipe and price of the most selling item 
#By Jose Timaure
select mintclassics.products.productName as Product, #this is for the name of the Item/Nombre del producto
mintclassics.products.productLine as Product_Type, #Categoria del producto/ Product category
count(mintclassics.orderdetails.productCode) as Total_Oders, #Total de veces que fue ordenado/ Total Orders
sum(mintclassics.orderdetails.quantityOrdered) as Total_Unit_Sold, 
avg(mintclassics.orderdetails.priceEach) as Average_Price, #Precio promedio/ average price
round(avg(mintclassics.orderdetails.priceEach) * sum(mintclassics.orderdetails.quantityOrdered), 2) as Estimaded_Profit, #Recaudacion estimada
CONCAT(
ROUND((sum(mintclassics.orderdetails.quantityOrdered) / 
( SELECT SUM(mintclassics.orderdetails.quantityOrdered) FROM mintclassics.orderdetails ) * 100 ),2 ), '%') AS porcentaje, #Porcentaje de todo lo vendido
mintclassics.products.quantityInStock as Total_Stock,
round (mintclassics.products.quantityInStock-mintclassics.products.quantityInStock * 0.35) as Total_Stock_Less35P, #El stock si se redujera un 35%
mintclassics.warehouses.warehouseName as Warehouse
from mintclassics.orderdetails
inner join mintclassics.products on mintclassics.orderdetails.productCode = mintclassics.products.productCode
inner join mintclassics.warehouses on mintclassics.products.warehouseCode = mintclassics.warehouses.warehouseCode
group by mintclassics.products.productName
order by sum(mintclassics.orderdetails.quantityOrdered) DESC;