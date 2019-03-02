/* whenever a user raises a leave request ,it will alter the balance and the leaves taken of an employee for
that particular leave type */
/*NOT an independent procedure,this procedure has been executed in the condition of leave as before generating a 
leave request ,filters like max consecutive leaves ,balance must be satisfied*/
create procedure pLeaveUpdate1 

@EmployeeId int,@LeaveId int , @StartDate DATE, @EndDate DATE,@Reason varchar(200),
@BalanceLeaveOut int output,
@LeavesTakenOut int output

AS 
BEGIN
DECLARE @vForBalance int,@vForLeavesTaken int;
SET @vForBalance=(select Balance from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForLeavesTaken=(select LeavesTaken from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);

/*for updating table,datediff used to know the no of leaves being taken*/
Update tBalanceAccount set Balance= @vForBalance-(DATEDIFF(Day,@StartDate,@EndDate) - dbo.fWeekendCount(@StartDate,@EndDate))  where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
set @BalanceLeaveOut=@vForBalance;
Update tBalanceAccount set LeavesTaken= @vForLeavesTaken +  (DATEDIFF(Day,@StartDate,@EndDate) - dbo.fWeekendCount(@StartDate,@EndDate)) where EmployeeId=@EmployeeId AND LeaveId=@LeaveId ;
set @LeavesTakenOut=@vForLeavesTaken;
Update tEmployeeLeaves set Reason=@Reason where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
insert into tEmployeeLeaves(EmployeeId,LeaveId,Status,StartDate,EndDate,RequestTime) 
values(@EmployeeId,@LeaveId,'pending',@StartDate,@EndDate,GETDATE()) 
END

/*declare @odForBalance int,@odForLeavesTaken int
 EXEC pLeaveUpdate1 @EmployeeId=2,@LeaveId=2,@StartDate='2017/08/20',@EndDate='2017/08/28',@Reason='testing',
 @BalanceLeaveOut=@odForBalance output,@LeavesTakenOut=@odForLeavesTaken output;*/
 /*please un-comment the above statement ,to execute it.changes would be shown in the table*/
 
--  select * from tEmployeeLeaves;
--  select * from tBalanceAccount;

