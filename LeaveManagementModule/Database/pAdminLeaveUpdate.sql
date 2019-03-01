
create procedure pAdminLeaveUpdate @LeaveId int,@MaxConsecutiveLeaves int=null,@TotalLeaves int=null
as
begin

update tLeaves set MaxConsecutiveLeaves=@MaxConsecutiveLeaves where LeaveId=@LeaveId;
update tLeaves set TotalLeaves=@TotalLeaves where LeaveId=@LeaveId;
END


EXEC pAdminLeaveUpdate @LeaveId=1,@MaxConsecutiveLeaves=10,@TotalLeaves=15;