	select
		kdi.nama_lengkap as nama_lengkap,
        l.street_address ||', '||l.city as address,
        d.department_name,
        j.job_title
	from
		karyawan_tdi kdi inner join jobs j on kdi.jabatan = j.job_id
        				 inner join departments d on kdi.bagian = d.department_id
                         inner join locations l on kdi.alamat_rumah = l.location_id
     where
     	kdi.jabatan='IT_PROG'
union
	select
    	e.first_name||' '||e.last_name,
        l.street_address||' '||l.city,
        d.department_name,
        j.job_title
	from
    	employees e inner join jobs j on e.job_id = j.job_id
        			inner join departments d on e.department_id = d.department_id
                    inner join locations l on l.location_id = d.location_id 
     where
     	e.job_id='IT_PROG'
order by
	address desc;
