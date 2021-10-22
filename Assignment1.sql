




CREATE TABLE assignment

(
Sender_ID int,
Receiver_ID int,
Amount int,
Transaction_Date date
)
;

SELECT * 
FROM assignment;


INSERT INTO assignment (Sender_ID, Receiver_ID, Amount, Transaction_Date)
VALUES (10, 100, 1000, '2021-10-22');



INSERT INTO assignment (Sender_ID)
VALUES (11), (22), (22), (23);     ---satir satir columna value gir


DROP TABLE assignment;

INSERT INTO assignment (Sender_ID, Receiver_ID, Amount, Transaction_Date)
VALUES
(55, 22, 500, '2021-05-18'),
(11, 33, 350, '2021-05-19'),
(22, 11, 650, '2021-05-19'),
(22, 33, 900, '2021-05-20'),
(33, 11, 500, '2021-05-21'),
(33, 22, 750, '2021-05-21'),
(11, 44, 300,  '2021-05-22')
;


SELECT Sender_ID, SUM(Amount) AS send_amount
FROM assignment
GROUP BY Sender_ID


SELECT Receiver_ID, SUM(Amount) AS received_amount
FROM assignment
GROUP BY Receiver_ID


SELECT *
FROM (
      SELECT Sender_ID, SUM(Amount) AS send_amount
      FROM assignment
      GROUP BY Sender_ID
	  ) S
FULL OUTER JOIN 
      (
	  SELECT Receiver_ID, SUM(Amount) AS received_amount
      FROM assignment
      GROUP BY Receiver_ID
	  ) R
ON S.Sender_ID = R.Receiver_ID





SELECT COALESCE (S.Sender_ID, R.Receiver_ID) AS Account_ID, 
       COALESCE (R.receive_amount, 0 ) - COALESCE(S.send_amount, 0) AS Net_Change
FROM (
      SELECT Sender_ID, SUM(Amount) AS send_amount
      FROM assignment
      GROUP BY Sender_ID
	  ) S
FULL OUTER JOIN 
      (
	  SELECT Receiver_ID, SUM(Amount) AS received_amount
      FROM assignment
      GROUP BY Receiver_ID
	  ) R
ON S.Sender_ID = R.Receiver_ID
;



SELECT	COALESCE(S.Sender_ID, R.Receiver_ID) AS Account_ID,
		COALESCE(R.receive_amount, 0) - COALESCE(S.send_amount, 0) AS Net_Change
FROM	(
		SELECT	Sender_ID, SUM(amount) AS send_amount
		FROM	assignment
		GROUP BY Sender_ID
		) S
FULL OUTER JOIN	
		(
		SELECT	Receiver_ID, SUM(amount) AS receive_amount
		FROM	assignment
		GROUP BY Receiver_ID
		) R
ON		S.Sender_ID = R.Receiver_ID
;



SELECT * 



