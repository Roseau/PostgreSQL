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