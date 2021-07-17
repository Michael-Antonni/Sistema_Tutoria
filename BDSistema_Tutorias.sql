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
	CodigoEP varchar(4)not null,
		--Primary key and foreign keys
	primary key (CodigoD),
	foreign key(CodigoEP) references Escuela_Profesional
 );
 create table TDocente_Contratado
 (	
	--Atributos
	CodigoD varchar(7) not null,
	Categoria varchar(2) not null,
	Horas int,
	Clasificacion varchar(5) not null,
	--Primary key and foreign keys
	primary key (CodigoD),
	foreign key (CodigoD) references TDocente

 );
 drop table TDocente_Nombrado
 create table TDocente_Nombrado
 (
	CodigoD varchar(7) not null,
	Tipo varchar(10) not null,
	--Primary key and foreign keys
	primary key (CodigoD),
	foreign key (CodigoD) references TDocente,
	foreign key (Tipo) references TDocente_Nombrado_Tipo
 );
 drop table TDocente_Nombrado_Tipo
create table TDocente_Nombrado_Tipo
 (
	
	Tipo varchar(10) not null,
	Caracteristica varchar(10) not null,
	--Primary key and foreign keys
	primary key (Tipo),
	

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
	Estado varchar(40),
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

 --===============================================================
 --DATOS INSERTADOS EN CADA TABLA
