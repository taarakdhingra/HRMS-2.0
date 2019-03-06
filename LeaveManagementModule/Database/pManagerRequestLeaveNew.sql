
create procedure pManagerRequestLeave
@EmployeeLeavesId INT,
@Action Varchar(50),@Status INT OUTPUT,
	@Message VARCHAR(200) OUTPUT
AS 
BEGIN

declare @vForBalance int,@vForLeavesTaken int,@vForApproved int,@vForCancelled int,@vForPending int,
@EmployeeId int,@StartDate DATE,@EndDate DATE,@LeaveId int,@PrevStatus VARCHAR(50)


Select @EmployeeId=EmployeeId,@StartDate=StartDate,@EndDate=EndDate,@PrevStatus=Status,@LeaveId=LeaveId 
from tEmployeeLeaves where EmployeeLeavesId=@EmployeeLeavesId; 
/*SET @vForBalance= (select Balance from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForLeavesTaken= (select LeavesTaken from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForApproved= (select Approved from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForCancelled= (select Cancelled from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);
SET @vForPending=(select Pending from tBalanceAccount where EmployeeId=@EmployeeId AND LeaveId=@LeaveId);*/

select @vForBalance=Balance,@vForLeavesTaken=LeavesTaken,@vForApproved=Approved,
@vForCancelled=Cancelled,@vForPending=Pending
 from tBalanceAccount 
 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;

if(@PrevStatus = 'DECLINED' OR @PrevStatus = 'APPROVED')
BEGIN
SET @Status = 0
SET @Message = 'Already Resolved'
RETURN 
END

if (@Action='DECLINED')

BEGIN

UPDATE tBalanceAccount SET Balance=@vForBalance + (DATEDIFF(Day,@StartDate,@EndDate)) 
where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;

Update tBalanceAccount SET LeavesTaken=@vForLeavesTaken + (DATEDIFF(Day,@StartDate,@EndDate))
where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
Update tBalanceAccount SET Cancelled=@vForCancelled+1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
Update tBalanceAccount SET Pending= @vForPending-1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
SET @Status = 0 
		SET @Message = 'Leave request is declined'
  END
 
  if(@Action='APPROVED')
 
  BEGIN
  Update tBalanceAccount SET Approved=@vForApproved+1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
  Update tBalanceAccount SET Pending= @vForPending-1 where EmployeeId=@EmployeeId AND LeaveId=@LeaveId;
  SET @Status = 1
		SET @Message = 'Leave request is apporved'
END 


END

/*DECLARE @Status INT, @Message VARCHAR(200)
EXEC pManagerRequestLeave @EmployeeLeavesId=2,@action='approved',
@Status = @Status output ,@Message=@Message output;*/