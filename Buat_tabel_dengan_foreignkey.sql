create table master_dosen(
	kode serial primary key,
    nama character varying(50) not null,
    jenis_kelamin character(1) not null
);

create table master_jurusan(
	kode serial primary key,
    nama_jurusan character varying(25) not null,
    kode_prodi integer not null references master_dosen(kode)
);