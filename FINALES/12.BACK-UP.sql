


USE KOALASA;
GO

DECLARE @backupFileName NVARCHAR(250);
SET @backupFileName = 'C:\SQL-Backup\KOALASA_' + CONVERT(NVARCHAR(20), GETDATE(), 112) + '_' + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), ':', '') + '.bak';

BACKUP DATABASE [KOALASA] TO 
DISK = @backupFileName WITH  
DIFFERENTIAL,  DESCRIPTION = N'BackUp Diferencial',
NOFORMAT, NOINIT,  NAME = N'KOALASA-Diferencial Database Backup',
SKIP, NOREWIND, NOUNLOAD,  STATS = 10;
GO


USE KOALASA;
GO

DECLARE @backupFileName NVARCHAR(250);
SET @backupFileName = 'C:\SQL-Backup\KOALASA_' + CONVERT(NVARCHAR(20), GETDATE(), 112) + '_' + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), ':', '') + '.bak';

BACKUP DATABASE [KOALASA] 
TO DISK = @backupFileName 
WITH DESCRIPTION = N'BACK UP FULL', 
NOFORMAT, NOINIT, 
NAME = N'KOALASA-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO





USE msdb;
GO
DECLARE @IdJob UNIQUEIDENTIFIER;
DECLARE @NombreJOB NVARCHAR(128) = N'Backup_Diferencial_Job';
DECLARE @Descripcion NVARCHAR(MAX) = N'Este job realiza el backup diferencial cada 24 horas a partir de medianoche';
DECLARE @ComandoDiferencialBK NVARCHAR(MAX);
SET @ComandoDiferencialBK = N'
USE KOALASA;
DECLARE @backupFileName NVARCHAR(250);
SET @backupFileName = ''C:\SQL-Backup\KOALASA_'' + CONVERT(NVARCHAR(20), GETDATE(), 112) + ''_'' + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), '':'', '''') + ''.bak'';
BACKUP DATABASE [KOALASA] TO DISK = @backupFileName WITH DIFFERENTIAL, DESCRIPTION = N''BackUp Diferencial'', NOFORMAT, NOINIT, NAME = N''KOALASA-Diferencial Database Backup'', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
';

EXEC dbo.sp_add_job
    @job_name = @NombreJOB,
    @enabled = 1,
    @description = @Descripcion,
    @job_id = @IdJob OUTPUT;

EXEC dbo.sp_add_jobstep
    @job_id = @IdJob,
    @step_name = N'Backup Diferencial',
    @subsystem = N'TSQL',
    @command = @ComandoDiferencialBK,
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 1;

DECLARE @IDTareaDiferencial INT;
EXEC dbo.sp_add_jobschedule
    @job_id = @IdJob,
    @name = N'Diario_a_Medianoche',
    @freq_type = 4, 
    @freq_interval = 1,
    @active_start_time = 0, 
    @schedule_id = @IDTareaDiferencial OUTPUT;

EXEC dbo.sp_attach_schedule
    @job_id = @IdJob,
    @schedule_id = @IDTareaDiferencial;

EXEC dbo.sp_update_job
    @job_id = @IdJob,
    @enabled = 1;

PRINT 'Backup diferencial job creado y programado exitosamente.';
GO

USE msdb;
GO
DECLARE @IdJobFull UNIQUEIDENTIFIER;
DECLARE @NombreJOBFull NVARCHAR(128) = N'Backup_Full_Job';
DECLARE @DescripcionFull NVARCHAR(MAX) = N'Este job realiza el backup completo cada 24 horas a partir de medianoche';
DECLARE @ComandoFullBK NVARCHAR(MAX);
SET @ComandoFullBK = N'
USE KOALASA;
DECLARE @backupFileName NVARCHAR(250);
SET @backupFileName = ''C:\SQL-Backup\KOALASA_'' + CONVERT(NVARCHAR(20), GETDATE(), 112) + ''_'' + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), '':'', '''') + ''.bak'';
BACKUP DATABASE [KOALASA] TO DISK = @backupFileName WITH DESCRIPTION = N''BACK UP FULL'', NOFORMAT, NOINIT, NAME = N''KOALASA-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
';

EXEC dbo.sp_add_job
    @job_name = @NombreJOBFull,
    @enabled = 1,
    @description = @DescripcionFull,
    @job_id = @IdJobFull OUTPUT;

EXEC dbo.sp_add_jobstep
    @job_id = @IdJobFull,
    @step_name = N'Backup Full',
    @subsystem = N'TSQL',
    @command = @ComandoFullBK,
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 1;

DECLARE @IDTareaFull INT;
EXEC dbo.sp_add_jobschedule
    @job_id = @IdJobFull,
    @name = N'Diario_a_Medianoche',
    @freq_type = 4, 
    @freq_interval = 1,
    @active_start_time = 0, 
    @schedule_id = @IDTareaFull OUTPUT;

EXEC dbo.sp_attach_schedule
    @job_id = @IdJobFull,
    @schedule_id = @IDTareaFull;

EXEC dbo.sp_update_job
    @job_id = @IdJobFull,
    @enabled = 1;

PRINT 'Backup completo job creado y programado exitosamente.';
GO
