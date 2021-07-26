CREATE DATABASE Tutorias
GO
USE Tutorias
GO
-- Docente
create table Docente(
	IdDocente int identity(1,1),
	Nombres varchar(30),
	Apellidos varchar(30),
	TituloAcademico varchar (70),
	Facultad varchar(90),
	EscuelaProfesional varchar(70),
	Categoria varchar (60),
	PRIMARY KEY (IdDocente)
);
GO
---------------------
---Procedimientos almacenados para Docente

CREATE PROC SP_BUSCARDOCENTE
@BUSCAR varchar(20)
as
select * from Docente
where Nombres like @BUSCAR + '%'
GO
---Stored Procedures for insert Docente
-- drop procedure SP_INSERTARDOCENTE
create proc SP_INSERTARDOCENTE
@NOMBRES varchar(30),
@APELLIDOS varchar(30),
@TITULO varchar(70),
@FACULTAD varchar(90),
@EPROFESIONAL varchar(70),
@CATEGORIA varchar (60)
as
insert into Docente values(@NOMBRES,@APELLIDOS,@TITULO,@FACULTAD,@EPROFESIONAL,@CATEGORIA)
GO
------- Stored Procedures for update Docente
-- drop procedure  SP_EDITARDOCENTE 
create proc SP_EDITARDOCENTE
@IDDOCENTE int,
@NOMBRES varchar(30),
@APELLIDOS varchar(30),
@TITULO varchar(70),
@FACULTAD varchar(90),
@EPROFESIONAL varchar(70),
@CATEGORIA varchar (60)
as 
update Docente set Nombres=@NOMBRES,Apellidos=@APELLIDOS,TituloAcademico=@TITULO,Facultad=@FACULTAD,EscuelaProfesional=@EPROFESIONAL,Categoria=@CATEGORIA
where IdDocente =@IDDOCENTE
GO
---------Stored Procedures for delete docente
create proc SP_ELIMINARDOCENTE
@IDDOCENTE int
as
delete Docente
where IdDocente=@IDDOCENTE
GO
------Stored Procedured for listing Docente (Listar Docente)
create proc SP_LISTARDOCENTE
as
select top 100 
Docente.IdDocente,
Docente.Nombres,
Docente.Apellidos,
Docente.TituloAcademico,
Docente.Facultad,
Docente.EscuelaProfesional,
Docente.Categoria
from Docente
order by IdDocente asc
GO
--
create table Estudiante(
	IdEstudiante int identity(1,1) ,
	CodEstudiante as ('AL'+right('00'+convert(varchar,IdEstudiante),(2))),
	Nombres varchar(20),
	Apellidos varchar(20),
	SemestreActivo varchar(12),
	Estudiante varchar(6),
	EscuelaProfesional varchar (20),
	CodigoEP varchar(5),
	AIngreso varchar(12),
	PRIMARY KEY (IdEstudiante)
);
go

create proc SP_INSERTARESTUDIANTE
@NOMBRES varchar(20),
@APELLIDOS varchar(20),
@ESCUELAPROFESIONAL varchar(20),
@SEMESTREACTIVO varchar(12),
@ESTUDIANTE varchar(6),
@CODIGOEP varchar(5),
@AINGRESO varchar(12)
as 
insert into Estudiante values (@NOMBRES,@APELLIDOS,@SEMESTREACTIVO,@ESTUDIANTE,@ESCUELAPROFESIONAL,@CODIGOEP,@AINGRESO)
GO
create proc SP_EDITARESTUDIANTE
@NOMBRES varchar(20),
@APELLIDOS varchar(20),
@ESCUELAPROFESIONAL varchar(20),
@SEMESTREACTIVO varchar(12),
@ESTUDIANTE varchar(6),
@CODIGOEP varchar(5),
@AINGRESO varchar(12)
as 
update Estudiante set Nombres=@NOMBRES,Apellidos=@APELLIDOS,SemestreActivo=@SemestreActivo, EscuelaProfesional=@ESCUELAPROFESIONAL,CodigoEP=@CODIGOEP,
AIngreso=@AINGRESO
where Estudiante =@ESTUDIANTE
GO

CREATE PROC SP_ELIMINARESTUDIANTE
@ESTUDIANTE varchar(6)
as 
delete Estudiante
Where Estudiante =@ESTUDIANTE
go

create proc SP_LISTARESTUDIANTE
as
select Estudiante,Nombres,Apellidos,SemestreActivo,EscuelaProfesional,CodigoEP,AIngreso from Estudiante
go

create proc SP_BUSCARESTUDIANTE
@BUSCAR nvarchar(20)
as
select Estudiante,Nombres,Apellidos,SemestreActivo,EscuelaProfesional,CodigoEP,AIngreso
from Estudiante
where Nombres like @BUSCAR + '%'
GO
-- Login
create table Logins(
	Usuario varchar(40) not null,
	Contraseña varchar(40) not null,
	CategoriaLogin varchar (40)
);
insert into Logins values ('Timon','123','Nombrado')
insert into Logins values ('Cata','cata','Contratado')
GO
SELECT * FROM Logins

--Agregar docentes con datos reales
insert into Docente values ('Abdon','Ribas Puga','Licenciado en Fisico Matematicas','Facultad de Ing Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Ana Rocio','Cardenas Maita','Magister en Ciencias en Sistemas de Informacion','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Dennis Ivan','Candia Oviedo','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Doris Sabina','Aguirre Carbajal','Maestro en Ciencias: Ing de Sistemas con mencion en Ing de Software','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Edwin','Carrasco Poblete','Magister con Mencion en Ingenieria','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')

insert into Docente values ('Efraina Gladys','Cutipa Arapa','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Emilio','Palomino Olivera','Magister con Mencion en Ingenieria','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Enrique','Gamarra Saldivar','Magister en Ciencias con Mencion en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Esther Cristina','Pacheco Vasquez','Licenciada en Fisico Matematicas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Guzman','Ticona Pari','Ingeniero Quimico','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')

insert into Docente values ('Harley','Vera Olivera','Magister en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Henry Samuel','Dueñas De La Cruz','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Hernan','Castañeda Chirinos','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Hernan','Nina Hanco','Maestro en Administracion','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Ivan Cesar','Medrano Valencia','Ingeniero Quimico','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')

insert into Docente values ('Javier Arturo','Rozas Huacho','Magister en Ciencias con Mencion en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Javier David','Chavez Centeno','Magister Scientiae en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Jose Mauro','Pillco Quispe','Licenciado en Fisico Matematicas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Julio Cesar','Carbajal Luna','Magister en Ciencias con Mencion en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Karelia','Medina Miranda','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')

insert into Docente values ('Lauro','Enciso Rodas','Doctor en Ingenieria de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Lino Aquiles','Baca Cardenas','Ingeniero de Minas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Lino Prisciliano','Flores Pacheco','Magister en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Luis Alvaro','Monzon Condori','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Luis Beltran','Palma Ttito','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')

insert into Docente values ('Manuel Aurelio','Peñaloza Figueroa','Ingeniero de Telecomunicaciones','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Maritza Katherine','Irpanocca Cusimayta','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Nila Zonia','Acurio Usca','Magister en Ciencias con Mencion en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Robert Wilbert','Alzamora Paredes','Master en Ingenieria Computacional y Sistemas Inteligentes','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Rony','Villafuerte Serna','Maestro en Ingenieria Computacional y Sistemas Inteligentes','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')

insert into Docente values ('Vanesa Maribel','Choque Soto','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Waldo Elio','Ibarra Zambrano','Maestro en Ciencias con Mencion en Informatica','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
insert into Docente values ('Waldo','Villa Rodriguez','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Willian','Zamalloa Paro','Ingeniero Informatico y de Sistemas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Contratado')
insert into Docente values ('Yeshica Isela','Ormeño Ayala','Master en Tecnologias Informaticas Avanzadas','Facultad de Ingenieria Electrica, Electronica, Informatica y Mecanica','Ingenieria Informatica y de Sistemas','Nombrado')
GO
--=================================================================================================================
-- TABLA TUTORIA
create table Tutoria(
	IdTutoria int identity(1,1),
	IdDocente int,
	Horario varchar(50),
	PRIMARY KEY (IdTutoria),
	FOREIGN KEY (IdDocente) REFERENCES Docente(IdDocente) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
--------------------------------------------
----Stored Procedures for search Tutoria
CREATE PROC SP_BUSCARTUTORIA
@BUSCAR varchar(30)
as
select IdTutoria, T.IdDocente, Nombres, Apellidos, Horario
from Tutoria T inner join Docente D 
ON T.IdDocente = D.IdDocente
where Nombres like @BUSCAR + '%'
select top 100 IdTutoria, T.IdDocente, Nombres, Apellidos, Horario
from Tutoria T inner join Docente D 
ON T.IdDocente = D.IdDocente
order by IdTutoria asc
GO
---PROCEDIMIENTO ALMACENADO INSERTAR TUTORIA
create proc SP_INSERTARTUTORIA
@IDDOCENTE int,
@HORARIO varchar(50)
as 
insert into Tutoria values (@IDDOCENTE,@HORARIO)
GO
---PROCEDIMIENTO ALMACENADO EDITAR TUTORIA

create proc SP_EDITARTUTORIA
@IDTUTORIA int,
@IDDOCENTE int,
@HORARIO varchar(50)
as 
update Tutoria set IdDocente=@IDDOCENTE, Horario = @HORARIO
where IdTutoria =@IDTUTORIA
GO
---PROCEDIMIENTO ALMACENADO ELiminar TUTORIA
CREATE PROC SP_ELIMINARTUTORIA
@IDTUTORIA int
as 
delete Tutoria
Where IdTutoria=@IDTUTORIA
GO
----PROCEDIMIENTO ALMACENADO LISTAR  TUTORIAS
create proc SP_LISTARTUTORIA
as
select top 100 IdTutoria, T.IdDocente, Nombres, Apellidos, Horario
from Tutoria T inner join Docente D 
ON T.IdDocente = D.IdDocente
order by IdTutoria asc
GO
--=================================================================================================================
-- TABLA Registro
create table Registro(
	IdTutoria int,
	IdEstudiante int,
	PRIMARY KEY (IdTutoria, IdEstudiante),
	FOREIGN KEY (IdTutoria) REFERENCES Tutoria(IdTutoria) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
---PROCEDIMIENTO ALMACENADO BUSCARTUTORADO
CREATE PROC SP_BUSCARTUTORADO
@BUSCAR varchar(4)
as
select IdTutoria, R.IdEstudiante, Estudiante, Nombres, Apellidos, 
	SemestreActivo, AIngreso, EscuelaProfesional, CodigoEP
	from Registro R inner join Estudiante E 
	ON R.IdEstudiante = E.IdEstudiante
where	Estudiante like @BUSCAR + '%'
GO
---PROCEDIMIENTO ALMACENADO INSERTAR TUTORADO
create proc SP_INSERTARTUTORADO
@IDTUTORIA int,
@IDESTUDIANTE int
as 
insert into Registro values (@IDTUTORIA, @IDESTUDIANTE)
GO
---PROCEDIMIENTO ALMACENADO EDITARESTUDIANTE

create proc SP_EDITARTUTORADO
@IDTUTORIA int,
@IDESTUDIANTE int
as 
update Registro set IdTutoria=@IDTUTORIA
where IdEstudiante =@IDESTUDIANTE
GO
---PROCEDIMIENTO ALMACENADO ELiminarESTUDIANTE
CREATE PROC SP_ELIMINARTUTORADO
@IDESTUDIANTE int
as 
delete Registro
Where IdEstudiante=@IDESTUDIANTE

select * from Estudiante
GO
----Listing Student
create proc SP_LISTARTUTORADO
as
select top 100 IdTutoria, R.IdEstudiante, Estudiante, Nombres, Apellidos, 
	SemestreActivo, AIngreso, EscuelaProfesional, CodigoEP
	from Registro R inner join Estudiante E 
	ON R.IdEstudiante = E.IdEstudiante
	order by IdTutoria asc
GO
--- Search students

--=================================================================================================================
-- TABLA RegistroFicha
create table RegistroFicha(
	IdFichaTutoria int identity(1,1),
	IdTutoria int,
	IdEstudiante int,
	NroCelular varchar(10),
	Direccion varchar(100),
	Email varchar(50),
	PersonaReferencia varchar(100),
	CelularReferencia varchar(10),
	Fecha date,
	TipoTutoria varchar(20),
	Descripcion varchar(1000),
	PRIMARY KEY (IdFichaTutoria),
	FOREIGN KEY (IdTutoria, IdEstudiante) REFERENCES Registro(IdTutoria, IdEstudiante) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
--------------------------------------------
---PROCEDIMIENTO ALMACENADO BUSCARFICHA
CREATE PROC SP_BUSCARFICHA
@BUSCAR varchar(20)
as
select IdFichaTutoria, IdTutoria, R.IdEstudiante, Nombres, Apellidos, NroCelular, Direccion, 
	Email, PersonaReferencia, CelularReferencia, Fecha, TipoTutoria, Descripcion
	from RegistroFicha R INNER JOIN Estudiante E
	ON R.IdEstudiante = E.IdEstudiante
	where Nombres like @BUSCAR + '%'
GO	

---PROCEDIMIENTO ALMACENADO INSERTAR ESTUDIANTE
create proc SP_INSERTARFICHA
@IDTUTORIA int,
@IDESTUDIANTE int,
@NROCELULAR varchar(10),
@DIRECCION varchar(100),
@EMAIL varchar(50),
@PERSONAREFERENCIA varchar(100),
@CELULARREFERENCIA varchar(10),
@FECHA date,
@TIPOTUTORIA varchar(10),
@DESCRIPCION varchar(1000)
as 
insert into RegistroFicha values (@IDTUTORIA, @IDESTUDIANTE, @NROCELULAR, @DIRECCION, @EMAIL, 
									@PERSONAREFERENCIA, @CELULARREFERENCIA, @FECHA, @TIPOTUTORIA, @DESCRIPCION)
GO
---PROCEDIMIENTO ALMACENADO EDITARESTUDIANTE

create proc SP_EDITARFICHA
@IDFICHATUTORIA int,
@IDTUTORIA int,
@IDESTUDIANTE int,
@NROCELULAR varchar(10),
@DIRECCION varchar(100),
@EMAIL varchar(50),
@PERSONAREFERENCIA varchar(100),
@CELULARREFERENCIA varchar(10),
@FECHA date,
@TIPOTUTORIA varchar(10),
@DESCRIPCION varchar(1000)
as 
update RegistroFicha set IdTutoria = @IDTUTORIA, IdEstudiante = @IDESTUDIANTE, NroCelular = @NROCELULAR,
					Direccion = @DIRECCION, Email = @EMAIL, PersonaReferencia = @PERSONAREFERENCIA,
					CelularReferencia = @CELULARREFERENCIA, Fecha = @FECHA, TipoTutoria = @TIPOTUTORIA, Descripcion = @DESCRIPCION
where IdFichaTutoria =@IDFICHATUTORIA
GO
---PROCEDIMIENTO ALMACENADO ELiminarESTUDIANTE
CREATE PROC SP_ELIMINARFICHA
@IDFICHATUTORIA int
as 
delete RegistroFicha
Where IdFichaTutoria = @IDFICHATUTORIA
GO
----Listing Student
create proc SP_LISTARFICHA
as
select TOP 100 IdFichaTutoria, IdTutoria, R.IdEstudiante, Nombres, Apellidos, NroCelular, Direccion, 
	Email, PersonaReferencia, CelularReferencia, Fecha, TipoTutoria, Descripcion
	from RegistroFicha R INNER JOIN Estudiante E
	ON R.IdEstudiante = E.IdEstudiante
	order by IdFichaTutoria asc
GO
--- Search students