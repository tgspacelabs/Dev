create procedure MS_PerfDashboard.usp_DBFileIO
as
begin
	select
		m.database_id,
		db_name(m.database_id) as database_name,
		m.file_id,
		m.name as file_name, 
		m.physical_name, 
		m.type_desc,
		fs.num_of_reads, 
		fs.num_of_bytes_read, 
		fs.io_stall_read_ms, 
		fs.num_of_writes, 
		fs.num_of_bytes_written, 
		fs.io_stall_write_ms
	from sys.dm_io_virtual_file_stats(NULL, NULL) fs
		join sys.master_files m on fs.database_id = m.database_id and fs.file_id = m.file_id
end
