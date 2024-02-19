--Mail:-

DECLARE @profile_name NVARCHAR(255) = 'amr gamal mohamed'
DECLARE @recipients NVARCHAR(255) = 'amrjamalmohamed@gmail.com'
DECLARE @subject NVARCHAR(255)
DECLARE @body NVARCHAR(MAX)

BEGIN TRY
    -- Send Success Notification
    SET @subject = 'Data Loading Process - Success'
    SET @body = 'Data has been successfully loaded from CSV files into the database.'

    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = @profile_name,
        @recipients = @recipients,
        @subject = @subject,
        @body = @body;
END TRY
BEGIN CATCH
    -- Send Failure Notification
    SET @subject = 'Data Loading Process - Failure'
    SET @body = 'There was an error while loading data from CSV files into the database.'

    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = @profile_name,
        @recipients = @recipients,
        @subject = @subject,
        @body = @body;
END CATCH;


