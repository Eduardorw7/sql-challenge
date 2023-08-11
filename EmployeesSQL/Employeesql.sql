/*
CREATE TABLE departments(
	dept_no varchar(10) NOT NULL PRIMARY KEY,
	dept_name varchar(50)
);

CREATE TABLE titles (
	title_id varchar(10) NOT NULL PRIMARY KEY,
	title varchar(50)
);

CREATE TABLE employees(
	emp_no int NOT NULL PRIMARY KEY,
	emp_title_id varchar(8) NOT NULL,
	birth_date date,
	first_name varchar(50),
	last_name varchar(50),
	sex varchar(1),
	hire_date date
);

CREATE TABLE dept_emp(
	emp_no int NOT NULL,
	dept_no varchar(8) NOT NULL,
	FOREIGN KEY (emp_no)  REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE  dept_manager(
	dept_no varchar(8) NOT NULL,
	emp_no int NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries (
	emp_no int NOT NULL,
	salary int NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
*/
-- List employee nummber, last name, firt name, sex, and salary of each employee


SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no=s.emp_no


-- List the first name, last name , and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-1-1' and '1986-12-31'
ORDER BY hire_date ASC


-- List the manager of each department along with their department number,department name, employee number, last name, and first name.
 SELECT de.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
 FROM employees e
 JOIN dept_manager de
 ON e.emp_no = de.emp_no
 JOIN departments d
 ON de.dept_no = d.dept_no

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dep.dept_no, d.dept_name
FROM employees e
JOIN dept_emp dep
ON e.emp_no = dep.emp_no
JOIN departments d
ON dep.dept_no = d.dept_no


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'


-- List each employee in the Sales department, including their employee number,last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp dep
ON e.emp_no = dep.emp_no
JOIN departments d
ON dep.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'

--List each employee in the Sales and Development departments,including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp dep
ON e.emp_no = dep.emp_no
JOIN departments d
ON dep.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development')


--List the frequency counts, in descending order, of all the employee last names(that is, how many employees share each last name).

SELECT last_name, COUNT(emp_no) AS shared_last_name
FROM employees
GROUP BY last_name
ORDER BY shared_last_name ASC
