create database DezmembrariAuto
use DezmembrariAuto

create table Dezmembrare
(id int primary key,
 nume varchar(50),
 adresa varchar(50)
)

create table Masini
( id_masina int primary key,
  id int foreign key references Dezmembrare(id),
  marca varchar(50),
  model varchar(50),
  combustibil varchar(50)
)

create table Caroserie
( id_caros int primary key,
  id int foreign key references Masini(id_masina),
  nume varchar(50)
)

create table Motor
( id_motor int primary key,
  id int foreign key references Masini(id_masina),
  nume varchar(50)
)

create table Suspensie
(id_suspensie int primary key,
 id int foreign key references Masini(id_masina),
 nume varchar(50)
)

create table Directie
(id_directie int primary key,
 id int foreign key references Masini(id_masina),
 nume varchar(50)
)

create table Evacuare
(id_evacuare int primary key,
 id int foreign key references Masini(id_masina),
 nume varchar(50)
 )
create table Angajati
( id_angajat int primary key identity,
  id int foreign key references Dezmembrare(id),
  nume varchar(50),
)

create table Clienti
( id_client int primary key identity,
  id int foreign key references Dezmembrare(id),
  nume varchar(50)
)

create table Vanzari
(id_vanzare int primary key identity,
 id_angajat int foreign key references Angajati(id_angajat),
 id_client int foreign key references Clienti(id_client),
 id_piesa int,
 categorie_piesa varchar(50)
)


drop table Vanzari
drop table Angajati

