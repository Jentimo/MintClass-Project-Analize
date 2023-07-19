# Scripts for Warehouse Data
#I want to know how details about the ware house like, wich warehouse has more varaitey of producs, wich have more quantity of products
#wich have more value 
# And all the distribution among all the Warehouses
#By Jose Timaure
SELECT  mintclassics.warehouses.warehouseName AS WareHouse, count(mintclassics.products.warehouseCode) AS Variety_Products,
sum(mintclassics.products.quantityInStock)  as TotalStock, 
sum( mintclassics.products.quantityInStock * mintclassics.products.MSRP) as Estimaded_value,
CONCAT(
ROUND((sum(mintclassics.products.quantityInStock) / 
( SELECT SUM(mintclassics.products.quantityInStock) FROM mintclassics.products ) * 100 ),2 ), '%') AS porcentaje
FROM mintclassics.products inner join mintclassics.warehouses on mintclassics.products.warehouseCode= mintclassics.warehouses.warehouseCode
group by mintclassics.products.warehouseCode order by count(mintclassics.products.warehouseCode) DESC;

