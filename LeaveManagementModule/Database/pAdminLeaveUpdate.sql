/*admin can change each record in the leave table indvidually and all at same time as well*/

create procedure pAdminLeaveUpdate @LeaveId int,@LeaveType varchar(200)=NULL,
@MaxConsecutiveLeaves int=null,@TotalLeaves int=null,
@Description varchar(1000)=NULL,@Status INT OUTPUT,
	@Message VARCHAR(200) OUTPUT
as
begin
if(@MaxConsecutiveLeaves!=NULL AND @TotalLeaves=NULL AND @LeaveType=NULL AND @Description=NULL)
/*IF ONLY MAXCONSECTUIVELEAVES IS CHANGES*/
BEGIN
update tLeaves set MaxConsecutiveLeaves=@MaxConsecutiveLeaves where LeaveId=@LeaveId;
SET @Status = 1 ;
		SET @Message = 'MAX LEAVES UPDATED'
END
IF(@TotalLeaves!=NULL AND @MaxConsecutiveLeaves=NULL AND @LeaveType=NULL AND @Description=NULL)
/*WHEN ONLY total leaves of a particular id is changed*/
BEGIN
update tLeaves set TotalLeaves=@TotalLeaves where LeaveId=@LeaveId;
SET @Status = 1 ;
		SET @Message = 'TOTAL LEAVES UPDATE'
END

IF(@TotalLeaves=NULL AND @MaxConsecutiveLeaves=NULL AND @LeaveType!=NULL AND @Description=NULL)
/*WHEN ONLY leave type of a particular id is changed*/
BEGIN
update tLeaves set LeaveType=@LeaveType where LeaveId=@LeaveId;
SET @Status = 1 ;
		SET @Message = 'LEAVE TYPE UPDATED'
END
IF(@TotalLeaves=NULL AND @MaxConsecutiveLeaves=NULL AND @LeaveType=NULL AND @Description!=NULL)
/*WHEN ONLY description of a particular id is changed*/
BEGIN
update tLeaves set Description=@Description where LeaveId=@LeaveId;
SET @Status = 1 ;
		SET @Message = 'DESCRIPTION UPDATED'
END

/*when all are altered by the admin*/
if (@TotalLeaves!= NULL AND @MaxConsecutiveLeaves !=NULL AND @LeaveType != NULL AND @Description != NULL)
BEGIN
update tLeaves set MaxConsecutiveLeaves=@MaxConsecutiveLeaves,TotalLeaves=@TotalLeaves,
LeaveType=@LeaveType,Description=@Description
 where LeaveId=@LeaveId;


SET @Status = 1 ;
		SET @Message = 'UPDATE SUCCESSFUL'

END
END
/*un-comment the below statement to execute and see functioning of the procedure.
Once executed ,result could be seen in the respective table*/
/* DECLARE @Status INT, @Message VARCHAR(200)
EXEC pAdminLeaveUpdate @LeaveId=1,@MaxConsecutiveLeaves=10,@TotalLeaves=15,@Status = @Status output ,@Message=@Message output;/*