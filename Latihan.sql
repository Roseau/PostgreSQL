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
--no 3
update 
	employees 
set 
	commission_pct = 0.10 
where
	job_id = 'IT_PROG';
--no 4
create table karyawan_tdi (
	kode_karyawan integer primary key,
    nama_lengkap varchar(50),
    alamat_rumah integer references locations(location_id),
    alamat_domisili integer references locations(location_id),
    jabatan varchar(10) references jobs(job_id),
    bagian integer references departments(department_id)
);
--no 5
insert into karyawan_tdi values (2,'Dimas Maryanto',6232,6230,'IT_PROG',60),
								(3,'Hari Sapto Adi',6233,6233,'IT_PROG',60),
                                (4,'Deni Sutisna',6220,6220,'IT_PROG',60),
                                (5,'Arip Permana',6233,6233,'AD_PRES',90),
                                (6,'Zara',6233,6233,'HR_REP',10);
--no 6
select
	kdi.nama_lengkap as "Nama",
    l.street_address || ', ' || l.city as alamat_rumah,
    l.city || ', ' || l.street_address as alamat_domisili,
	d.department_name as nama_divisi,
	j.job_title as "sebagai"
from
	karyawan_tdi kdi inner join locations l on kdi.alamat_rumah = l.location_id 
    				 inner join departments d on kdi.bagian = d.department_id
                     inner join jobs j on kdi.jabatan = j.job_id;

--latihan posregsql
--no1 membuat fungsi jumlah 3 angka
create or replace function hitung_3angka(p1 int, p2 int, p3 int)
	returns numeric
as $$
begin
	return p1 + p2 + p3;
end; $$
language 'plpgsql'
--pemanggilan
select * from hitung_3angka(10,25,100);
--no2 create function get_employee untuk menampilkan employees yang diawali dengan huruf tertentu
--ex : get_employee('A%','B%') akan menampilkan
 create or replace function get_employee(firstname varchar(255), lastname varchar(255))
	returns table( 
    	first_name varchar(20),
        last_name varchar(20)
    )
as $$
begin
	return query
    	select e.first_name, e.last_name from employees e where e.first_name like firstname and e.last_name like lastname;
end; $$
language 'plpgsql'
--pemanggilan
select * from get_employee('A%', 'B%');
--no3 create function get_employee untuk menampilkan gaji lebih besar / kecil dari nilai tertentu
--ex : get_employee('lebih_kecil', 15000)
create or replace function get_salary_employee(variabel varchar(255), gaji numeric)
	returns table( 
    	nama_lengkap varchar(255),
        hasil_salary numeric
    )
as $$
begin
	if variabel='lebih_dari' then
    	return query
    	select (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary > gaji;
     end if;
     if variabel='kurang_dari' then
     	return query
    	select (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary < gaji;
     end if;
     if variabel='sama_dengan' then
     	return query 
    	select (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary = gaji;
     end if;
end; $$
language 'plpgsql'
--pemanggilan
select * from get_salary_employee('lebih_dari',10000);
select * from get_salary_employee('kurang_dari',10000);
select * from get_salary_employee('sama_dengan',11000);
--note : selain if, bisa juga menggunakan case dan when seperti berikut :
create or replace function get_salary_employee(idemployee integer, variabel varchar(255), gaji numeric)
	returns table(
        id_employee integer,
    	nama_lengkap varchar(255),
        hasil_salary numeric
    )
as $$
begin
	case variabel
		when 'lebih_dari' then
    		return query
    		select e.employee_id, (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary > gaji and e.employee_id=idemployee;
     	when 'kurang_dari' then
     		return query
    		select e.employee_id, (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary < gaji and e.employee_id=idemployee;
     	when 'sama_dengan' then
     		return query 
    		select e.employee_id, (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary = gaji and e.employee_id=idemployee;
    end case;
end; $$
language 'plpgsql'
--alternatif lain, menggunakan array untuk memanggil banyak ID sekaligus menggunakan array
create or replace function get_salary_employee_alter(idemployee integer[], variabel varchar(255), gaji numeric)
	returns table(
        id_employee integer,
    	nama_lengkap varchar(255),
        hasil_salary numeric
    )
as $$
begin
	case variabel
		when 'lebih_dari' then
    		return query
    		select e.employee_id, (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary > gaji and e.employee_id=any(idemployee);
     	when 'kurang_dari' then
     		return query
    		select e.employee_id, (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary < gaji and e.employee_id=any(idemployee);
     	when 'sama_dengan' then
     		return query 
    		select e.employee_id, (e.first_name || ' ' || e.last_name):: varchar(255), e.salary from employees e where e.salary = gaji and e.employee_id=any(idemployee);
    end case;
end; $$
language 'plpgsql'
--dipanggil dengan syntax sebagai berikut :
select * from get_salary_employee_alter(array[100,101,102],'lebih_dari',5000);
