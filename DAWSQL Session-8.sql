





--1. Tum bisikletler arasinda en ucuz bisikletin adi (FIRST_VALUE fonksiyonunu kullaniniz)


SELECT FIRST_VALUE(product_name) OVER(ORDER BY list_price) AS F_V
FROM product.product


--2.Herbir kategorideki en ucuz bisikletin adi (FIRST_VALUE fonksiyonunu kullaniniz)

SELECT DISTINCT category_id,
		FIRST_VALUE(product_name) OVER(PARTITION BY category_id ORDER BY list_price) AS F_V
FROM product.product



--3. 1. maddeyi LAST_VALUE fonksiyonu kullanarak yapiniz

SELECT DISTINCT PRODUCT_NAME, list_price,
		last_value(product_name) OVER(ORDER BY list_price DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS F_V
FROM product.product






SELECT B.staff_id,B.first_name, B.last_name,A.order_id,A.order_date,
		Lead(A.order_date) OVER(PARTITION BY A.staff_id ORDER BY A.order_id) nex_order_date
FROM sale.staff B, sale.orders A
WHERE A.staff_id = B.staff_id
ORDER BY A.staff_id


SELECT category_id, list_price,
	ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) AS ROW_NUM,
		RANK() OVER(PARTITION BY category_id ORDER BY list_price) AS ROW_NUM1
FROM product.product






----Musterilerin siparis ettikleri urun sayilarinin kumulatip dagilimi


SELECT *
FROM SALE.orders

SELECT *
FROM SALE.order_item

WITH T1 AS
(
SELECT	A.customer_id, SUM(quantity) product_quantity   ---1 NUMARALARI CUSTOMER'IN SIPARISLERINDE VERDIGI TOPLAM URUN SAYISI 17
FROM	SALE.orders A, SALE.order_item B
WHERE	A.order_id = B.order_id
GROUP BY A.customer_id
)
SELECT product_quantity, ROUND(CUME_DIST() OVER(ORDER BY product_quantity), 2) CUML_DIST
FROM T1




with t1 as
(
SELECT A.customer_id, SUM(quantity) product_quantity
FROM sale.orders A, sale.order_item B
where A.order_id= B.order_id
GROUP BY A.customer_id
)
select customer_id, ntile(5) over ( order by product_quantity) group_dist
from t1
order by 1;


SELECT *
FROM
(SELECT DISTINCT order_id,
			AVG(list_price) OVER (PARTITION BY order_id)  AVG_LIST ,
			AVG(list_price*quantity*(1-discount)) OVER()  NET_AVG
FROM sale.order_item) C
WHERE AVG_LIST>NET_AVG



--------------Calculate the stores' weekly cumulative number of orders for 2018
---------------her magazada her haftada verilen siparis sayisi

SELECT	DISTINCT b.store_id, b.store_name, A.order_date, DATEPART(WEEK, order_date) weeks,
		COUNT(*) OVER(PARTITION BY b.store_id,  DATEPART(WEEK, A.order_date)) cnt_order_per_week,
		COUNT(*) over (partition by b.store_id order by datepart(week, A.order_date) cnt_cumulative
FROM	sale.orders A, SALE.store B
WHERE	A.store_id = B.store_id 
AND		YEAR(order_date) = 2018




SELECT	DISTINCT b.store_id, b.store_name, DATEPART(WEEK, A.order_date) weeks,
		COUNT (*) OVER (PARTITION BY B.store_id, DATEPART(WEEK, A.order_date)) cnt_order_per_week,
		COUNT (*) OVER (PARTITION BY B.store_id ORDER BY DATEPART(WEEK, A.order_date)) cnt_cumulative
FROM	sale.orders A, SALE.store B
WHERE	A.store_id = B.store_id
AND		YEAR(order_date) = 2018
