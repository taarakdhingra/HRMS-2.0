create view viewShowLeaveTrial(EmployeeId INT ) AS
select LeaveId,StartDate,EndDate,
Status from tEmployeeLeaves where EmployeeId=@EmployeeId;
select * from tBalanceAccount;


create view viewToEmployee(EmployeeId INT) AS
select LeaveId,Balance,LeavesTaken,Approved,Pending,Cancelled
from tBalanceAccount where EmployeeId=@EmployeeId;