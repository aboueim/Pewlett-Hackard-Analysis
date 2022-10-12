--create a Retirement Titles table
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY (emp_no);


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;


-- Create a Retiring Table
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;


-- Create a Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    ti.title
--INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' and '1965-12-31')
ORDER BY e.emp_no, ti.to_date DESC;



Summary PArt

1. The number of employees eligible for mentorship program by title:

		--Count of eligible mentors
		SELECT COUNT(emp_no), title
		INTO mentorship_titles
		FROM mentorship_eligibility
		GROUP BY title
		ORDER BY count DESC;

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

		-- Number of retiring employees per depatment and title\
		SELECT COUNT(emp_no), dept_name, title
		INTO retiring_dept_titles
		FROM retire_dept_titles
		GROUP BY dept_name, title
		ORDER BY count DESC;
