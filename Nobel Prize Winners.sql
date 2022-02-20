SELECT * FROM [dbo].[Nobel Prize Winners]

SELECT[Year],[Category],[Prize] FROM[dbo].[Nobel Prize Winners]

SELECT[Full Name],[Birth Date],[Birth City],[Birth Country],[Sex] FROM[dbo].[Nobel Prize Winners]

SELECT * 
FROM [Nobel Prize Winners]
WHERE Sex ='Female'
--There are 50 females who achieved Nobel Prize in the data.
SELECT *
FROM [Nobel Prize Winners]
WHERE Category = 'Physics'
/* There are 222 Nobel prizes 
announced in Physics in this data */
SELECT COUNT(Category)
FROM [Nobel Prize Winners]
WHERE Category = 'Physics'

SELECT * 
FROM [Nobel Prize Winners]
WHERE Sex ='Male'
/* while there are 50 females who got Nobel Prize, 
there are 893 males achieved this prize in the data */
SELECT COUNT(Category)
FROM [Nobel Prize Winners]
WHERE [Birth Country] = 'Canada'

SELECT [Full Name], [Category]
FROM [Nobel Prize Winners]
WHERE Category = 'Physics' OR Category = 'Chemistry'

SELECT [Full Name], [Category]
FROM [Nobel Prize Winners]
WHERE Category = 'Physics' AND Category = 'Chemistry'

SELECT [Full Name], [Category]
FROM [Nobel Prize Winners]
WHERE Category = 'Physics' AND Sex = 'Female'

SELECT [Full Name], [Category], [Prize Share]
FROM [Nobel Prize Winners]
WHERE Category = 'Physics' OR Category = 'Chemistry'

SELECT [Full Name], [Category], [Prize Share]
FROM [Nobel Prize Winners]
WHERE Category = 'Physics' AND [Birth Country] = 'Canada'

SELECT [Organization Name]
FROM [Nobel Prize Winners]
WHERE [Organization Name] = 'university'

SELECT [Organization Name]
FROM [Nobel Prize Winners]
WHERE [Organization Name] LIKE '%university%'

SELECT COUNT([Organization Country])
FROM [Nobel Prize Winners]
WHERE [Organization Country] LIKE 'a%'

SELECT [Organization Country]
FROM [Nobel Prize Winners]
WHERE [Organization Country] LIKE 'a%'

SELECT [Birth Country]
FROM [Nobel Prize Winners]
WHERE [Organization Name] LIKE '%university%'

SELECT [Category]
FROM [Nobel Prize Winners]
WHERE [Organization Country] LIKE 'a%'

SELECT distinct [Organization Country]
FROM [Nobel Prize Winners]
WHERE [Organization Country] LIKE 'a%'

--ONE LINE COMMENT

/* COMMENT FOR
MULTIPLE LINES THERE ARE FOUR COUNTRIES NAMES IN 
THE DATABASE STARTING FROM LETTER 'A' */
