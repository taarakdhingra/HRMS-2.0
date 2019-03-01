create procedure pAdminDeleteLeave @LeaveId int
AS 
BEGIN
delete from tLeaves where LeaveId=@LeaveId;
END

EXEC pAdminDeleteLeave 8;


select * from tLeaves;