



----gruoupb by yaparsak haftalara gore toplam siparisi bulucaz ama windows function da kumulatif toplami bulabiliriz


---1. question---Find the weekly order count for the city of San Angelo for the last 52 weeks, and also the cumulative total.
-----------------Desired output: [week_start, order_count, cuml_order_count]
SELECT DATEPART(WEEK, A.order_date), A.order_id  ---order date in week kismini alip buna gore gruplamalar yapicaz
FROM sale.orders A, sale.store B
WHERE A.store_id = B.store_id
	AND B.city = 'San Angelo'
	AND A.order_date BETWEEN DATEADD(WEEK, -52, '2020-12-28')  AND '2020-12-28'

;


SELECT	DATEPART(WEEK, A.order_date) as week_number, A.order_id,   ----yanina herbir haftanin toplamini ekledik, butun satirlara count order_id yaptik,
		COUNT(A.order_id) OVER(PARTITION BY DATEPART(WEEK, A.order_date)) AS week_total
FROM sale.orders A, sale.store B
WHERE A.store_id = B.store_id
	AND B.city = 'San Angelo'
	AND A.order_date BETWEEN DATEADD(WEEK, -52, '2020-12-28')  AND '2020-12-28'


SELECT DISTINCT	DATEPART(WEEK, A.order_date) as week_number, ---A.order_id,   ----kumulatif toplamda da 4. sutun eklicez, hafta numarasina gore toplam ne kadar 
		COUNT(A.order_id) OVER(PARTITION BY DATEPART(WEEK, A.order_date)) AS week_total,
		COUNT(A.order_id) OVER(ORDER BY DATEPART(WEEK, A.order_date)) cuml_total
FROM sale.orders A, sale.store B
WHERE A.store_id = B.store_id
	AND B.city = 'San Angelo'
	AND A.order_date BETWEEN DATEADD(WEEK, -52, '2020-12-28')  AND '2020-12-28'   ---benim yaptigimda ilk haftayi 2 kere aldi, neden olduguna tekrar bak!!!!!
	---TAMAM TAMAM BULDUM DISTINCT'I EKLEMEYI UNUTMUSUM EN BASA


	-----sonuc olarak
SELECT	DISTINCT DATEPART(WEEK, A.order_date) as week_number, --A.order_id,
		COUNT(A.order_id) OVER(PARTITION BY DATEPART(WEEK, A.order_date)) AS week_total,
		COUNT(A.order_id) OVER(ORDER BY DATEPART(WEEK, A.order_date)) cum_total
FROM	sale.orders A, sale.store B
WHERE	A.store_id = B.store_id
		AND B.city = 'San Angelo'
		AND A.order_date BETWEEN DATEADD(WEEK, -52, '2020-12-28') AND '2020-12-28'

;

SELECT MAX(order_date)
FROM sale.orders




-----2. QUESTION
/*
--In the street column, clear the string characters that were accidentally added to the end of the initial numeric expression.
--street sütununda baştaki rakamsal ifadenin sonuna yanlışlıkla eklenmiş string karakterleri temizleyin
--önce boşluğa kadar olan kısmı alınız
--sonra where ile sonunda harf olan kayıtları bulunuz
--bu harfi kaldırın
*/
SELECT	A.*, REPLACE(A.street, A.TARGET_CHARS, A.NUMERICAL_CHARS) new_column
FROM	(
		SELECT	street, 
				LEFT(street, CHARINDEX(' ', street) -1),
				RIGHT(LEFT(street, CHARINDEX(' ', street) -1), 1) AS STRING_CHARS,
				LEFT(street, CHARINDEX(' ', street) -2) AS NUMERICAL_CHARS
		FROM	sale.customer
		WHERE ISNUMERIC(RIGHT(LEFT(street, CHARINDEX(' ', street) -1), 1)) = 0

		) A   --BEN HATA ALIYORUM


-----BU DA CEVAP

SELECT	A.*, REPLACE(A.street, A.TARGET_CHARS, A.NUMERICAL_CHARS) new_column
FROM	(
		SELECT	street,
				LEFT(street, CHARINDEX(' ', street)-1) TARGET_CHARS,
				RIGHT(LEFT(street, CHARINDEX(' ', street)-1), 1) AS STRING_CHARS,
				LEFT(street, CHARINDEX(' ', street) -2) AS NUMERICAL_CHARS
		FROM	sale.customer
		WHERE	ISNUMERIC(RIGHT(LEFT(street, CHARINDEX(' ', street)-1), 1)) = 0
		) A