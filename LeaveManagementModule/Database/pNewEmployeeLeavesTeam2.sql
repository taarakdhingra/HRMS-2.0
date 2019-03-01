

create procedure pNewEmployeeLeaves(@EmployeeId int)
AS
BEGIN
insert into tBalanceAccount values (@EmployeeId,15,0,0,0,0);
insert into tBalanceAccount values (@EmployeeId,2,10,0,0,0,0);
insert into tBalanceAccount values (@EmployeeId,3,15,0,0,0,0);
insert into tBalanceAccount values (@EmployeeId,4,84,0,0,0,0);
insert into tBalanceAccount values (@EmployeeId,5,3,0,0,0,0);
insert into tBalanceAccount values (@EmployeeId,6,5,0,0,0,0);
insert into tBalanceAccount values (@EmployeeId,1,7,NULL,0,0,0);
END

EXEC pNewEmployeeLeaves 9;






select * from tLeaves;
select * from tBalanceAccount;

