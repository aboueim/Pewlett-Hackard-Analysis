# Pewlett-Hackard-Analysis

## Overview of Project

A manager at Pewlett-Hackard asked us to prepare two reports to help them identify the number of retiring employees per job title at this company, and specify employees who are eligible to participate in a mentorship program. In this project we utilize PostgreSQL, and through pgAdmin interface, extract relevant data using SQL statements and store them as tables in separate CSV files. In doing so, first, we create a database including employees, departments, and titles. Next, we write queries to collect data to create new tables that are filtered based on the criteria set for the reports. Finally, we will export the new tables in .csv format.

## Results

- Overall, 133,776 (from retirement_titles.cdv) employees could potentially retire at Pewlett-Hackard given their birth date and history of employment at the company.
- However, 72,458 (from unique_titles.csv) of these employees currently work at Pewlett-Hackard and are about to retire from their work.
- The retiring employees occupy 7 roles including Senior Engineer, Senior Staff, Engineer, Staff, Technique Leader, Assistant Engineer, and Manager.
- Senior engineers (25916 employees) and Senior Staffs (24926 employees) account for slightly more than %70 of retiring employees.
- 1549 employees who still work at Pewlett-Hackard are eligible for mentorship program.

## Summary: 

### How many roles will need to be filled as the "silver tsunami" begins to make an impact?

Given the results obtained, too many positions for 7 roles including Senior Engineer, Senior Staff, Engineer, Staff, Technique Leader, Assistant Engineer, and Manager will open in the near future. Majority of vacancies are for Senior Engineer and Senior Staff with 25916 and 24926 new opennings and thus may be of higher priority for new recruitments or successions. Of course, the high number of retirement in other roles also makes requires due attention. For example, filling leadership roles (technique leader with 3603 retiring employees) may also should be considered as a priority given the impact these roles have on firm performance.


### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

The results show that there are 529 Senior Engineers, 569 Seniro Staff, 190 Engineers, 29 Assisstant engineers, 155 Staff, and 77 Technique Leaders are eligible for mentorship programs, while there is no manager eligible for this program. Accordingly, except for manager role, there are roughly 50 retiring employees per each employee eligible for the mentorship program.


**QUERIES**: Below I provided two additional queries supporting my analysis for the upcoming "silver tsunami" at Pewlett-Hackard:

1. The number of employees eligible for mentorship program by title:

--Count of eligible mentors
SELECT COUNT(emp_no), title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC

2. Number of retiring employees per department and title (creates a table to store deprtments and titles data and then counts on employee numbers):

--create a retirement titles based on departments
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name,
	ti.title

INTO retire_dept_titles
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01')
ORDER BY emp_no;

SELECT COUNT(emp_no), dept_name, title
INTO retiring_dept_titles
FROM retire_dept_titles
GROUP BY dept_name, title
ORDER BY count DESC


