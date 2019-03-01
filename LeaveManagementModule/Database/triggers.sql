CREATE TRIGGER tForNewEmployees ON Employees
AFTER INSERT 
FOR EACH ROW
	@Id int,
 @LeaveId int,
 @LeaveType int,
 @TotalLeaves int
 AS BEGIN
 declare 
 @cLeaves CURSOR for SELECT Leaves.LeaveId,Leaves.LeaveType,Leaves.TotalLeaves FROM Leaves;
BEGIN 
SELECT @Id = INSERTED.Id FROM INSERTED  
OPEN cLeaves; 
   LOOP 
   FETCH cLeaves into @LeaveId,@LeaveType,@TotalLeaves; 
   INSERT INTO BalanceAccount values(@Id,@LeaveId,@TotalLeaves,0,0,0,0);
   END LOOP
   CLOSE cLeaves;
END
