WITH ActualPhones AS 
-- Вибір одного актуального номеру телефону для кожного абонента 
(
	SELECT ContractID, MIN(Phone) AS Phone 
	FROM Phones WHERE Status = 'actual'
	GROUP BY ContractID
),

InqCount AS 
-- Кількість звернень за останні 30 днів для кожного абонента
(
	SELECT ContractID, COUNT(InquiryID) AS InqCount 
	FROM Enquiries
	WHERE DATEDIFF(day, RegDate, GETDATE()) between 0 and 30
	GROUP BY ContractID
),

InqPeriod AS
-- Проміжок часу між першим та останнім зверненням за останні 30 днів
(
	SELECT	ContractID, 
			DATEDIFF(day, MIN(RegDate), MAX(RegDate)) AS InqDatesDiff
	FROM Enquiries
	WHERE DATEDIFF(day, RegDate, GETDATE()) between 0 and 30
	GROUP BY ContractID
),

InqRecent AS
-- Дата та тип останнього звернення
(
	SELECT ContractID, RegDate AS RecentInqDate, InqTypeName AS RecentInqType
	FROM Enquiries
	WHERE RegDate = 
	(
		SELECT MAX(RegDate) 
		FROM Enquiries AS enq 
		WHERE Enquiries.ContractID = enq.ContractID 
		GROUP BY ContractID
	)
),

RevSum AS
-- Сумарні нарахування за договором за останні 30 днів
(
	SELECT ContractID, SUM(Rev) AS InqRevSum
	FROM Revenue
	WHERE DATEDIFF(day, CONVERT(date, Period), GETDATE()) between 0 and 30
	GROUP BY ContractID
)

-- РЕЗУЛЬТАТ
SELECT	ActualPhones.ContractID, 
		InqCount, 
		RecentInqDate, 
		RecentInqType, 
		InqDatesDiff, 
		Phone, 
		InqRevSum
FROM ActualPhones
JOIN InqCount ON ActualPhones.ContractID = InqCount.ContractID
JOIN InqPeriod ON InqPeriod.ContractID = InqCount.ContractID
JOIN InqRecent ON InqPeriod.ContractID = InqRecent.ContractID
JOIN RevSum ON InqRecent.ContractID = RevSum.ContractID;