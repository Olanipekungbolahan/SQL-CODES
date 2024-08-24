
Create procedure top_1k_Belgium

AS
Begin
		SELECT TOP (1000) [COUNTRY_ID]
			   ,[COUNTRY_NAME]
			    ,[REGION_ID]
			 FROM [Practice].[dbo].[Countries]#
			 Where Country_Name= 'Belgium';
End;

Exec top_1k_Belgium;