create proc [dbo].[usp_Get_AuditLogDefault]
as 
begin
SELECT 
                                            ISNULL(int_audit_log.login_id, '') AS 'Login ID',
                                            int_audit_log.application_id AS 'Application', 
                                            int_audit_log.device_name AS 'Location', int_audit_log.audit_dt AS 'Date', 
                                            int_mrn_map.mrn_xid AS 'Patient ID',
                                            int_misc_code.short_dsc AS 'Event', 
                                            int_audit_log.audit_descr AS 'Description' 
                                            FROM 
                                            int_audit_log 
                                            LEFT JOIN int_mrn_map 
                                                            ON int_audit_log.patient_id = int_mrn_map.mrn_xid 
                                            INNER JOIN int_misc_code 
                                                            ON int_misc_code.code=int_audit_log.audit_type
                                                            
end
