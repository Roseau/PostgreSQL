select
	kdi.nama_lengkap as "Nama",
    l.street_address || ', ' || l.city as alamat_rumah,
    lo.city || ', ' || lo.street_address as alamat_domisili,
	d.department_name as nama_divisi,
	j.job_title as "sebagai"
from
	karyawan_tdi kdi inner join locations l on kdi.alamat_rumah = l.location_id 
    				 inner join locations lo on kdi.alamat_domisili = lo.location_id
    				 inner join departments d on kdi.bagian = d.department_id
                     inner join jobs j on kdi.jabatan = j.job_id
group by
	kdi.nama_lengkap, 
    l.street_address,
    l.city,
    lo.city,
    lo.street_address,
    d.department_name,
    j.job_title
order by
	kdi.nama_lengkap;