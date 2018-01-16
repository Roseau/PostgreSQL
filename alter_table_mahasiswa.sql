--delete from master_mahasiswa;

--untuk menambahkan kolom dalam satu tabel
--alter table master_mahasiswa add column kode_jurusan integer not null;
--untuk menambahkan konstraint foreign key dalam satu tabel
alter table master_mahasiswa
	add constraint fk_kode_jurusan foreign key (kode_jurusan)
    references master_jurusan(kode);