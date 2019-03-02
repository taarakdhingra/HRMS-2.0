/*admin can add a particular type of leave ,for that all the details as well as conditions have to be given*/


create procedure pAdminInsertNewLeave @LeaveId int,@LeaveType varchar(100),
@MaxConsecutiveLeaves int,@TotalLeaves int,@Description varchar(1000)
AS 
BEGIN
insert into tLeaves values (@LeaveId,@LeaveType,@MaxConsecutiveLeaves,@TotalLeaves,@Description);
END
/*
EXEC pAdminInsertNewLeave @LeaveId=8,@LeaveType='BIRTHDAY LEAVE',
@MaxConsecutiveLeaves=1,@TotalLeaves=1,@Description='Birthday is a special occassion 
so enjoy your day as you want. '
*/
