

create view viewUserLeaveDetail AS
select tBalanceAccount.EmployeeId,tLeaves.LeaveId,tLeaves.LeaveType,tEmployeeLeaves.StartDate,
tEmployeeLeaves.EndDate,tEmployeeLeaves.Status from tBalanceAccount 
INNER JOIN
tLeaves ON tLeaves.LeaveId=
tBalanceAccount.LeaveId
INNER JOIN
tEmployeeLeaves on tBalanceAccount.LeaveId=tEmployeeLeaves.LeaveId;


create function fUserLeaveDetail(@EmployeeId int,@LeaveId int)
returns TABLE
AS
RETURN 
select tBalanceAccount.EmployeeId,tLeaves.LeaveId,tLeaves.LeaveType,tEmployeeLeaves.StartDate,
tEmployeeLeaves.EndDate,tEmployeeLeaves.Status from tBalanceAccount 
INNER JOIN
tLeaves ON tLeaves.LeaveId=
tBalanceAccount.LeaveId	
INNER JOIN
tEmployeeLeaves on tBalanceAccount.LeaveId=tEmployeeLeaves.LeaveId 
AND tEmployeeLeaves.EmployeeId=tBalanceAccount.EmployeeId 
where tBalanceAccount.EmployeeId=@EmployeeId AND tEmployeeLeaves.LeaveId=@LeaveId;

select * from fUserLeaveDetail(2,2);

create function fUserLeaveBalance(@EmployeeId int)
returns TABLE
as 
RETURN
select LeaveId,Balance,LeavesTaken,Approved,Pending,Cancelled
from tBalanceAccount where EmployeeId=@EmployeeId ;


select * from fUserLeaveBalance(1);

create function fCMLeaveStatus(@ManagerId int)
returns TABLE
as 
RETURN
select EmployeeId,LeaveId,RequestTime,StartDate,EndDate 
from tEmployeeLeaves
where ManagerId=@ManagerId ;

select * from fCMLeaveStatus(3);

create function fCMLeaveStatusPending(@ManagerId int)

returns TABLE
as 
RETURN
select EmployeeId,LeaveId,RequestTime,StartDate,EndDate 
from tEmployeeLeaves
where ManagerId=@ManagerId AND  Status='pending' ;

select * from fCMLeaveStatusPending(3);

create function fCMLeaveStatusApproved(@ManagerId int)

returns TABLE
as 
RETURN
select EmployeeId,LeaveId,RequestTime,StartDate,EndDate 
from tEmployeeLeaves
where ManagerId=@ManagerId AND Status='approved' ;










select * from tBalanceAccount;
select * from tEmployeeLeaves
select * from tLeaves;
select * from Employee;
 



create view viewShowLeaveTrial(@EmployeeId INT ) AS
select LeaveId,StartDate,EndDate,Status
 from tEmployeeLeaves where EmployeeId=@EmployeeId;
select * from tBalanceAccount;


create view viewToEmployee(EmployeeId INT) AS
select LeaveId,Balance,LeavesTaken,Approved,Pending,Cancelled
from tBalanceAccount where EmployeeId=@EmployeeId;
select * from tBalanceAccount;
select * from tLeaves;
select * from tEmployeeLeaves;