SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


create  TRIGGER Sta_Update
    ON Statute
   FOR Update
AS BEGIN  /* BEGIN Trigger BkgRel_Update */

   /* Update in-record audit info */
   UPDATE Statute
      SET Sta_Audit_Dt = GETDATE(),
          Sta_Audit_User = IsNull(USER_ID( SUSER_SNAME() ), 1),
          Sta_Audit_Action = 'U'
     FROM Statute A, Inserted I
    WHERE A.Sta_Statute_PK = I.Sta_Statute_PK
	
   /* Copy to Audit DB */
   IF (SELECT cnf_value 
         FROM RSys_Configuration
        WHERE cnf_name = 'Audit') = 'Y' 

      BEGIN  /* BEGIN Copy */

      INSERT LRMSAUDIT..Statute
      SELECT * FROM Deleted
		
      END  /* END Copy */

   /* Cascading logical delete */
   IF UPDATE(Sta_Row_Status) 

      BEGIN  /* BEGIN Cascading Delete */

      UPDATE Event_Statute
         SET EvnSta_Row_Status = 'D'
        FROM Event_Statute, Inserted
       WHERE EvnSta_Statute_FK = Sta_Statute_PK 
         AND Sta_Row_Status = 'D'

      UPDATE Statute_Detail
         SET StaDet_Row_Status = 'D'
        FROM Statute_Detail, Inserted
       WHERE StaDet_Statute_FK = Sta_Statute_PK 
         AND Sta_Row_Status = 'D'

      END  /* END Cascading Delete */

END  /* END Trigger Sta_Update */

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

