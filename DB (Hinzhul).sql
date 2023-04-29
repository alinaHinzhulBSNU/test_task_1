-- Локалізація (для дати та часу)

SET LANGUAGE us_english;

-- Створення таблиць

CREATE TABLE Enquiries(
	InquiryID INT PRIMARY KEY NOT NULL,
	RegDate DATETIME NOT NULL,
	ContractID INT NOT NULL,
	InqTypeName VARCHAR(50),
);

CREATE TABLE Phones(
	ContractID INT NOT NULL, 
	Phone VARCHAR(15) NOT NULL,
	Status VARCHAR(9) NOT NULL,
	PRIMARY KEY (ContractID, Phone),
	CHECK (Status in ('actual','notactual'))
);

CREATE TABLE Revenue(
	ContractID INT NOT NULL,
	Period VARCHAR(8) NOT NULL,
	Rev FLOAT NOT NULL,
	PRIMARY KEY (ContractID, Period),
);

-- Заповнення створених таблиць даними для тестування скрипта

INSERT INTO Phones (ContractID, Phone, Status) VALUES (1, '0671112233', 'notactual');
INSERT INTO Phones (ContractID, Phone, Status) VALUES (1, '0951112233', 'actual');
INSERT INTO Phones (ContractID, Phone, Status) VALUES (2, '0674445566', 'actual');
INSERT INTO Phones (ContractID, Phone, Status) VALUES (3, '0677778899', 'actual');
INSERT INTO Phones (ContractID, Phone, Status) VALUES (4, '0956667788', 'actual');
INSERT INTO Phones (ContractID, Phone, Status) VALUES (4, '0971112233', 'actual');

INSERT INTO Revenue(ContractID, Period, Rev) VALUES (1, '20230418', 1000);
INSERT INTO Revenue(ContractID, Period, Rev) VALUES (2, '20230410', 350);
INSERT INTO Revenue(ContractID, Period, Rev) VALUES (2, '20230420', 750);
INSERT INTO Revenue(ContractID, Period, Rev) VALUES (3, '20230401', 700);
INSERT INTO Revenue(ContractID, Period, Rev) VALUES (3, '20230403', 700);
INSERT INTO Revenue(ContractID, Period, Rev) VALUES (4, '20230423', 500);

INSERT INTO Enquiries(InquiryID, RegDate, ContractID, InqTypeName) VALUES (1, '2023-04-05 22:55:54', 1, 'a');
INSERT INTO Enquiries(InquiryID, RegDate, ContractID, InqTypeName) VALUES (2, '2023-04-06 19:54:40', 1, 'b');
INSERT INTO Enquiries(InquiryID, RegDate, ContractID, InqTypeName) VALUES (4, '2023-04-07 17:55:00', 2, 'c');
INSERT INTO Enquiries(InquiryID, RegDate, ContractID, InqTypeName) VALUES (3, '2023-04-01 12:00:00', 2, 'a');
INSERT INTO Enquiries(InquiryID, RegDate, ContractID, InqTypeName) VALUES (5, '2023-04-10 20:00:00', 3, 'b');
INSERT INTO Enquiries(InquiryID, RegDate, ContractID, InqTypeName) VALUES (6, '2023-04-10 13:00:00', 4, 'c');
INSERT INTO Enquiries(InquiryID, RegDate, ContractID, InqTypeName) VALUES (7, '2023-04-27 10:15:00', 4, 'a');