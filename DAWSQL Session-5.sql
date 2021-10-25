




SELECT DISTINCT model_year
FROM	product.product
WHERE	brand_id = 5


-----Sadee 2019 yilinda siparis verilen diger yillarda siparis verulmeyen urunleri getiriniz


SELECT A.product_id, A.product_name
FROM product.product A
WHERE a.product_id IN (
			SELECT	A.product_id
			FROM	sale.order_item A, sale.orders B
			WHERE	A.order_id = B.order_id
			AND		YEAR(B.order_date) = '2019'
			EXCEPT
			SELECT	A.product_id
			FROM	sale.order_item A, sale.orders B
			WHERE	A.order_id = B.order_id
			AND		YEAR(B.order_date) != '2019'
			)



------Simple CASE Expresion

----Order_Status isimli alandaki degerlerin ne anlama geldigini iceren yeni bir alan olusturun

---1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed


SELECT	order_id, order_status,
		CASE order_status
			WHEN 1 THEN 'Pending'
			WHEN 2 THEN 'Processing'
			WHEN 3 THEN 'Rejected'
			ELSE 'Completed'
		END AS mean_of_status	
		
FROM SALE.orders
ORDER BY order_status


----------Staff tablosuna çalışanların mağaza isimlerini ekleyin.

-----1 = sacramento bikes, 2: buffalo bikes, 3: san angelo bikes

select first_name, last_name, store_id,
		case store_id
		when 1 then 'Sacramento Bikes'
		when 2 then 'Buffalo bikes'
		when 3 then 'San angelo bikes'
	end as store_name
from sale.staff






--Müşterilerin e-mail adreslerindeki servis sağlayıcılarını yeni bir sütun oluşturarak belirtiniz.


SELECT first_name, last_name, email,
	CASE 
	WHEN email LIKE '%gmail.com%' THEN 'GMAIL'
	WHEN email LIKE '%hotmail.com%' THEN 'HOTMAIL'
	WHEN email LIKE '%yahoo.com%' THEN 'YAHOO'
	ELSE 'Other'
	END AS email_service_provider
FROM sale.customer




-----------//////
-----Date Functions

---- Data Types
CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
	)


SELECT *
FROM t_date_time


SELECT CURRENT_TIMESTAMP = SELECT GETDATE()

---convert a varchar to date
SELECT CONVERT(DATE , '25 Oct 21' , 6)



-------convert a date to varchar
SELECT Getdate() as [now]
SELECT CONVERT(varchar , GETDATE() , 10)
----convert a varchar to date
SELECT CONVERT(DATE , '25 Oct 21', 1)
---------------
---Functions for return date or time parts
SELECT	A_date,
		DATENAME(DW, A_date) [DAY],
		DAY (A_date) [DAY2],
		MONTH(A_date),
		YEAR (A_date),
		A_time,
		DATEPART (NANOSECOND, A_time),
		DATEPART (MONTH, A_date)
FROM	t_date_time