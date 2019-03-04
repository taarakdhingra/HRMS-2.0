create database PROJECTHRMS2;

create table tLeaves(LeaveId int primary key,LeaveType varchar(100),MaxConsecutiveLeaves int,TotalLeaves int,Description varchar(1000));
insert into tLeaves values(1,'Earned Leave',8,15,'These are earned leaves and the remaining ones are reimbursed at the end of the year,also called Privileged leaves');
insert into tLeaves values(2,'Casual Leave',3,10,'Casual leaves are provided to take care of urgent and unforeseen matters');
insert into tLeaves values(3,'Sick Leave',15,15,'Such leaves are taken when an employee gets sick');

insert into tLeaves values(4,'Maternity Leaves',84,84,'These leaves are entitled only for females and will be taken for a continuous period only');
insert into tLeaves(LeaveId,LeaveType,TotalLeaves,Description) values (5,'Bearevement Leaves',3,'Bearevement leaves are taken when there is a loss of family member of an employee');
insert into tLeaves values(6,'Marital Leave',5,5,'Provided in case of person getting married,have to be taken simultaneously');
 insert into tLeaves(LeaveId,LeaveType,Description) values(7,'Work From Home','Person does not neet to come at the office and can do work from the home itself');

 create table Employee(
    EmployeeId int identity(1,1) primary key,
    FirstName varchar(50),
    LastName varchar(50),
    Designation varchar(50),
    Email varchar(50),
    [Location] varchar(50),
    DateOfJoining date,
    DateOfBirth date,
    PastExperience int,
    Department varchar(50),
    [Status] varchar(10),
    ProfilePicUrl varchar(255)
)

insert into Employee (FirstName,LastName, Designation, Email, Location, DateOfJoining, DateOfBirth, PastExperience, Department, [status], ProfilePicUrl)
        values('Deepak', 'Pahuja', 'Intern', 'deepak.pahuja@cygrp.com', 'Noida' , '2019-01-07', '1996-12-19', 1, 'Technical', 'Active', 'url') 
insert into Employee (FirstName,LastName, Designation, Email, Location, DateOfJoining, DateOfBirth, PastExperience, Department, [status], ProfilePicUrl)
        values('Vidit', 'Mathur', 'Intern', 'vidit.mathur@cygrp.com', 'Noida' , '2019-01-07', '1997-10-11', 1, 'Technical', 'Active', 'url')
insert into Employee (FirstName,LastName, Designation, Email, Location, DateOfJoining, DateOfBirth, PastExperience, Department, [status], ProfilePicUrl)
        values('Gaurav', 'Singh', 'Intern', 'gaurav.singh@cygrp.com', 'Noida' , '2019-01-07', '1996-04-25', 1, 'Technical', 'Active', 'url') 
insert into Employee (FirstName,LastName, Designation, Email, Location, DateOfJoining, DateOfBirth, PastExperience, Department, [status], ProfilePicUrl)
        values('Srishty', 'rawat', 'Intern', 'srishty.rawat@cygrp.com', 'Noida' , '2019-01-07', '1996-10-30', 1, 'Technical', 'Active', 'url')  
insert into Employee (FirstName,LastName, Designation, Email, Location, DateOfJoining, DateOfBirth, PastExperience, Department, [status], ProfilePicUrl)
        values('Om', 'Prakash', 'Intern', 'ompraksah@cygrp.com', 'Noida' , '2019-01-07', '1995-02-05', 1, 'Technical', 'Active', 'url') 



		create table ProjectRole(RoleID int primary key identity(1,1), Role Varchar(50));
create table Projects(
ProjectID int primary key identity(1,1),
 Name Varchar(100), 
 Tenure int,
 Client Varchar(100), 
 Description Varchar(max),
 IsFinished bit,
 Progress int,
 DateAssigned date,
 isPipeline bit
 ); 
 
insert into ProjectRole values ('Project Owner');
insert into ProjectRole values ('CM');
insert into ProjectRole values ('Developers');
 
insert into Projects 
values('Paw Tree',
        2,
        'Roger Morgan',
        'You don’t like to eat the same food every day, and neither does your pet.PawTree a pet nutrition company,
         has debuted a first-of-its-kind product in the marketplace with its pawPairings Superfood Seasoning. Designed
         to add flavor variety and boost nutrition at meal time, pawTree created a line of seven superfood seasoning 
         medleys for dogs and cats.',
         0,
         65,
        '2018-07-26',
        0);
insert into Projects 
values('Stage Stores',
        5,
        'Michael L Glazer',
        'Stage Stores is a department store company specializing in retailing brand name apparel, accessories,
         cosmetics, footwear, and housewares throughout the United States.',
        0,
        55,
        '2017-08-02',
        0);


		create table ProjectTeamDetails(
    SNo int identity(1,1) primary key,
    ProjectID int  references Projects(ProjectID),
    EmployeeID int references Employee(EmployeeId),
    RoleID int  references ProjectRole(RoleID),
)
 
insert into ProjectTeamDetails 
values(
    1,
    2,
    3
)
insert into ProjectTeamDetails 
values(
    1,
    1,
    3
)
insert into ProjectTeamDetails 
values(
    1,
    3,
    2
)
insert into ProjectTeamDetails 
values(
    1,
    4,
    3
)
insert into ProjectTeamDetails 
values(
    1,
    5,
    1
)
insert into ProjectTeamDetails 
values(
    2,
    5,
    3
)
insert into ProjectTeamDetails 
values(
    2,
    3,
    1
)
insert into ProjectTeamDetails 
values(
    2,
    1,
    3
)

select * from Employee;

 create table tEmployeeLeaves(EmployeeId int foreign key references Employee(EmployeeId),
  LeaveId int foreign key references tLeaves(LeaveId),
  Status varchar(50),StartDate DATE,EndDate DATE,Reason varchar(1000),RequestTime datetime,ManagerId int );
  insert into tEmployeeLeaves values(1,1,'pending','2019-01-19','2019-01-15','attend function',getdate(),3);

  

   create table tBalanceAccount(EmployeeId int foreign key references Employee(EmployeeId),LeaveId int foreign key references tLeaves(LeaveId),
   Balance int,LeavesTaken int,Approved int,Pending int,Cancelled int)
 
insert into tBalanceAccount values(1,1,8,5,5,2,0);
insert into tBalanceAccount values(2,2,15,20,2,1,9);


select * from tLeaves;
select * from Employee;
select * from tEmployeeLeaves
select * from ProjectTeamDetails;
select * from tBalanceAccount;  
 