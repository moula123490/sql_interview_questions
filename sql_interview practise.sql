select * from student;
select * from program;
select * from scholarship;

--1. Write a SQL query to fetch "FIRST_NAME" from the Student table in upper case and use ALIAS name as STUDENT_NAME.

select upper(FIRST_NAME) as STUDENT_NAME from student;

--2. Write a SQL query to fetch unique values of MAJOR Subjects from Student table.
select * from student;

select distinct(major) from student;
--or
select major from student group by major;

/*
Explanation:
The DISTINCT keyword ensures that only unique values from the MAJOR column are retrieved, 
removing duplicates and providing a clean list of all subjects.
*/

--3. Write a SQL query to print the first 3 characters of FIRST_NAME from Student table.
select * from student;
select substr(FIRST_NAME,1,3) from student;
/*
Explanation:
The SUBSTRING() function extracts a portion of the string. Here, the function starts at position 1 
and retrieves the next 3 characters from FIRST_NAME.
*/

--4. Write a SQL query to find the position of alphabet ('a') int the first name column 'Shivansh' from Student table.
select * from student;

select instr(lower(first_name),'a') from student where first_name='Shivansh';
/*
Explanation:

The INSTR()function finds the position of the first occurrence of the specified character ('a') in the string. 
For the name 'Shivansh', 'a' is at the 5th position.
*/

--5. Write a SQL query that fetches the unique values of MAJOR Subjects from Student table and print its length.

select * from student;

select major,length(major) from student group by major;


--6. Write a SQL query to print FIRST_NAME from the Student table after replacing 'a' with 'A'.

select replace(lower(FIRST_NAME),'a','A') from student;

--7. Write a SQL query to print the FIRST_NAME and LAST_NAME from Student table into single column COMPLETE_NAME.

select FIRST_NAME||' '||LAST_NAME as complete_name from student;

--8. Write a SQL query to print all Student details from Student table order by FIRST_NAME Ascending and MAJOR Subject descending .

select * from student order by FIRST_NAME ASC ,MAJOR desc;

--9. Write a SQL query to print details of the Students with the FIRST_NAME as 'Prem' and 'Shivansh' from Student table.

select * from student where first_name in ('Prem','Shivansh');


--10. Write a SQL query to print details of the Students excluding FIRST_NAME as 'Prem' and 'Shivansh' from Student table.

select * from student where first_name not in ('Prem','Shivansh');

--11. Write a SQL query to print details of the Students whose FIRST_NAME ends with 'a'.

select * from student where first_name like '%a';

--12. Write an SQL query to print details of the Students whose FIRST_NAME ends with ‘a’ and contains five alphabets.

select * from student where first_name like '____a';

--13. Write an SQL query to print details of the Students whose GPA lies between 9.00 and 9.99.

select * from student where gpa between 9 and 9.99;

--14. Write an SQL query to fetch the count of Students having Major Subject ‘Computer Science’.
select * from student;

select count(*) from student where major='Computer science';-- data inside the table is case sensitive always remember
--or
select major,count(*) from student group by major having major='Computer science';

--15. Write an SQL query to fetch Students full names with GPA >= 8.5 and <= 9.5.

select first_name||' '||last_name from student where gpa between  8.5 and  9.5;

--16. Write an SQL query to fetch the no. of Students for each MAJOR subject in the descending order.

select major,count(*) from student group by major order by count(*) desc;

/*--17. Display the details of students who have received scholarships, including their names, 
scholarship amounts, and scholarship dates.*/

--here we have to deal with 2 tables(student,scholarship) need to join two tables to get details 
select * from student;
select * from program;
select * from scholarship;
--here i need to use inner join because i need to get only those students 
--who got scholarship means need to fetch only matching rows from the both tables

select s.first_name,
s1.scholarship_amount,
s1.scholarship_date 
from 
student s 
inner join 
scholarship s1
on s.student_id=s1.student_ref_id;

--18. Write an SQL query to show only odd rows from Student table.

select * from student where mod(student_id,2) !=0;

--19. Write an SQL query to show only even rows from Student table

select * from student where mod(student_id,2) =0;

/*--20. List all students and their scholarship amounts if they have received any.
If a student has not received a scholarship, display NULL for the scholarship details.*/

/*--here clearly we need to go for left join because wants all the details from student table 
if matching with scholarship table details otherwise print null values
*/

select * from student;

select * from scholarship;

select s.first_name||' '||s.last_name as full_name,
s1.scholarship_amount
from student s 
left join scholarship s1
on s.student_id=s1.student_ref_id;

--21. Write an SQL query to show the top n (say 5) records of Student table order by descending GPA.

select * from student where rownum<=5 order by gpa desc;--this logic is wrong because we are taking frist 5 rows
--then we are sortting

--what we should is first sort the table then take top 5 using subqueries concept

select * from (select * from student order by gpa desc) where rownum<=5;

--22. Write an SQL query to determine the nth (say n=5) highest GPA from a table.

--using rank 

select * from (select student_id,first_name,gpa,rank() over(order by gpa desc) rnk from student) where rnk=1;

--23. Write an SQL query to determine the 5th highest GPA without using LIMIT keyword.

select * from (select student_id,first_name,gpa,rank() over(order by gpa desc) rnk from student) where rnk=5;


--24. Write an SQL query to fetch the list of Students with the same GPA.

select * from student;

SELECT s1.* FROM Student s1, Student s2 WHERE s1.GPA = s2.GPA AND s1.Student_id != s2.Student_id;

/*
Explanation:
This query identifies students who share the same GPA by performing a self-join on the Student table. The condition 
ensures that the matched records are not the same student.
*/

--25. Write an SQL query to show the second highest GPA from a Student table using sub-query.

select * from student where gpa=(select max(gpa) 
from student where gpa<(select gpa 
from student where gpa=(select max(gpa) from student)));

--26. Write an SQL query to show one row twice in results from a table.

select * from student
union all
select * from student order by 1 desc;

--27. Write an SQL query to list STUDENT_ID who does not get Scholarship.

--means students present in left table but not present in right table

select * from student;
select * from scholarship;

select s.student_id,s.first_name,s1.scholarship_amount from 
student s
left outer join scholarship s1
on s.student_id=s1.student_ref_id where s1.scholarship_amount is null;

--or

select student_id,first_name from student where student_id not in (select student_ref_id from scholarship );


--28. Write an SQL query to fetch the first 50% records from a table.

select * from student order by 1 asc fetch first 50 percent rows ONLY;

--29. Write an SQL query to fetch the MAJOR subject that have less than 4 people in it.

select major,count(major) from student group by major having count(major)<4;

--30. Write an SQL query to show all MAJOR subject along with the number of people in there.

select major,count(*) from student group by major;

--31. Write an SQL query to show the last record from a table.
select * from student order by student_id;

select * from student where student_id=(select max(student_id) from student);

--32. Write an SQL query to fetch the first row of a table.

select * from student where student_id=(select min(student_id) from student);

--33. Write an SQL query to fetch the last five records from a table.
select * from student order by student_id desc;

select * from (select * from student order by student_id desc ) where rownum<=5 order by student_id asc;

---34. Write an SQL query to fetch three max GPA from a table using co-related subquery. 
-- i dont know co related sub query concept

-- 34,35,36 need to know co related sub query concept

--37. Write an SQL query to fetch MAJOR subjects along with the max GPA in each of these MAJOR subjects.

select major,max(gpa) from student group by major;

--38. Write an SQL query to fetch the names of Students who has highest GPA.

select * from student where gpa=(select max(gpa) from student);

--39. Write an SQL query to show the current date and time.

select sysdate FROM DUAL;

select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') as timestamp from dual;

select current_date from dual;
select systimestamp from dual;

--40. Write a query to create a new table which consists of data and structure copied 
--from the other table (say Student) or clone the table named Student.


create table clone_student as (select * from student);

--41. Write an SQL query to update the GPA of all the students in 'Computer Science' MAJOR subject to 7.5.
select * from student;

update student set gpa=7.5 where major='Computer science';

--42. Write an SQL query to find the average GPA for each major.

select major,avg(gpa) from  student group by major;

--43. Write an SQL query to show the top 3 students with the highest GPA.

select * from (select * from student order by gpa desc) where rownum<=3;

--44. Write an SQL query to find the number of students in each major who have a GPA greater than 7.5.

select major,gpa,count(*) from student group by major,gpa having gpa>7.5;

--or

select major,count(*) from student where gpa>7.5 group by major;
/*
Use WHERE when filtering individual rows before grouping.

This is more efficient because it reduces the number of rows before any grouping happens.
*/

SELECT MAJOR, COUNT(STUDENT_ID) AS HIGH_GPA_COUNT
FROM Student
WHERE GPA > 7.5
GROUP BY MAJOR;

--45. Write an SQL query to find the students who have the same GPA as 'Shivansh Mahajan

select * from student;

select * from student where gpa=(select gpa from student where first_name||' '||last_name='Shivansh Mahajan');

--or
SELECT * FROM Student WHERE GPA = (SELECT GPA FROM Student WHERE STUDENT_ID = 201);



