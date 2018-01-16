--mengambil data karayawan yang huruf kedua dari terakhirnya adalah "u"
select 
	*
from
	employees
WHERE
    substring(last_name, char_length(last_name)-1, 1) = 'u';
--mengambil data karyawan berdasarkan id spesifik
select 
	*
from
	employees
WHERE
    employee_id = 103;

--mengambil departement id secara unique tanpa perulangan
select 
	distinct department_id
from
	employees;
--------------------???-------------------
Select 
    employee_id,
    first_name || ' ' || last_name as nama,
    salary
from
	employees
where
	--% bebas, sementara _ spesifik ex : _u_ akan mengembalikan guy
	first_name like '%a'
    --or
   	--last_name like 'B%'
	--menampilkan karyawan dengan id dalam kurung
	--employee_id in(100, 150, 200, 110, 120);
    --menampilkan karyawan dengan id tidak dalam kurung
    --employee_id not in(100, 150, 200, 110, 120)
    --and
	--salary < 10000;
   	--salary > 10000
    --and
    --employee_id%2=0;
order by
	--bisa ASC dan DESC
	--first_name DESC;
   	--dengan 2 parameter, apabila ada nama yang sama maka akan diurutkan menggunakan salary
    first_name, salary;
--aplikasi join
select
	E.employee_id,
    E.first_name || ' ' || E.last_name,
    E.department_id,
    D.department_name,
    E.job_id,
    j.job_title
from
	employees E inner join departments D on E.department_id=D.department_id 
    			inner join jobs j on E.job_id=j.job_id;  
--penjelasan join
ex : employees E 

--functions!
create or replace function getEmployeeName(paraName varchar(255))
		--char >> memory menambah semua
        --varchar >> tergantung dari input, walau maksnya 255
        returns table(
        	fullname varchar(255),
            Sallary numeric,
            joinDate DATE
        )                     
		--output tidak harus dalam bentuk table, bisa dlam numeric etc2
        as $$
        begin
        	return QUERY
            	select "fullname", "Sallary", "joinDate" from employees
                where "fullname" like paraName;
       	end; $$
        language 'plpgsql'
----iiiooooo----
create or replace function getEmployeeName(paraName varchar(255))
	returns table(
    	Nama_lengkap varchar,
        Alamat_Email varchar(255)
    )
as $$
begin
	return QUERY
    	select e.first_name|| ' ' || e.last_name, e.email from employees e where e.first_name like paraName;
end; $$
language 'plpgsql'
----
create or replace function getEmployeeName(paraName varchar(255))
	returns table(
    	Nama_lengkap varchar(255),
        Alamat_Email varchar(255)
    )
as $$
declare Nama_lengkap varchar(255);
declare Alamat_Email varchar(255);
begin
	return QUERY
    	select into Nama_lengkap e.first_name|| ' ' || e.last_name, ALamat_Email e.email from employees e where e.first_name like paraName;
        return Nama_lengkap;
        return Alamat_Email;
end; $$
language 'plpgsql'
----
create or replace function buat_kalimat(p1 varchar(255), p2 varchar(255))
	returns varchar(255)
as $$
begin
	return p1 || p2;
end; $$
language 'plpgsql'
-----
create or replace function hitung_salary(nama varchar(255))
	returns numeric
as $$
declare TotalGaji numeric;
begin
	select into TotalGaji sum(e.salary) from employees e where e.first_name like nama;
    return TotalGaji;
end; $$
language 'plpgsql'
---memasukkan data ke sebuah table
insert into departments (department_id, department_name, location_id) values (1006, null, null);
select * from departments where department_id in (1002,1005,1006);
--selalu perhatikan attribut yang menjadi nilai dalam table, apakah dia bisa null? dan apakah memiliki
--keterkaitan dengan table lain
--update data table
insert into departments (department_id, department_name, location_id) values (1006, null, null);
select * from departments where department_id in (1002,1005,1006);
select * from departments where department_id=100 --manager_id = 108, location_id = 1700
update departments set department_name='keuangan', manager_id=108, location_id=1700 where department_id = 100;
--membuat table
create table master_mahasiswa(
	nim bigint primary key unique not null,
    nama character varying(50) not null,
    jenis_kelamin character(1) not null,
    tanggal_lahir date not null
)