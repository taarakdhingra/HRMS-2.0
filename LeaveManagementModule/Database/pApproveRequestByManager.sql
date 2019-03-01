create procedure pApproveReuestByManager
@EmployeeId int,@Status varchar(50),@StartDate DATE,@EndDate DATE,@LeaveId int

AS 
BEGIN
declare @vForBalance int,@vForLeavesTaken int,@vForApproved int,@vForCancelled int,@vForPending int;

SET @vForBalance= (select Balance from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForLeavesTaken= (select LeavesTaken from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForApproved= (select Approved from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForCancelled= (select Cancelled from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForPending=(select Pending from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
if (@Status='DECLINED')

BEGIN

UPDATE tBalanceAccount SET Balance=@vForBalance + (DATEDIFF(Day,@StartDate,@EndDate)) 
where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;

Update tBalanceAccount SET LeavesTaken=@vForLeavesTaken + (DATEDIFF(Day,@StartDate,@EndDate))
 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
 Update tBalanceAccount SET Cancelled=@vForCancelled+1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
Update tBalanceAccount SET Pending= @vForPending-1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
  END
 
  if(@Status='APPROVED')
 
  BEGIN
  Update tBalanceAccount SET Approved=@vForApproved+1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
  Update tBalanceAccount SET Pending= @vForPending-1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;

END 


END

EXEC pApproveReuestByManager
 @EmployeeId=1,@Status='DECLINED',@StartDate='2018-02-19',@EndDate='2018-02-25',@LeaveId=1;

 select * from tBalanceAccount;
 select * from tEmployeeLeaves;