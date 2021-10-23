




---23.10.2021 DAWSQL Session-4 Set Operators & Case Expresssion

---'Trek Remedy 9.8 -- 2019' urununun siparis verilmedigi state/state leri getiriniz.

SELECT *
FROM SALE.order_item



SELECT DISTINCT state
FROM	sale.customer X
WHERE	NOT EXISTS
					(
					SELECT A.product_id, A.product_name, B.product_id, B.order_id, C.order_id, C.customer_id, D.*
					FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
					WHERE	A.product_id = B.product_id
					AND		B.order_id = C.order_id
					AND		C.customer_id = D.customer_id
					AND		A.product_name = 'Trek Remedy 9.8 - 2019'
					AND		X.state = D.state
					)


SELECT A.product_id, A.product_name, B.product_id, B.order_id, C.order_id, C.customer_id, D.*
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id = B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = 'Trek Remedy 9.8 - 2019'





--------------CTE TYPES
------ORDINARY------------RECURSIVE


----Sharyn Hopkins isimli musterinin son siparisinden once siparis vermis
----ve San Diego sehrinde ikamet eden musterileri listeleyin.

WITH T1 AS
(
SELECT	max(order_date) last_purchase
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Sharyn'
AND		A.last_name = 'Hopkins'
)
SELECT	DISTINCT A.order_date, A.order_id, B.customer_id, B.first_name, B.last_name, B.city
FROM	sale.orders A, sale.customer B, T1
WHERE	A.customer_id = B.customer_id
AND		A.order_date < T1.last_purchase
AND		B.city = 'San Diego'



----List all customers who orders on the same dates as Abby Parks

WITH T1 AS
(
SELECT	order_date 
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name = 'Abby'
AND		A.last_name = 'Parks'
)
SELECT	A.order_date, A.order_id, B.first_name, B.last_name
FROM	sale.orders A, sale.customer B, T1
WHERE	A.customer_id = B.customer_id
AND		A.order_date = T1.order_date



------RECURSIVE

WITH T1 AS
(
SELECT 1 AS NUM
UNION ALL
SELECT NUM + 1
FROM T1
WHERE NUM < 9
)
SELECT *
FROM T1



------UNION
SELECT last_name
FROM sale.customer
WHERE city = 'Carter'

UNION

SELECT city
FROM sale.customer
WHERE city = 'Carter'
ORDER BY last_name


---2019, 2019 ve 2020 yillarinin hepsinde siparisi olan musterilerin isim ve soyismini getir


select cc.first_name, cc.last_name, oo.order_date
from sale.customer cc join sale.orders oo on cc.customer_id=oo.customer_id
where cc.customer_id in (
select c.customer_id
from sale.customer c join sale.orders o on c.customer_id=o.customer_id
where o.order_date between '2018-01-01' and '2018-12-31'
intersect
select c.customer_id
from sale.customer c join sale.orders o on c.customer_id=o.customer_id
where o.order_date between '2019-01-01' and '2019-12-31'
intersect
select c.customer_id
from sale.customer c join sale.orders o on c.customer_id=o.customer_id
where o.order_date between '2020-01-01' and '2020-12-31')