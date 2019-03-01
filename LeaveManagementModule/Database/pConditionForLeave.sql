
create procedure pConditionForLeave
@EmployeeId int,@LeaveId int,@StartDate DATE, @EndDate DATE

AS
BEGIN
declare @LeavesDiff int,@vForMax int,@vForLeavesTaken int,@vforBalance int;
set @vforBalance=(select Balance from tBalanceAccount where LeaveId=@LeaveId AND EmployeeId=@EmployeeId); 
set @LeavesDiff=DATEDIFF(Day,@StartDate,@EndDate);
set @vForMax=(select MaxConsecutiveLeaves from tLeaves where LeaveId=@LeaveId);




	if(@vforBalance-@LeavesDiff<0)
	BEGIN
	print 'Leaves Exhausted'
	END

	if(@LeavesDiff>@vForMax)
	BEGIN
	print 'Can not Apply for somany consecutive leaves';
	END

	else
BEGIN

 declare @odForBalance int,@odForLeavesTaken int
 EXEC pLeaveUpdate1 @EmployeeId,@LeaveId,@StartDate,@EndDate,@Reason='second procedure testing phase',
 @BalanceLeaveOut=@odForBalance output,@LeavesTakenOut=@odForLeavesTaken output;
END

END