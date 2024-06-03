select *
from Scrumfit..['Data Base Scrum Fit$']
where ExerciseID is not null
Order by ExerciseID asc	

-- Equipment Table

CREATE TABLE Equipment_Table (
	EquipmentID INT  IDENTITY(1,1) PRIMARY KEY,
	Equipment nvarchar(50)
)

INSERT INTO Equipment_Table ([Equipment])
Select distinct [Equipment]
From Scrumfit..['Data Base Scrum Fit$']
where [Equipment] is not null

Select * 
From Equipment_Table

-- Exercise and Equipment Table

CREATE TABLE ExeEqui_Table (
ExerciseID INT, 
EquipmentID INT
)

INSERT INTO ExeEqui_Table (ExerciseID, EquipmentID)
SELECT ExerciseID, EquipmentID
FROM Scrumfit..['Data Base Scrum Fit$'] As SF
LEFT JOIN Scrumfit..Equipment_Table As ET
	ON SF.Equipment = ET.Equipment
Where SF.Equipment is not null 

Select *
From ExeEqui_Table 

-- Body Parts Table 

CREATE TABLE BodyParts_Table (
	BodyPartID INT  IDENTITY(1,1) PRIMARY KEY,
	Body_Part nvarchar(50)
)

INSERT INTO BodyParts_Table ([Body_Part])
SELECT distinct [Body_Part]
FROM Scrumfit..['Data Base Scrum Fit$']
WHERE [Body_Part] IS NOT NULL

SELECT *
FROM BodyParts_Table

-- Muscle Target Table

CREATE TABLE MuscleTarget_Table (
	MuscleTargetID INT  IDENTITY(1,1) PRIMARY KEY,
	Muscle_Target nvarchar(250),
	BodyPartID INT
)

INSERT INTO MuscleTarget_Table (Muscle_Target, BodyPartID)
SELECT DISTINCT  Muscle_Target, BodyPartID
FROM Scrumfit..['Data Base Scrum Fit$'] AS SF
LEFT  JOIN Scrumfit..BodyParts_Table AS BP
	ON SF.Body_Part = BP.Body_Part
WHERE SF.Muscle_Target IS NOT NULL

SELECT *
FROM MuscleTarget_Table
ORDER BY MuscleTargetID ASC

-- Exercise table 

CREATE TABLE Exercise_table (
	ExerciseID int,
	Exercise_Name nvarchar(250),
	EquipmentID int,
	BodyPartID int,
	MuscleTargetID int,
	Preparation nvarchar(500),
	Execution nvarchar(500)
)

INSERT INTO Exercise_table (ExerciseID, Exercise_Name, EquipmentID, BodyPartID, MuscleTargetID, Preparation, Execution)
SELECT DISTINCT SF.ExerciseID, SF.Exercise_Name, ET.EquipmentID, BP.BodyPartID, MT.MuscleTargetID, SF.Preparation, SF.Execution
FROM Scrumfit..['Data Base Scrum Fit$'] AS SF 
LEFT JOIN Scrumfit..Equipment_Table AS ET ON SF.Equipment = ET.Equipment
LEFT JOIN Scrumfit..BodyParts_Table AS BP ON SF.Body_Part = BP.Body_Part
LEFT JOIN Scrumfit..MuscleTarget_Table AS MT ON SF.Muscle_Target = MT.Muscle_Target
WHERE SF.ExerciseID IS NOT NULL

Select E.*, Q.Equipment
From Exercise_table As E
JOIN Equipment_Table AS Q
	on E.EquipmentID = Q.EquipmentID
