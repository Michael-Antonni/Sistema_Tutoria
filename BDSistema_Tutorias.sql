use master
go
if exists(select * from sysdatabases where name in ('BDSistema_Tutoria'))
   drop database BDSistema_Tutoria--si la BD existe se elimina
go
create database BDSistema_Tutoria
go


 create table TDocente
 (	
	--Atributos 
	CodigoD varchar(7) not null,
	APaterno varchar(15) not null,
	AMaterno varchar(15) not null,
	Nombres varchar(10)not null,
	CarreraP varchar(25)not null,
	Categoria varchar(2) not null,
	--Primary key and foreign keys
	primary key (CodigoD)
 );

 create table Escuela_Profesional
 (
	--atributos 
	CodigoEP varchar(4) not null,
	Nombre varchar(10) not null,
	--Primary key and foreign keys
	primary key (CodigoEP)
 )
 create table TEstudiante
(
	--Atributos 
	CodigoE varchar(6) not null,
	APaterno varchar(15) not null,
	AMaterno varchar(15) not null,
	Nombres varchar(10)not null,
	CodigoEP varchar(4)not null,
	--Primary key and foreign keys
	primary key (CodigoE),
	foreign key(CodigoEP) references Escuela_Profesional
);
 create table Ttutoria
 (
	IdTutoria varchar(3) not null,
	CodigoE varchar(6) not null,
	CodigoD varchar(7) not null,
	--Primary key and foreign keys
	primary key (IdTutoria),
	foreign key (CodigoE) references TEstudiante,
	foreign key (CodigoD) references TDocente
 );