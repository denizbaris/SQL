
-------------SQL SESSION 6


CREATE TABLE [dbo].[t_date_time](
	[A_time] [time](7) NULL,
	[A_date] [date] NULL,
	[A_smalldatetime] [smalldatetime] NULL,
	[A_datetime] [datetime] NULL,
	[A_datetime2] [datetime2](7) NULL,
	[A_datetimeoffset] [datetimeoffset](7) NULL
) ON [PRIMARY]
GO




SELECT A_time, A_date, GETDATE(),
		DATEDIFF(MINUTE, A_time, GETDATE() ) AS MINUTE_DIFF
		DATEDIFF(WEEK, A_date, '2021-11-30')
FROM t_date_time

-----

SELECT DATEDIFF(DAY, shipped_date, order_date) DATE_DIFF, order_date, shipped_date
FROM sale.orders



SELECT order_date,
       DATEADD(YEAR, 5 ,order_date) YEAR_ADD,
	   DATEADD(DAY,10, order_date) DAY_ADD,
	   DATEADD(HOUR, 5, GETDATE()) GET_ADD
FROM sale.orders



---EOMONTH

SELECT EOMONTH(GETDATE()), EOMONTH(GETDATE(), 2)



-----ISDATE
----DATE TIPINDE MI YOKSA DEGIL MI CHECK EDIYOR DEGILSE 0 DONDURUYOR


SELECT ISDATE('2021-10-01')

SELECT ISDATE('SELECT')


--Orders tablosuna siparişlerin teslimat hızıyla ilgili bir alan ekleyin.
--Bu alanda eğer teslimat gerçekleşmemişse 'Not Shipped',
--Eğer sipariş günü teslim edilmişse 'Fast',
--Eğer siparişten sonraki iki gün içinde teslim edilmişse 'Normal'
--2 günden geç teslim edilenler ise 'Slow'
--olarak her bir siparişi etiketleyin.

WITH T1 AS
(
SELECT *,
		DATEDIFF(DAY, order_date, shipped_date) DIFF_SHIPPED_AND_ORDER
FROM sale.orders
)

SELECT ORDER_DATE,
		shipped_date,

		CASE WHEN DIFF_SHIPPED_AND_ORDER IS NULL THEN 'Not Shipped'
		 WHEN DIFF_SHIPPED_AND_ORDER = 0 THEN 'Fast'
		 WHEN DIFF_SHIPPED_AND_ORDER <= 2 THEN 'Normal'
		 WHEN DIFF_SHIPPED_AND_ORDER = 2 THEN 'Slow'
	END AS Order_Label

FROM T1




-----Another Solition
select  order_id,  DATEDIFF ( day, order_date, shipped_date) DATE_DIFF,
		CASE
		WHEN shipped_date is null THEN 'Not Shipped'
		WHEN DATEDIFF ( day, order_date, shipped_date) = 0 THEN 'Fast'
		WHEN DATEDIFF ( day, order_date, shipped_date) <3 THEN 'Normal'
		WHEN DATEDIFF ( day, order_date, shipped_date) > 2 THEN 'Slow'
		END AS Labels
from sale.orders


select  order_id,  DATEDIFF ( day, order_date, shipped_date) DATE_DIFF,
		CASE
		
		WHEN DATEDIFF ( day, order_date, shipped_date) > 2 THEN 'SHOW'
		
		END AS Labels
from sale.orders


select * from 
sale.orders o join 
(select order_id, datediff(day, order_date, shipped_date) as gun
from sale.orders
where datediff(day, order_date, shipped_date) > 2) as a on o.order_id=a.order_id





SELECT *, DATEDIFF(DAY, order_date, shipped_date) DATE_DIFF
FROM	sale.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) >2

------Yukaridaki siparislerin haftanin gunlerine gore dagilimini hesaplayiniz


select SUM(TT.a), SUM(TT.b), SUM(TT.c), SUM(TT.d), SUM(TT.e), SUM(TT.f), SUM(TT.g)
from 
(select case when datename(weekday, T1.order_date) = 'Monday' then 1 else 0 end a,
case when datename(weekday, T1.order_date) = 'Tuesday' then 1 else 0 end b,
case when datename(weekday, T1.order_date) = 'Wednesday' then 1 else 0 end c,
case when datename(weekday, T1.order_date) = 'Thursday' then 1 else 0 end d,
case when datename(weekday, T1.order_date) = 'Friday' then 1 else 0 end e,
case when datename(weekday, T1.order_date) = 'Saturday' then 1 else 0 end f,
case when datename(weekday, T1.order_date) = 'Sunday' then 1 else 0 end g
from
(select *, datediff(day, order_date, shipped_date) as gun
from sale.orders
where datediff(day, order_date, shipped_date) > 2) as T1) as TT

-----------------------

SELECT	SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Monday' THEN 1 END) MONDAY,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Tuesday' THEN 1 END) Tuesday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Wednesday' THEN 1 END) Wednesday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Thursday' THEN 1 END) Thursday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Friday' THEN 1 END) Friday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Saturday' THEN 1 END) Saturday,
		SUM(CASE WHEN DATENAME(WEEKDAY, order_date) = 'Sunday' THEN 1 END) Sunday
FROM	sale.orders
WHERE	DATEDIFF(DAY, order_date, shipped_date) > 





------------------------------------

--CHARINDEX
SELECT CHARINDEX('C', 'CHARACTER')
SELECT CHARINDEX('C', 'CHARACTER', 2)
SELECT CHARINDEX('CT%', 'CHARACT%ER')
--PATINDEX
SELECT PATINDEX('R' , 'CHARACTER')
SELECT PATINDEX('R%' , 'CHARACTER')
SELECT PATINDEX('%R%' , 'CHARACTER')
SELECT PATINDEX('%R' , 'CHARACTER')
SELECT PATINDEX('___R%' , 'CHARACTER')


---------LEFT

SELECT LEFT ('CHARACTER', 3)


--------RIGHT

SELECT RIGHT ('CHARACTER', 4)



-----SUBSTRING, 1 DEN ITIBAREN BASLIYOR

SELECT SUBSTRING ('CHARACTER', -1,3)

SELECT SUBSTRING ('CHARACTER', 2,3)


------LOWER

SELECT LOWER('CHARACTER')


------UPPER

SELECT UPPER('CHARACTER')


SELECT UPPER(LEFT('character',1))+LOWER(SUBSTRING('character',2,LEN('character')))


-------string_split

SELECT * FROM string_split('JASON,MATTHEW,FREDERICK' , ',')


------TRIM(), LTRIM(), RTRIM()  -- BOSLKLARI ATAR

SELECT TRIM(' %& ' FROM   'CHARACTER   %&  ')


SELECT LTRIM('     CHAR     ')


SELECT RTRIM('        CHAR     ')

