/*for generating leave request by the user*/
create procedure pInsertEmployeeLeaves

@EmployeeId int,
@LeaveId int,
@Status varchar(30),
@StartDate DATE,
@EndDate DATE,
@Reason varchar(200)

AS
BEGIN

declare @vForStoringRoleId int;
SET @vForStoringRoleId=(SELECT EmployeeID from ProjectTeamDetails where ProjectID IN
 (select ProjectID from ProjectTeamDetails where EmployeeID=@EmployeeId) AND RoleID =2);
insert into tEmployeeLeaves values(@EmployeeId,@LeaveId,@Status,@StartDate,@EndDate,@Reason,getdate(),@vForStoringRoleId);
END
/*un-comment the below statement to execute and see functioning of the procedure.
Once executed ,result could be seen in the respective table*/

/*EXEC pInsertEmployeeLeaves @EmployeeId=1,@LeaveId=1,@Status='pending',@StartDate='2018-02-03',@EndDate='2018-02-07',
@Reason='no work today';
EXEC pInsertEmployeeLeaves @EmployeeId=2,@LeaveId=2,@Status='approved',@StartDate='2019-01-06',@EndDate='2019-01-10',
@Reason='fever';*/

/*select * from tEmployeeLeaves*/




