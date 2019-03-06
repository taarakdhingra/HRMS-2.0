/*admin can add a particular type of leave ,for that all the details as well as conditions have to be given*/

create procedure pAdminInsertNewLeave @LeaveId int,@LeaveType varchar(100),
@MaxConsecutiveLeaves int,@TotalLeaves int,@Description varchar(1000),
	@Status INT OUTPUT,
	@Message VARCHAR(200) OUTPUT
AS 
BEGIN
insert into tLeaves values (@LeaveId,@LeaveType,@MaxConsecutiveLeaves,@TotalLeaves,@Description);
SET @Status = 1
SET @Message = 'Created New Leave'
END


DECLARE @Status INT, @Message VARCHAR(200)
EXEC pAdminInsertNewLeave @LeaveId=9,@LeaveType='BIRTHDAY LEAVE',
@MaxConsecutiveLeaves=1,@TotalLeaves=1,@Description='Birthday is a special occassion 
so enjoy your day as you want',@Status = @Status output ,@Message=@Message output 

