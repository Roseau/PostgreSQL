--latihan 1
select
	*
from
	employees
order by
	email desc;
--latihan 2
select
	*
from
	employees
where 
	salary between 3200.00 and 12000.00
order by
	salary desc;
--latihan 3
select
	*
from 
	employees
where
	first_name like 'A%' or first_name like 'a%';
--latihan 4
select
	*
from 
	employees
where
	employee_id in (103,115,196,187,102,100);
--latihan 5
select
	*
from
	employees
where
	last_name like '_u%';
--latihan 6
select
	distinct department_id
from 
	employees;
--latihan 7
select
	first_name || ' ' || last_name as nama_lengkap,
    job_id as kode_jabatan,
    salary*12 as gaji_setahun
from 
	employees
where
	manager_id = 100;
--latihan 8
select
	last_name as nama_lengkap,
    job_id as kode_jabatan,
    salary as gaji_perbulan,
    commission_pct
from 
	employees
where
	commission_pct is null;
--latihan 9
select
	*
from
	employees
where
	job_id not in('IT_PROG','SH_CLERK');