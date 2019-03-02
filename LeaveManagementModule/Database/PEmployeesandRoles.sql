

CREATE PROCEDURE pEmployeesandRoles  @Projectid int
AS 
Begin
SELECT ProjectTeamDetails.ProjectID, Employee.FirstName, Employee.LastName,Employee.Email,
  ProjectRole.Role,Projects.Name
FROM (((ProjectTeamDetails
INNER JOIN Employee ON ProjectTeamDetails.EmployeeID = Employee.EmployeeId)
INNER JOIN ProjectRole ON ProjectTeamDetails.RoleID = ProjectRole.RoleID)
Inner JOIN Projects ON ProjectTeamDetails.ProjectID=Projects.ProjectID)
WHERE ProjectTeamDetails.ProjectID = @Projectid
End
 

EXEC pEmployeesandRoles 1;
EXEC pEmployeesandRoles 2;
 