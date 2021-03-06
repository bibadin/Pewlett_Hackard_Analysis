--Create Retirement Titles Table of current employees
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO ret_title_current_emp
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no=ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM ret_title_current_emp as rt
ORDER BY rt.emp_no, rt.to_date DESC;
--Retrieve number of employees by most recent job title
--Retrieve number of titles from Unique Titles table
SELECT COUNT (ut.title), ut.title
--Create retiring title table
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;
--Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (e.emp_no)e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no=de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no=ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01'AND '1965-12-31')
ORDER BY e.emp_no DESC;
--Provide Mentorship Title Count
SELECT (me.emp_no),
	me.first_name,
	me.last_name,
	me.title
FROM mentorship_eligibility as me
ORDER BY me.emp_no, me.to_date DESC;
SELECT COUNT (me.title), me.title
FROM mentorship_eligibility AS me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;