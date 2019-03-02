/*admin can change the no of days for a particular leave and max consecutive as well*/
create procedure pAdminLeaveUpdate @LeaveId int,@MaxConsecutiveLeaves int=null,@TotalLeaves int=null
as
begin
if(@MaxConsecutiveLeaves!=NULL AND @TotalLeaves=NULL)
/*IF ONLY MAXCONSECTUIVELEAVES IS CHANGES*/
BEGIN
update tLeaves set MaxConsecutiveLeaves=@MaxConsecutiveLeaves where LeaveId=@LeaveId;
END
IF(@TotalLeaves!=NULL AND @MaxConsecutiveLeaves=NULL)
/*WHEN ONLY total leaves of a particular id is changed*/
BEGIN
update tLeaves set TotalLeaves=@TotalLeaves where LeaveId=@LeaveId;
END
/*both are altered by the admin*/
if (@TotalLeaves!= NULL AND @MaxConsecutiveLeaves !=NULL)
BEGIN
update tLeaves set MaxConsecutiveLeaves=@MaxConsecutiveLeaves where LeaveId=@LeaveId;

update tLeaves set TotalLeaves=@TotalLeaves where LeaveId=@LeaveId;

END
END
/*un-comment the below statement to execute and see functioning of the procedure.
Once executed ,result could be seen in the respective table*/
/*
EXEC pAdminLeaveUpdate @LeaveId=1,@MaxConsecutiveLeaves=10,@TotalLeaves=15;*/