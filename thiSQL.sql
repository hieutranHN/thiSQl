create database EmployeeDB
go
use EmployeeDB
go
create table Department(
DepartId int primary key ,
DepartName varchar(50) not null ,
Description varchar(100) not null 
)
create table Employee(
EmpCode char(6) primary key ,
FirstName varchar(30) not null,
LastName varchar(30) not null,
Birthday smalldatetime not null,
Gender Bit Default '1',
[Address] varchar(100),
DepartID int foreign key references Department(DepartId),
Salary money 
)
select * from Employee
alter table Employee
drop column Gender;
--cau 1:
insert into Department
values
('1','nhan su','tuyen nhan vien'),
('2','hanh chinh','to chuc,quan ly'),
('3','marketing',' thu hut và duy tri su tuong tac')

insert into Employee
values
('10','Tran','Hieu','1999/02/08','1','Ha Noi','1','1000'),
('11','Nguyen','Hanh','1998/10/10','0','Hai Phong','2','9050'),
('12','Le','Phuc','1997/12/12','1','Bac Ninh','3','8720'),


--cau 2 :
update Employee
set Salary = Salary * 1.1 
-- cau 3:
alter table Employee
add constraint Luonglonhonkhong check(Salary > 0 )
-- cau 4:
create trigger tg_chkBirthday
on Employee
after insert , update
as
begin 
     if exists (select 1 from inserted where birthday <=23)
     begin raiserror('value of birthday column must be greater than 23',16,1);
     rollback transaction ;
    end
end



--cau 5 :
create index IX_hanhchinh
on Department(DepartName);

-- cau 6 :
create view view_emp 
as
select       Employee.EmpCode, Employee.FirstName, Employee.LastName, Department.DepartName
from         Department join
             Employee on Department.DepartId = Employee.DepartID

-- cau 7 :
create procedure sp_getAllEmp @DepartId int
as
BEGIN
SELECT *FROM Employee e
WHERE e.DepartID = @DepartId
END

-- cau 8 :
create proc sp_delDept @EmpCode char(6)
as
BEGIN
DELETE FROM Employee 
WHERE EmpCode=@EmpCode
end
exec sp_getAllEmp 1




