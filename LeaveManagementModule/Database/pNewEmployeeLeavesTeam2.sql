
/*used whenever a new employee logs in first time,he/she will be able to see the details of the leaves that they possess */
/* sent to team 1 so that they can call it whenever a new employee signs in from admin's assigned username*/

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

/*EXEC pNewEmployeeLeaves 9;*/

/*un-comment the above statement to execute and see functioning of the procedure.
Once executed ,result would be incorporated in the respective table*/
/*select * from pNewEmployeeLeaves*/





