



----COALESCE(), 
----NULLIF() ILK ARGUMAN IKINCIYE ESITSE IKINCISINI ALIR
----CAST()
----CONVERT()
----ROUND() SAYISI YUKARIYA YUVARLIYOR

SELECT CONVERT(DATETIME , '2021-10-10')


--------------COALESCE

SELECT COALESCE(NULL, NULL, 'DANIEL', NULL)


-------------ROUND

SELECT ROUND(432.368, 2)

SELECT ROUND(432.368, 3)

SELECT ROUND(432.368, 2, 1)

------Musterilerin maillri arasindan kac tanesi yahoo maildir?


select
sum(case when patindex('%@yahoo%', email) <> 0 and patindex('%@yahoo%', email) is not null then 1 else 0 end) as yahoo
from sale.customer


select count(*)
from sale.customer
where email like '%@yahoo%'

----eger yahoo paterni email icerisinden aiyorum ve index olarak getirmesini istiyorum

SELECT
SUM(CASE WHEN PATINDEX('%@yahoo%', email)<> 0 AND PATINDEX('%@yahoo%', email) is not null THEN 1 ELSE 0 END) AS mail
FROM sale.customer




select email, substring(email, 1, charindex('.', email) - 1) as left_part
from sale.customer


select email, left(email, charindex('.', email)-1)
from sale.customer


-----------add a new column to the customers table that contains the customers' contact information,
-----------if the phone is not null, the phone information will be printed, if not, the email information will be printed


select first_name, last_name, phone, email, coalesce(phone, email) as contact
from sale.customer



--------Write a query that returns streets. the third character of the streets is numerical


select street, substring(street, 3, 1)
from sale.customer
where SUBSTRING(street, 3, 1) like '{0-9]'

SELECT	street, SUBSTRING(street, 3, 1)
FROM	sale.customer
WHERE	SUBSTRING(street, 3, 1) LIKE '[^0-9]'


------WINDOWS FUNCTIONS

---urunlerin stock sayilarini bulunuz

select product_id, sum(quantity) CNT_STOCK
FROM	product.stock
group by product_id
order by 1

select product_id
from product.stock
group by product_id

select *, sum(quantity) over (partition by product_id)total_stock
from	product.stock




----------types of wf// analytic functions
--analytic aggregate functions
--analytic navigation function
--numbering functions


-------------what is the cheapest bike price?


Select min(list_price) over()
from	product.product


---------herbir kategorideki en ucuz bisiklet fiyati


select category_id, min(list_price) over(partition by category_id) as cheapest
from product.product


----analytic navigation function












