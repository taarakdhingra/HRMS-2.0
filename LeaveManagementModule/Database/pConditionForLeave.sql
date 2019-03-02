/*procedure have certain conditions which must be fulfilled for an employee to raise a leave request.
calling another stored procedure named leave update where employee raises a leave request and records manipulation is done*/
create procedure pConditionForLeave
	@EmployeeId int,
	@LeaveId int,
	@StartDate DATE,
	@EndDate DATE,
	@Reason varchar(200),
	@Status INT OUTPUT,
	@Message VARCHAR(200) OUTPUT

AS
BEGIN
	declare @LeavesDiff int,@vMaximumConsecutiveLeaves int,@vForLeavesTaken int,@vforBalance int;
	set @vforBalance=(select Balance
	from tBalanceAccount
	where LeaveId=@LeaveId AND EmployeeId=@EmployeeId);

	
	if( DATEDIFF(Day,@StartDate,@EndDate) < 0 )
	BEGIN
		SET @Status = 0 
		SET @Message = 'Start date should be before end date'
		RETURN
	END

	set @LeavesDiff = DATEDIFF(Day,@StartDate,@EndDate) - dbo.fWeekendCount(@StartDate,@EndDate);
	set @vMaximumConsecutiveLeaves=(select MaxConsecutiveLeaves 
	from tLeaves 
	where LeaveId=@LeaveId);

	if( @vforBalance - @LeavesDiff < 0 )
	BEGIN
		SET @Status = 0 
		SET @Message = 'Not enough leaves left'
		RETURN
	END

	if(@LeavesDiff>@vMaximumConsecutiveLeaves)
	BEGIN
		SET @Status = 0
		SET @Message = 'Cannot apply for so many consecutive days'
		RETURN
	END

	else
	BEGIN

		declare @odForBalance int,@odForLeavesTaken int
		EXEC pLeaveUpdate1 @EmployeeId,@LeaveId,@StartDate,@EndDate,@Reason,
 		@BalanceLeaveOut=@odForBalance output,@LeavesTakenOut=@odForLeavesTaken output;
		SET @Status = 1
		SET @Message = 'Leave request raised'
		RETURN
	END

END
/*
 DECLARE @Status INT, @Message VARCHAR(200)
 EXEC pConditionForLeave @EmployeeId=1,@LeaveId=1, @StartDate='2019-01-19',@EndDate='2019-01-20',@Reason='attend function',@Status = @Status output ,@Message=@Message output
 SELECT @Status as 'Status',@Message as 'Message' 
 */

-- Drop the stored procedure called 'pConditionForLeave' 
-- DROP PROCEDURE pConditionForLeave
