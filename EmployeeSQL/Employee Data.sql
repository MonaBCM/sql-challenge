drop table if exists employees;
drop table if exists salaries;
drop table if exists titles;
drop table if exists dept_manager;
drop table if exists dept_emp;
drop table if exists departments;

create table employees(emp_no integer not null,
					   emp_title_id character varying(45) not null,
					   birth_date character varying(45)  NOT NULL,
					   first_name character varying(45) NOT NULL,
					   last_name character varying(45) NOT NULL,
					   sex character(1) not null,
					   hire_date character varying(45)   NOT NULL,
					   primary key (emp_no),
					   foreign key(emp_title_id) references titles(title_id));
Select * from employees;

create table salaries(emp_no integer not null,
					 salary integer not null,
					 foreign key(emp_no) references employees(emp_no));
select * from salaries;

create table titles(title_id character varying(45) not null,
				   title character varying (45) not null,
				   primary key(title_id));
select * from titles;

create table departments(dept_no character varying(45) not null,
						dept_name character varying (45) not null,
						primary key(dept_no));
select * from departments;

create table dept_emp(emp_no integer not null, 
					  dept_no character varying(45) not null,
					  foreign key(emp_no) references employees(emp_no),
					  foreign key(dept_no) references departments(dept_no);
					  
select * from dept_emp; 

create table dept_manager(dept_no character varying(45) not null,
						 emp_no integer not null,
						 foreign key(emp_no) references employees(emp_no),
						 foreign key (dept_no) references departments(dept_no));
select * from dept_manager;
						 

					  
#1-List the employee number, last name, first name, sex, and salary of each employee.
Select * from employees;

Select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
From employees
Join salaries 
ON employees.emp_no=salaries.emp_no;

#2-List the first name, last name, and hire date for the employees who were hired in 1986.

Select * from employees;
SELECT employees.last_name, employees.first_name, employees.hire_date
From employees
WHERE hire_date >= '1/1/1986'and hire_date <'1/1/1987';

#3 List the manager of each department along with their department number, department name, employee number, last name, and first name.

Select dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
From dept_manager
Join employees
ON  dept_manager.emp_no = employees.emp_no
Join departments
ON dept_manager.dept_no= departments.dept_no;


#4 List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

Select  employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
From employees
Join dept_emp
ON employees.emp_no = dept_emp.emp_no
Join departments
ON dept_emp.dept_no=departments.dept_no;


#5 List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
Select  employees.last_name, employees.first_name, employees.sex
From employees
Where first_name = 'Hercules' and last_name Like 'B%';

#6 List each employee in the Sales department, including their employee number, last name, and first name.

Select  employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no,departments.dept_name
From employees
Join dept_emp
ON employees.emp_no = dept_emp.emp_no
Join departments
ON dept_emp.dept_no=departments.dept_no
Where dept_name = 'Sales';

#7 List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
Select  employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no,departments.dept_name
from employees
join dept_emp
ON employees.emp_no = dept_emp.emp_no
Join departments
ON dept_emp.dept_no=departments.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

#8 List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
Select employees.last_name, Count(*)
from employees
group by employees.last_name
order by Count(*) Desc;