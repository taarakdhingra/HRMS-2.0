/*admin can delete a particular leave type completely depending upon shift in company's policies
 for example birthday leaves or paternal leaves */
create procedure pAdminDeleteLeave @LeaveId int
AS 
BEGIN
delete from tLeaves where LeaveId=@LeaveId;
END

EXEC pAdminDeleteLeave 8;


select * from tLeaves;