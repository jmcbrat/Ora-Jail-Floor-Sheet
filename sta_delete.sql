SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER Sta_Delete
    ON dbo.Statute
   FOR Delete
AS BEGIN  /* BEGIN Trigger Sta_Delete */

   IF (SELECT cnf_value 
         FROM RSys_Configuration
        WHERE cnf_name = 'Audit') = 'Y' 

      BEGIN  /* BEGIN Copy */

      INSERT LRMSAUDIT..Statute
      SELECT * FROM Deleted

      INSERT LRMSAUDIT..Statute(
         Sta_Statute_PK,
         Sta_Agency_ID,
         Sta_Audit_Dt,
         Sta_Audit_User,
         Sta_Audit_Action,
         Sta_Row_Status)
      SELECT 
         Sta_Statute_PK, 
         Sta_Agency_ID,
         GETDATE(),
         IsNull(USER_ID( SUSER_SNAME() ), 1),
         'D',
         'D' 
      FROM Deleted

      END  /* END Copy */

END  /* END Trigger Sta_Delete */

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

