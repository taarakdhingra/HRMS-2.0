/*admin can delete a particular leave type completely depending upon shift in company's policies
 for example birthday leaves or paternal leaves */

create procedure pAdminDeleteLeave @LeaveId int,
@Status INT OUTPUT,
	@Message VARCHAR(200) OUTPUT
AS 
BEGIN
delete from tLeaves where LeaveId=@LeaveId;
SET @Status = 1 ;
		SET @Message = 'Leave Type Deleted Successfully'
END

DECLARE @Status INT, @Message VARCHAR(200)
EXEC pAdminDeleteLeave 8,@Status = @Status output ,@Message=@Message output;


select * from tLeaves;