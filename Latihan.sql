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
	salary > 3200.00 and salary < 12000.00
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
	employees
where 
	department_id is not null;
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
--latihan part 2
--no 1
select
	employee_id as "Kode Karyawan",
	departments.department_name as "Nama Departemen",
    first_name || ' ' || last_name as "Nama Lengkap",
    salary as "Gaji Sebulan",
    case when commission_pct is null then 'Tidak ada komisi'
    else to_char(commission_pct,'999,999,999.99')
    end as "Mendapatkan Komisi",
    case when commission_pct is not null then to_char(salary+commission_pct*salary,'999,999,999.99')
    else to_char(salary,'999,999,999.99')
    end as "Gaji Terima"
from
	employees inner join departments on departments.department_id=employees.department_id;
--no 2
select
	k.employee_id as "Kode Karyawan",
    k.first_name || ' ' || k.last_name as "Nama Karyawan",
    departments.department_name as "Nama Bagian",
    k.manager_id,
    case 
    	when k.manager_id is null 
        	then 'Tidak memiliki manager'
    	else
        	man.first_name || ' ' || man.last_name
    end as "Nama Manager"
from
	employees k inner join departments on departments.department_id=k.department_id 
    join employees man on k.manager_id = man.employee_id;
--no 3
select
	d.department_id as dep_id,
    d.department_name as dep_name,
    sum(e.salary) as total_gaji
from 
	departments d inner join employees e on d.department_id = e.department_id
group by
	d.department_id
order by
	total_gaji desc;
--no 4
select 
	salary*12 as gaji_setahun,
    count(salary*12) as jumlah_karyawan
from
	employees
where
	commission_pct is not null
group by
	gaji_setahun
order by
	gaji_setahun desc;
--no 5
select
	employee_id as "kode karyawan",
    first_name || ' ' || last_name as "Nama Lengkap",
    salary,
    job_title,
    email
from 
	employees e inner join jobs j on e.job_id=j.job_id
where
	salary >= (select max(salary) from employees where job_id='IT_PROG')
order by
	salary desc;
--Latihan 3
--no 1
select * from countries where country_id = 'ID';

--no 2
INSERT INTO locations VALUES (6232, 'Cinunuk','40526','Kab. Bandung','Jawa Barat','ID'),
							 (6231, 'Ujung Berung','40521','Kota Bandung','Jawa Barat','ID'),
                             (6233, 'Margaharayu Raya','40525','Kota Bandung','Jawa Barat','ID'),
                             (6230, 'Blok M','40620','Jakarta Selatan','DKI Jakarta','ID'),
                             (6220, 'Slipi','40521','Jakarta Utara','DKI Jakarta','ID');
