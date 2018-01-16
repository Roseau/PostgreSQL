create table karyawan_tdi (
	kode_karyawan integer primary key,
    nama_lengkap varchar(50),
    alamat_rumah integer references locations(location_id),
    alamat_domisili integer references locations(location_id),
    jabatan varchar(10) references jobs(job_id),
    bagian integer references departments(department_id)
);