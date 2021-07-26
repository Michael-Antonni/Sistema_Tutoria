
------------------------------------------------------------------------------------------------------------
--								Base de datos para el sistema de tutorias
------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------
--		Creacion de la base da datos
------------------------------------------------------------------------------------------------------------
use master
go

IF EXISTS (SELECT * 
				FROM SYSDATABASES
				WHERE NAME = 'BD_Sistema_Tutoria')
	DROP DATABASE BD_Sistema_Tutoria
GO
CREATE DATABASE BD_Sistema_Tutoria
GO

use BD_Sistema_Tutoria
go

------------------------------------------------------------------------------------------------------------
--		Creacion de las tablas
------------------------------------------------------------------------------------------------------------

-- Docente
create table Docente(
	IdDocente		int identity(1,1),
	APaterno		varchar(50),
	AMaterno		varchar(50),
	Nombres			varchar(30),
	TituloAcademico varchar (70),
	CodEscuela		varchar(5),
	Categoria		varchar (60), check (Categoria in('Contratado', 'Nombrado')),
	PRIMARY KEY (IdDocente)
);
GO

-- Escuela profesional
create table EscuelaProfesional
(
	CodEscuela		varchar(5),
	Nombre			varchar(50),
	primary key(CodEscuela)
);
GO

-- Estudiantes
create table Estudiante
(
	CodEstudiante		char(6),
	APaterno		varchar(50),
	AMaterno		varchar(50),
	Nombres			varchar(30),
	Situacion		varchar(50) check (Situacion in('Riesgo', 'No riesgo')),
	CodTutor		int,
	CodEscuela		varchar(5),
	primary key (CodEstudiante),
	foreign key (CodTutor) references Docente(IdDocente),
	foreign key (CodEscuela) references EscuelaProfesional(CodEscuela)
);
GO

------------------------------------------------------------------------------------------------------------
--		Procedimientos almacenados
------------------------------------------------------------------------------------------------------------

-- Docente
alter procedure ListarEstudiante
as
select * from Estudiante
go

create procedure CrearDocente
@APaterno varchar(50),
@AMaterno varchar(50),
@Nombres varchar(30),
@TituloAcademico varchar(70),
@Categoria varchar(60),
@CodEscuela varchar(5)
as
insert into Docente values(@APaterno,@AMaterno,@Nombres,@TituloAcademico,@CodEscuela,@Categoria)
go

create procedure ActualizarDocente
@IdDocente int,
@APaterno varchar(50),
@AMaterno varchar(50),
@Nombres varchar(30),
@TituloAcademico varchar(70),
@Categoria varchar(60),
@CodEscuela varchar(5)
as
update Docente set APaterno=@APaterno,AMaterno=@AMaterno,Nombres=@Nombres,TituloAcademico=@TituloAcademico,Categoria=@Categoria,CodEscuela=@CodEscuela
where IdDocente=@IdDocente
go

create procedure EliminarDocente
@IdDocente int
as
delete from Docente
where IdDocente=@IdDocente
go

	alter procedure ListarDocente
	as
	select * from Docente
	go

create PROC [dbo].[BuscarDocente]
@BUSCAR varchar(20)
as
select * from Docente
where Nombres like @BUSCAR + '%'
go

create proc [dbo].[BuscarEstudiante]
@BUSCAR nvarchar(20)
as
select *
from Estudiante
where Nombres like @BUSCAR + '%'
go

-- Escuela profesional
create procedure CrearEscuelaProfesional
@CodEscuela varchar(5),
@Nombre varchar(50)
as
insert into EscuelaProfesional values(@CodEscuela,@Nombre)
go

create procedure ActualizarEscuelaProfesional
@CodEscuela varchar(5),
@Nombre varchar(50)
as
update EscuelaProfesional set Nombre=@Nombre
where CodEscuela=@CodEscuela
go

create procedure EliminarEscuelaProfesional
@CodEscuela varchar(5)
as
delete from EscuelaProfesional
where CodEscuela=@CodEscuela
go

create procedure ListarEscuelaProfesional
@CodEscuela varchar(5)
as
select * from EscuelaProfesional
where CodEscuela=@CodEscuela
go


-- Estudiantes
create procedure CrearEstudiante
@CodEstudiante char(6),
@APaterno varchar(50),
@AMaterno varchar(50),
@Nombres varchar(30),
@Situacion varchar(50),
@CodTutor int,
@CodEscuela varchar(5)
as
insert into Estudiante values(@CodEstudiante,@APaterno,@AMaterno,@Nombres,@Situacion,@CodTutor,@CodEscuela)
go

create procedure ActualizarEstudiante
@CodEstudiante char(6),
@APaterno varchar(50),
@AMaterno varchar(50),
@Nombres varchar(30),
@Situacion varchar(50),
@CodTutor int,
@CodEscuela varchar(5)
as
update Estudiante set APaterno=@APaterno,AMaterno=@AMaterno,Nombres=@Nombres,Situacion=@Situacion,CodTutor=@CodTutor,CodEscuela=@CodEscuela
where CodEstudiante=@CodEstudiante
go

create procedure EliminarEstudiante
@CodEstudiante char(6)
as
delete from Estudiante
where CodEstudiante=@CodEstudiante
go



------------------------------------------------------------------------------------------------------------
--		Datos
------------------------------------------------------------------------------------------------------------

-- Docentes
insert into Docente values ('Ribas','Puga','Abdon','Licenciado en Fisico Matematicas','IN','Nombrado')
insert into Docente values ('Cardenas','Maita','Ana Rocio','Magister en Ciencias en Sistemas de Informacion','IN','Contratado')
insert into Docente values ('Candia','Oviedo','Dennis Ivan','Ingeniero Informatico y de Sistemas','IN','Nombrado')
insert into Docente values ('Aguirre','Carbajal','Doris Sabina','Maestro en Ciencias: Ing de Sistemas con mencion en Ing de Software','IN','Contratado')
insert into Docente values ('Carrasco','Poblete','Edwin','Magister con Mencion en Ingenieria','IN','Nombrado')

insert into Docente values ('Cutipa','Arapa','Efraina Gladys','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Palomino','Olivera','Emilio','Magister con Mencion en Ingenieria','IN','Nombrado')
insert into Docente values ('Gamarra','Saldivar','Enrique','Magister en Ciencias con Mencion en Informatica','IN','Nombrado')
insert into Docente values ('Pacheco','Vasquez','Esther Cristina','Licenciada en Fisico Matematicas','IN','Nombrado')
insert into Docente values ('Ticona','Pari','Guzman','Ingeniero Quimico','IN','Nombrado')

insert into Docente values ('Vera','Olivera','Harley','Magister en Informatica','IN','Contratado')
insert into Docente values ('Dueñas','De La Cruz','Henry Samuel','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Castañeda','Chirinos','Hernan','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Nina','Hanco','Hernan','Maestro en Administracion','IN','Contratado')
insert into Docente values ('Medrano','Valencia','Ivan Cesar','Ingeniero Quimico','IN','Nombrado')

insert into Docente values ('Rozas','Huacho','Javier Arturo','Magister en Ciencias con Mencion en Informatica','IN','Nombrado')
insert into Docente values ('Chavez','Centeno','Javier David','Magister Scientiae en Informatica','IN','Nombrado')
insert into Docente values ('Pillco','Quispe','Jose Mauro','Licenciado en Fisico Matematicas','IN','Nombrado')
insert into Docente values ('Carbajal','Luna','Julio Cesar','Magister en Ciencias con Mencion en Informatica','IN','Nombrado')
insert into Docente values ('Medina','Miranda','Karelia','Ingeniero Informatico y de Sistemas','IN','Nombrado')

insert into Docente values ('Enciso','Rodas','Lauro','Doctor en Ingenieria de Sistemas','IN','Nombrado')
insert into Docente values ('Baca','Cardenas','Lino Aquiles','Ingeniero de Minas','IN','Nombrado')
insert into Docente values ('Flores','Pacheco','Lino Prisciliano','Magister en Informatica','IN','Nombrado')
insert into Docente values ('Monzon','Condori','Luis Alvaro','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Palma','Ttito','Luis Beltran','Ingeniero Informatico y de Sistemas','IN','Nombrado')

insert into Docente values ('Peñaloza','Figueroa','Manuel Aurelio','Ingeniero de Telecomunicaciones','IN','Nombrado')
insert into Docente values ('Irpanocca','Cusimayta','Maritza Katherine','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Acurio','Usca','Nila Zonia','Magister en Ciencias con Mencion en Informatica','IN','Nombrado')
insert into Docente values ('Alzamora','Paredes','Robert Wilbert','Master en Ingenieria Computacional y Sistemas Inteligentes','IN','Nombrado')
insert into Docente values ('Villafuerte','Serna','Rony','Maestro en Ingenieria Computacional y Sistemas Inteligentes','IN','Nombrado')

insert into Docente values ('Choque','Soto','Vanesa Maribel','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Ibarra','Zambrano','Waldo Elio','Maestro en Ciencias con Mencion en Informatica','IN','Nombrado')
insert into Docente values ('Villa','Rodriguez','Waldo','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Zamalloa','Paro','Willian','Ingeniero Informatico y de Sistemas','IN','Contratado')
insert into Docente values ('Ormeño','Ayala','Yeshica Isela','Master en Tecnologias Informaticas Avanzadas','IN','Nombrado')
GO

-- Escuela profesional
insert into EscuelaProfesional values 
						('AG','AGRONOMIA'),
						('AS','ANTROPOLOGIA'),
						('AQ','ARQUEOLOGIA'),
						('AR','ARQUITECTURA'),
						('CB','BIOLOGIA'),
						('AD','CIENCIAS ADMINISTRATIVAS'),
						('CC','CIENCIAS DE LA COMUNICACION'),
						('CO','CONTABILIDAD'),
						('DE','DERECHO'),
						('EC','ECONOMIA'),
						('ED','EDUCACION'),
						('EN','ENFERMERIA'),
						('FA','FARMACIA Y BIOQUIMICA'),
						('FL','FILOSOFIA'),
						('FI','FISICA'),
						('HI','HISTORIA'),
						('IA','INGENIERIA AGROINDUSTRIAL'),
						('IR','INGENIERIA AGROPECUARIA'),
						('IC','INGENIERIA CIVIL'),
						('IM','INGENIERIA DE MINAS'),
						('IE','INGENIERIA ELECTRICA'),
						('EL','INGENIERIA ELECTRONICA'),
						('FO','INGENIERIA FORESTAL'),
						('GO','INGENIERIA GEOLOGICA'),
						('IN','INGENIERIA INFORMATICA Y DE SISTEMAS'),
						('MC','INGENIERIA MECANICA'),
						('ML','INGENIERIA METALURGICA'),
						('PQ','INGENIERIA PETROQUIMICA'),
						('IQ','INGENIERIA QUIMICA'),
						('ME','MATEMATICAS'),
						('MH','MEDICINA HUMANA'),
						('MV','MEDICINA VETERINARIA'),
						('OS','OBSTETRICIA'),
						('OD','ODONTOLOGIA'),
						('FP','PSICOLOGIA'),
						('QU','QUIMICA'),
						('TU','TURISMO'),
						('ZO','ZOOTECNIA')
						

-- Estudiantes
insert into Estudiante values
						('112207','IBARRA','CASTILLO','WALDO ERICK','Riesgo',1,'IN'),
						('141660','AROSTEGUI','CERNA','JAIR FREDERICK','Riesgo',1,'IN'),
						('154856','HUAHUATICO','SORIA','RONALD','Riesgo',1,'IN'),
						('164563','CARPIO','HERMOZA','HAIDER ALEX','Riesgo',1,'IN'),
						('175101','QUISPE','ESCALANTE','CARLA','Riesgo',1,'IN'),
						('184212','VALENCIA','CUSIPUMA','LUIS MAO','Riesgo',1,'IN'),
						('125156','CONDORI','FLORES','WILLIAMS DENNIS','No riesgo',1,'IN'),
						('150388','CHACON','VARGAS','JUAN ANTONIO','No riesgo',1,'IN'),
						('160886','CACERES','LOAYZA','MARIA LUISA','No riesgo',1,'IN'),
						('164240','ESCOBEDO','DURAN','ROBERTO CARLOS','No riesgo',1,'IN'),
						('171571','ROA','LIMACHI','JHON NILSON','No riesgo',1,'IN'),
						('182901','COLLANTE','CARRASCO','ALBERTO','No riesgo',1,'IN'),
						('184655','SANCA','ZEVALLOS','JERY','No riesgo',1,'IN'),
						('194525','PAREDES','CURASCO','ARELI SHALON','No riesgo',1,'IN'),
						('201228','ACHAHUI','CRUZ','MILTON AMED','No riesgo',1,'IN'),

						('113561','MAXDEO','LAGOS','KEVIN ROUSBEL','Riesgo',2,'IN'),
						('141671','PAREDES','DENOS','VICTOR ANIVAL','Riesgo',2,'IN'),
						('155182','MAR','GIBAJA','RENATO','Riesgo',2,'IN'),
						('164817','HUAYHUA','JURADO','TANY ARISTIDES','Riesgo',2,'IN'),
						('182893','AGUILAR','PORCEL','JAZMIN','Riesgo',2,'IN'),
						('184644','CCANCHI','CONDORI','ENMANUEL JESUS','Riesgo',2,'IN'),
						('130516','BUSTAMANTE','MAMANI','WASHINGTON MARCO','No riesgo',2,'IN'),
						('150396','LINARES','MIRANO','JOHN ABDUL','No riesgo',2,'IN'),
						('160889','CHOQUE','BUENO','FIORELLA SILVIA','No riesgo',2,'IN'),
						('164243','MACEDO','GHEILER','SEBASTIAN ISRAEL','No riesgo',2,'IN'),
						('171676','HUAMAN','AYMA','DERLY HAYLEY','No riesgo',2,'IN'),
						('182908','ESPINOZA','CHAMPI','ISRAEL ENRIQUE','No riesgo',2,'IN'),
						('185132','MAMANI','TAYÑA','GABRIEL ARTURO','No riesgo',2,'IN'),
						('194529','TORRES','MAMANI','GERSON','No riesgo',2,'IN'),
						('201230','CABRERA','MEJIA','CRISTIAN ANDY','No riesgo',2,'IN'),

						('012117','PINARES','BUSTAMANTE','SAMMY YASSER','Riesgo',3,'IN'),
						('120886','GALLEGOS','QUIÑONES','FREDY JULMER','Riesgo',3,'IN'),
						('144986','SOTO','COCHAMA','HUGO ROBERTO','Riesgo',3,'IN'),
						('160328','HUAMAN','CABRERA','YONATHAN','Riesgo',3,'IN'),
						('171059','FLORES','IGNACIO','JOSE LUIS','Riesgo',3,'IN'),
						('182922','MONTES','HUILLCA','FRANKLIN JESUS','Riesgo',3,'IN'),
						('184802','MAMANI','LAROTA','PAUL DAVID','Riesgo',3,'IN'),
						('70730','YAÑEZ','SANZ','ANTHONY JOSEPH','No riesgo',3,'IN'),
						('134403','CALLAPIÑA','CASTILLA','CIRO GABRIEL','No riesgo',3,'IN'),
						('151780','QUISPE','PUMA','LUCERO','No riesgo',3,'IN'),
						('160923','GONZALES','HUISA','NELSON','No riesgo',3,'IN'),
						('170430','COVARRUBIAS','AGUILAR','GEREMY ANDRE','No riesgo',3,'IN'),
						('171918','VELARDE','FLORES','MANUEL HUMBERTO','No riesgo',3,'IN'),
						('182923','MORA','CCARHUARUPAY','LUZ LUCERO','No riesgo',3,'IN'),
						('192424','MACCARCCO','QUISPE','KAROL GIANELLA','No riesgo',3,'IN'),
						('194921','SAMATA','PUMAHUALCCA','CRISTHIAN','No riesgo',3,'IN'),
						('204322','ZULOAGA','CCOPA','NILSON LEONEL','No riesgo',3,'IN'),

						('32648','LIMPE','ZEVALLOS','LUIS ANDRES','Riesgo',4,'IN'),
						('120893','PORROA','SIVANA','YENI RUTH','Riesgo',4,'IN'),
						('145002','HUALLPA','MONTALVO','RALEXS','Riesgo',4,'IN'),
						('160331','MOZO','DAVILA','MILTON ADERLIN','Riesgo',4,'IN'),
						('171060','FUENTES','CCORI','KEVIN HERNAN','Riesgo',4,'IN'),
						('182924','MUÑOZ','QUISPE','RUTH MERY','Riesgo',4,'IN'),
						('191871','IBARRA','HUAMANCARI','RAY MARCELO','Riesgo',4,'IN'),
						('71106','CCAHUANTICO','MENDOZA','JULIO CESAR','No riesgo',4,'IN'),
						('134540','VILLALBA','DELGADO','CLINTON EDSON','No riesgo',4,'IN'),
						('151827','LEVA','SALAS','RENAN FERDINAND','No riesgo',4,'IN'),
						('161133','FARFAN','LAZO','CESAR FRANCISCO','No riesgo',4,'IN'),
						('170432','GUTIERREZ','DAZA','GONZALO','No riesgo',4,'IN'),
						('171938','LOPE','TORRES','MARISOL','No riesgo',4,'IN'),
						('182926','ORTEGA','SULLCACCORI','ACCENT BLADIMIR','No riesgo',4,'IN'),
						('192426','NIÑO DE GUZMAN','CONDE','WENDEL YOVAN','No riesgo',4,'IN'),
						('194922','SILVA','GUEVARA','ESTEFAN POL','No riesgo',4,'IN'),
						('204792','ACHAHUANCO','VALENZA','ANDREE','No riesgo',4,'IN'),

						('52113','PUMA','HUILLCA','RICHARD JESUS','Riesgo',5,'IN'),
						('120895','QUISPE','PICHUILLA','AYRTON','Riesgo',5,'IN'),
						('145003','BARAZORDA','CUELLAR','HECTOR PAOLO','Riesgo',5,'IN'),
						('160332','QUISPE','JIMENEZ','MIGUEL ANGEL','Riesgo',5,'IN'),
						('171062','GUTIERREZ','SALAZAR','JUAN MANUEL','Riesgo',5,'IN'),
						('182925','OLIVARES','CAMERO','ALER SEBASTIAN','Riesgo',5,'IN'),
						('192414','BARRIENTOS','CRUZ','CRISTHIAN','Riesgo',5,'IN'),
						('80219','MOREANO','BRICEÑO','GROVER','No riesgo',5,'IN'),
						('134544','ZUNIGA','HUAMAN','EDI FRAI','No riesgo',5,'IN'),
						('151833','CONDE','CHURA','YURI FERNANDO','No riesgo',5,'IN'),
						('161134','FERNANDEZ','GUTIERREZ','MARUJEM LYLIBETH','No riesgo',5,'IN'),
						('170433','HOLGUIN','CONDORI','JULIO JOSUE','No riesgo',5,'IN'),
						('171943','BUSTAMANTE','FLORES','ERICK ANDREW','No riesgo',5,'IN'),
						('182927','PEÑA','LUQUE','RAISA MELINA','No riesgo',5,'IN'),
						('192428','RADO','HUAYOTUMA','ARTUR MARTI','No riesgo',5,'IN'),
						('195050','LOZANO','LLACCTAHUAMAN','MEDALY','No riesgo',5,'IN'),
						('204793','AGUILAR','SANCHEZ','NIK ANTONI','No riesgo',5,'IN'),

						('73289','BALLON','SEGOVIA','HENRY LUIS','Riesgo',6,'IN'),
						('120897','TELLO','JUSTINIANI','LUIS DAVID','Riesgo',6,'IN'),
						('145009','YCHU','VALENCIA','MIGUEL HUMBERTO','Riesgo',6,'IN'),
						('160336','TRIVEÑO','GUERRERO','MANUEL CAMILO','Riesgo',6,'IN'),
						('171524','PUMACAHUA','APAZA','LEONARDO CHEPPER','Riesgo',6,'IN'),
						('182929','QUISPE','ACERO','ALDAIR','Riesgo',6,'IN'),
						('192415','CARRION','QUINTANA','BRAYAN DANIEL','Riesgo',6,'IN'),
						('81561','HUACANI ','DE LA CRUZ','DANY DARWIN','No riesgo',6,'IN'),
						('140145','FLORES','MOLINA','GONZALO AMIR','No riesgo',6,'IN'),
						('151835','HUAMAN','LONCONI','MARCO ANTONIO','No riesgo',6,'IN'),
						('161365','GALLEGOS','HUAYHUA','VERONICA','No riesgo',6,'IN'),
						('170434','HUAMAN','HERMOZA','ANTONY ISAAC','No riesgo',6,'IN'),
						('174440','CONDORI','OCHOA','GIOVDEY ABRAHAM','No riesgo',6,'IN'),
						('182928','PUMA','SOTOMAYOR','RICHARD MIHAYLOR','No riesgo',6,'IN'),
						('192664','APARICIO','CASTILLA','BRAYAN GUSTAVO','No riesgo',6,'IN'),
						('200330','AMAO','ATAUCHI','JULIO CESAR','No riesgo',6,'IN'),
						('204794','CCANSAYA','SONCCO','REBECA ARACELI','No riesgo',6,'IN'),

						('83221','TRUJILLO','TORBISCO','LUIS ANDERSON','Riesgo',7,'IN'),
						('124218','UGARTE-LLANCAY','CARLOS ALFONSO','Riesgo','Riesgo',7,'IN'),
						('145213','CONDORI','HUILLCA','LIDER','Riesgo',7,'IN'),
						('160337','VITORINO','MARIN','EFRAIN','Riesgo',7,'IN'),
						('171565','MUÑOZ','PACHECO','CHRISTIAN FERNANDO','Riesgo',7,'IN'),
						('182931','QUISPE','MORA','ANDERSON','Riesgo',7,'IN'),
						('192416','CCASANI','HUAMAN','WILMAN','Riesgo',7,'IN'),
						('94303','NAHUAMEL','SARCE','DENIS ANGEL','No riesgo',7,'IN'),
						('140156','HUAMAN','MENDOZA','JOHAN WILFREDO','No riesgo',7,'IN'),
						('152128','ALTAMIRANO','ALMIRON','KONI INDIRA','No riesgo',7,'IN'),
						('161366','GONZALES','MANRRIQUE','LUCIO','No riesgo',7,'IN'),
						('170435','HUAMAN','TORRES','ALVARO RICARDO','No riesgo',7,'IN'),
						('174441','DEZA','KACHA','RENO MAX','No riesgo',7,'IN'),
						('182936','USUCACHI','ANO','ISAC ANDERSON','No riesgo',7,'IN'),
						('192665','FERNANDEZ','MANDURA','ROYER FUNACOSHI','No riesgo',7,'IN'),
						('200331','APAZA','CHOQQUE','WILSON','No riesgo',7,'IN'),
						('204795','CHOQUE','QUISPE','JADYRA CH@''ASKA','No riesgo',7,'IN'),

						('111868','VICENTE','RAMIREZ','GUIDO','Riesgo',8,'IN'),
						('141631','ABAL','VILLASANTE','JHOEL YOJHAN','Riesgo',8,'IN'),
						('154636','PALOMINO','AUQUITAYASI','JOSE RAMIRO','Riesgo',8,'IN'),
						('164246','PACHA','QUISPE','JEAN MARCO','Riesgo',8,'IN'),
						('175061','MAMANI','ZELA','NICHOLAS EDWARD','Riesgo',8,'IN'),
						('184209','SAIRE','SALAZAR','AXEL STEWARF','Riesgo',8,'IN'),
						('124821','ROJAS','CAHUANA','ETSON RONALDAO','No riesgo',8,'IN'),
						('150387','CARRILLO','INQUILTUPA','JULIO CESAR','No riesgo',8,'IN'),
						('160853','PUMA','MENDOZA','CARLOS EDUARDO','No riesgo',8,'IN'),
						('164238','CASILLA','TTITO','EVANDIR SAUL','No riesgo',8,'IN'),
						('171570','RAMOS','ALVAREZ','EDGAR DANIEL','No riesgo',8,'IN'),
						('182900','CHUNGA','CASTILLO','GARY BRIGHAM','No riesgo',8,'IN'),
						('184654','SACA','ACCOSTUPA','MIGUEL ENRIQUE','No riesgo',8,'IN'),
						('194524','MELENDRES','PEREZ','CRISTINA','No riesgo',8,'IN'),
						('200827','SUMIRE','CCAHUANA','KEVIN ARON','No riesgo',8,'IN'),

						('83222','VARGAS','QUISPE','CHARLY','Riesgo',9,'IN'),
						('124811','BERRIOS','VILLASANTE','RAQUEL MELISSA','Riesgo',9,'IN'),
						('150335','YUCRA','TTITO','LESLY YAHAIRA','Riesgo',9,'IN'),
						('160542','CÁCERES','HUANCA','ADHAIR EDHINO','Riesgo',9,'IN'),
						('171568','QUINCHO','RODRIGUEZ','JORDY GERSON','Riesgo',9,'IN'),
						('182933','SALINAS','ALARCON','PAULO CESAR','Riesgo',9,'IN'),
						('192418','CORNEJO','CASTRO','ANGELA LORENA','Riesgo',9,'IN'),
						('100511','GUTIERREZ','AMACHI','JUAN CARLOS','No riesgo',9,'IN'),
						('140934','VEGA CENTENO','OLIVERA','RONALDINHO','No riesgo',9,'IN'),
						('154628','CONDORI','HUAYCHAY','CESAR APARICIO','No riesgo',9,'IN'),
						('161368','LUNA','CCASANI','CHARLIE JOEL','No riesgo',9,'IN'),
						('170436','LUYCHO','ANCAIFURO','MARIELA','No riesgo',9,'IN'),
						('174442','ESCOBEDO','MESCCO','ANGIE','No riesgo',9,'IN'),
						('182940','VILLASANTE','LEON','AMARU','No riesgo',9,'IN'),
						('192975','ZAPANA','FLORES','GEORGE ALEXANDER','No riesgo',9,'IN'),
						('200332','CUSACANI','GONZALES','GERALD ANTONIO','No riesgo',9,'IN'),
						('204796','FARFAN','LUNA','JANNIRA ALISON','No riesgo',9,'IN'),

						('120879','ANCCO','PERALTA','RUBEN','Riesgo',10,'IN'),
						('143830','AIMA','JALISTO','JOHN ALDAIR','Riesgo',10,'IN'),
						('160326','CANO','LOAIZA','MICHEL','Riesgo',10,'IN'),
						('170749','CARMONA','CHOQUEMAMANI','KENNY HAROLD','Riesgo',10,'IN'),
						('182913','HUAHUALUQUE','VARGAS','JHAMIL JHONATAN','Riesgo',10,'IN'),
						('184656','SUAREZ','MARISCAL','MARCELO EDUARDO','Riesgo',10,'IN'),
						('133962','CHOQUENAIRA','QUISPE','NOE FRANKLIN','No riesgo',10,'IN'),
						('151332','NOLAZCO','SANDOVAL','SHAROM MITCHEL','No riesgo',10,'IN'),
						('160895','TTITO','ENRIQUEZ','LEANDRO','No riesgo',10,'IN'),
						('170427','CARCAUSTO','MAMANI','ELIZON FRANK','No riesgo',10,'IN'),
						('171915','NINANTAY','DIAZ','MILEYDY','No riesgo',10,'IN'),
						('182917','MAMANI','GABRIEL','BRUCE MAXIMO','No riesgo',10,'IN'),
						('192419','CUSI','QUISPE','YANET','No riesgo',10,'IN'),
						('194918','GAMARRA','FLORES','DAYHANA LUCERO','No riesgo',10,'IN'),
						('204320','GARCIA','ROMERO','JHONATAN ALEXANDER','No riesgo',10,'IN'),

						('111856','BACA','CHOQUE','CARLOS ALFREDO','Riesgo',11,'IN'),
						('141599','VENTURA','JAUJA','JAIME','Riesgo',11,'IN'),
						('154632','CHAMPI','PUMA','WILLIAM RUIZ','Riesgo',11,'IN'),
						('164245','NINA','GUARDAPUCLLA','JHOSET DAVID','Riesgo',11,'IN'),
						('175022','BAUTISTA','HURTADO','OWEN DEISER','Riesgo',11,'IN'),
						('184206','MEZA','ZAMALLOA','MARCUS GEUSEPPE','Riesgo',11,'IN'),
						('124813','DE LA CRUZ','QUISPE','ALEX ALBERTO','No riesgo',11,'IN'),
						('150379','QUISPE','QUISPE','JOEL','No riesgo',11,'IN'),
						('160696','HUAMAN','MORALES','ANGGIE ANTUANE','No riesgo',11,'IN'),
						('164237','CARRION','ACUÑA','JHOSEP ANTONY','No riesgo',11,'IN'),
						('171567','PUCLLA','HUAMAN','DIANA STEPHANIE','No riesgo',11,'IN'),
						('182898','CERATI','CERRILLO','FIORELLA','No riesgo',11,'IN'),
						('184653','RODRIGUEZ','CASAS','MARJORIE REBECCA','No riesgo',11,'IN'),
						('194523','MAMANI','MEZA','JOHANA MARIA','No riesgo',11,'IN'),
						('200826','RODRIGUEZ','PHILLCO','JAIME ANTONIO','No riesgo',11,'IN'),

						('91613','RAMIREZ','APAZA','EBERT','Riesgo',12,'IN'),
						('125110','VERA','CCASA','NAYLUZ ROSMERY','Riesgo',12,'IN'),
						('150389','CONDE','SALLO','JHACK STEVEN','Riesgo',12,'IN'),
						('160888','CANA','APU','ORLANDO','Riesgo',12,'IN'),
						('171569','QUISPE','HANCCO','FERNANDO','Riesgo',12,'IN'),
						('182934','SAPACAYO','HUAYHUA','TEOFILO SOCRATES','Riesgo',12,'IN'),
						('192420','GUEVARA','DELGADO','TIRSSA IVONNE','Riesgo',12,'IN'),
						('101059','CASTILLO','LOPEZ','RICARDO JORGE','No riesgo',12,'IN'),
						('140985','LIMPE','QUISPE','JERRY ANDERSON','No riesgo',12,'IN'),
						('154631','NOLASCO','SUYO','CARLOS ANTONI','No riesgo',12,'IN'),
						('161369','MUÑOZ','MUÑOZ','WILY RODRIGO','No riesgo',12,'IN'),
						('170594','DORADO','TORRES','DIEGO ALONSO','No riesgo',12,'IN'),
						('174447','QUISPE','CHAMBILLA','CARLOS ENRIQUE','No riesgo',12,'IN'),
						('182941','YUCA','LIMA','KARLA URBELINDA','No riesgo',12,'IN'),
						('192997','ARCE','QUISPE','RUTH MILAGROS','No riesgo',12,'IN'),
						('200333','ESPINOZA','COLCA','NAHYELY ALANIZ','No riesgo',12,'IN'),
						('204797','HANCCO','CHAMPI','FRAN ANTHONY','No riesgo',12,'IN'),

						('91622','VALDEZ','CGUNO','JULIO CESAR','RIESGO',13,'IN'),
                        ('130737','DIANDERAS','LOPEZ','JHOHELLS ERICK','RIESGO',13,'IN'),
                        ('150397','LOAIZA','MONROY','BRUNO WALDIR','RIESGO',13,'IN'),
                        ('160892', 'LIMACHI','ORTEGA','FREDDY' ,'RIESGO',13,'IN'),
						('171573','YAÑEZ','TUERO','JOSE ANGEL','RIESGO',13,'IN'),
					    ('182935','USCACHI','CCAPA','ERICK ','RIESGO',13,'IN'),
						('192421','HUAMAN','MERINO','ALFREDO ALIPIO ','RIESGO',13,'IN'),
						('103170','MOROCCO','LAYME','JONATHAN','NO RIESGO',13,'IN'),
						('140987','VILLARES','SUBLE','ALDAIR WILBERT','NO RIESGO',13,'IN'),
						('154633','CONDORI','CCARHUARUPAY','BRUNO MOISES','NO RIESGO',13,'IN'),
						('161727','MUÑOZ','PACHECO','ENIT','NO RIESGO',13,'IN'),
						('170748','ARAUJO','LECHUGA','LUIS AUGUSTO','NO RIESGO',13,'IN'),
						('174450','SALAS','CCOLQQUE','WILLIAN','NO RIESGO',13,'IN'),
						('182942','ZUNIGA','AUCCAHUAQUI','JUAN MANUEL','NO RIESGO',13,'IN'),
						('192998','CARDENAS','HUAMAN','FABRICIO YARED ','NO RIESGO',13,'IN'),
						('200334','LIMA','ESPERILLA','KATERINE CANDY','NO RIESGO',13,'IN'),
						('204798','HUARACALLO','ARENAS','LINO ZEYNT','NO RIESGO',13,'IN'),

						('93160','CHARA','TACURI','CESAR ','RIESGO',14,'IN'),
						('130740','HUILLCA','HUILLCA','ABIGAIL ','RIESGO',14,'IN'),
						('150400','OCHOA','MAMANI','RICARDO','RIESGO',14,'IN'),
						('161135','QUISPE','TACURI','RUDI','RIESGO',14,'IN'),
						('171605','SALINAS','ATAUSINCHI','JERSON','RIESGO',14,'IN'),
						('182937','VELASQUEZ','DURAND','HANS ROBERT','RIESGO',14,'IN'),
						('192423','LOPEZ','BARAZORDA','JHON ANTHONY','RIESGO',14,'IN'),
						('103172','PALOMINO','POVEA','ANGEL','NO RIESGO',14,'IN'),
						('140998','TTITO','QUILCA','CESAR RODRIGO','NO RIESGO',14,'IN'),
						('154637','NINA','PONCE','JOSUE JOSE','NO RIESGO',14,'IN'),
						('161731','SONCCO','CACHURA','DAVID','NO RIESGO',14,'IN'),
						('170750','CUSIHUAMAN','AUCCACUSI','LUIS ALDAIR','NO RIESGO',14,'IN'),
						('174452','SARCO','JACINTO','DANIEL EDUARDO','NO RIESGO',14,'IN'),
						('183055','CARBAJAL','CARRASCO','GABRIEL','NO RIESGO',14,'IN'),
						('192999','CCONCHO','CASTELLANOS','MIGUEL ANGEL','NO RIESGO',14,'IN'),
						('200335','MAMANI','SAMATA','MAYCOHLL BERLY','NO RIESGO',14,'IN'),
						('204799','JALLO','PACCAYA','YASUMY MARICELY','NO RIESGO',14,'IN'),

						('110597','LLOCLLE','PUMA','HOLGUER','RIESGO',15,'IN'),
						('141010','RAMIREZ','ALVAREZ','LUISBERTO','RIESGO',15,'IN'),
						('154623','SOTO','MAMANI','HEDDED JOEL','RIESGO',15,'IN'),
						('164241','GIRALDO','ENCISO','DAVID','RIESGO',15,'IN'),
						('174944','CONDORI','MOZO','WESLEY JUANPEDRO','RIESGO',15,'IN'),
						('184203','HUAMAN','ATAYUPANQUI','LISBET PAOLA','RIESGO',15,'IN'),
						('200339','QUISPE','HUITOCALLO','GABRIEL','RIESGO',15,'IN'),
						('124219','VALLE','HUAMAN','MARIA ANGELA','NO RIESGO',15,'IN'),
						('145005','QUISPE','CORONEL','ANDREE YORDAN','NO RIESGO',15,'IN'),
						('160544','JARA','HILLPA','LUIS ABELARDO','NO RIESGO',15,'IN'),
						('164235','CALLAPIÑA','RODRIGUEZ','JOSUE CRISTIAN','NO RIESGO',15,'IN'),
						('171260','QUISPE','TTITO','JOEL WILLY','NO RIESGO',15,'IN'),
						('182894','ANDIA','JAEN','ANDRES RODRIGO','NO RIESGO',15,'IN'),
						('184647','FLORES','NIETO','CARLOS FABRICIO','NO RIESGO',15,'IN'),
						('194519','HUAMAN','QUISPE','JEMY SANDRO','NO RIESGO',15,'IN'),
						('200824','LEVITA','QUISPE','LUIS ALVINO','NO RIESGO',15,'IN'),

						('93169','HUAMANI','FLOREZ','RONALD','RIESGO',16,'IN'),
						('130741','MERMA','QUISPE','HAROL HELBERT','RIESGO',16,'IN'),
						('150404','QUEKQAÑO','QUISPE','CAYO ABEL','RIESGO',16,'IN'),
						('161136','TTITO','OCSA','JOSE ROLANDO','RIESGO',16,'IN'),
						('171866','QUISPE','YAHUIRA','RONALDO JERSON','RIESGO',16,'IN'),
						('182938','VILLAFUERTE','GARCES','EDU RODRIGO','RIESGO',16,'IN'),
						('192425','MAYTA','SALAZAR','HERBERTH CLAUDD','RIESGO',16,'IN'),
						('103637','AMAO','SULLCAHUAMAN','SHUI DANITZA','NO RIESGO',16,'IN'),
						('140999','ANCCO','PERALTA','ROSARIO','NO RIESGO',16,'IN'),
						('155180','MASIAS','USCAMAYTA','NAOMI ISABEL','NO RIESGO',16,'IN'),
						('161756','CCONISLLA','MEDINA','ANTHONY ALDAIR','NO RIESGO',16,'IN'),
						('171057','CALDERON','TINTAYA','FALLCHA XIOMARA','NO RIESGO',16,'IN'),
						('174454','TINTAYA','TACO','YUREMA LISBETH','NO RIESGO',16,'IN'),
						('183369','DEL CASTILLO','OVALLE','LUZ MARINA','NO RIESGO',16,'IN'),
						('193000','CHOQUELUQUE','GARCIA','ALEJANDRO MIGUEL','NO RIESGO',16,'IN'),
						('200336','ORCCON','DIAZ','DARCY OMAR','NO RIESGO',16,'IN'),
						('204800','MUÑOZ','CASTILLO','GEORGE IVANOK','NO RIESGO',16,'IN'),

                        ('93175','LAYME','MAMANI','NELSON','RIESGO',17,'IN'),
                        ('131050','SANDI','MAMANI','ALEX','RIESGO',17,'IN'),
						('150406','SANGA','MONRROY','ROGER','RIESGO',17,'IN'),
					    ('161367','HUALVERDE','QUISPE','BENJAMIN ALEXANDER','RIESGO',17,'IN'),
						('174439','CHOQUECONZA','QUISPE','NORGAN SANDRO','RIESGO',17,'IN'),
						('182939','VILLALOBOS','QUISPE','PAMELA ARACELY ','RIESGO',17,'IN'),
						('192427','PORTILLO','HUAMAN','ERICK NICASIO','RIESGO',17,'IN'),
						('103644','LARICO','RODRIGO','EDER PAUL','NO RIESGO',17,'IN'),
						('141000','ASCUE','PEÑA','AXEL RICARDO','NO RIESGO',17,'IN'),
						('155183','VARGAS','ARQQUE','JEREMYK RUFINO','NO RIESGO',17,'IN'),
						('161757','CCUITO','QUISPE','JHON ALBERT','NO RIESGO',17,'IN'),
						('171058','DEZA','CONDORI','ROSMEL URIEL','NO RIESGO',17,'IN'),
						('174455','UGARTE','CASTILLO','BRIGGITTE LEONOR','NO RIESGO',17,'IN'),
						('183464','MALDONADO','CARDEÑA','STIWARTH D´ALENBERT','NO RIESGO',17,'IN'),
						('193001','GIFONE','VILLASANTE','EDUARDO JUAREIS','NO RIESGO',17,'IN'),
						('200337','POMA','SUPO','JUAN GABRIEL','NO RIESGO',17,'IN'),
						('204801','OLIVARES','TORRES','YAQUELYN ROSALINDA','NO RIESGO',17,'IN'),
						  
						('93178','MAMANI','CRISPIN','ISAI ISAAC','RIESGO',18,'IN'),
                        ('131605','AYQUIPA','GOMEZ','AMILCAR','RIESGO',18,'IN'),
						('150495','QUISPE','CLEMENTE','SAMAN','RIESGO',18,'IN'),
					    ('161759','HUACHACA','PINEDA','HUMBERTO','RIESGO',18,'IN'),
						('174443','FARFAN','MOSCOSO','JUAN VICTOR','RIESGO',18,'IN'),
						('183078','PHUYO','HUAMAN','EDSON LEONID','RIESGO',18,'IN'),
						('192430','TTITO','QUISPE','ABELARDO','RIESGO',18,'IN'),
						('110125','LOPINTA','HUAMAN','CRISTIAN RODRIGO','NO RIESGO',18,'IN'),
						('141154','FERNANDEZ','TILCA','CHRIS IALEEN','NO RIESGO',18,'IN'),
						('155184','MAMANI','CCANAHUIRE','LALO LEONEL','NO RIESGO',18,'IN'),
						('161758','FLOREZ','CCOA','LUIGGI EDUARDO','NO RIESGO',18,'IN'),
						('171061','GUEVARA','FERRO','CRISTIAN LUIS','NO RIESGO',18,'IN'),
						('174905','AGUILAR','MAINICTA','GIAN MARCO','NO RIESGO',18,'IN'),
						('183469','PIMENTEL','FRANCO','GONZALO MARTIN','NO RIESGO',18,'IN'),
						('193002','MERCADO','HUAYCHO','ADELMECIA','NO RIESGO',18,'IN'),
						('200338','QUISPE','AGUILAR','ROGER','NO RIESGO',18,'IN'),
						('204803','PACHARI','LIPA','MILTON ALEXIS','NO RIESGO',18,'IN'),

						('100031','DURAND','NAVARRO','LUISA SHIRLEY','RIESGO',19,'IN'),
                        ('131612','MONTAÑEZ','CHOQUE','WILLIANS','RIESGO',19,'IN'),
						('151448','ROMAN','CUELLAR','JUAN MANUEL','RIESGO',19,'IN'),
					    ('161760','HUAMAN','VARGAS','PERCY ELVIS','RIESGO',19,'IN'),
						('174445','OLARTE','CASAS','RODRIGO FABRICIO','RIESGO',19,'IN'),
						('183218','QUISPE','MENDOZA','DIEGO','RIESGO',19,'IN'),
						('192666','MELENDEZ','MENDIGURE','EDWARD','RIESGO',19,'IN'),
						('110603','PUMAYALLI','CUSICUNA','FRANK EDISON','NO RIESGO',19,'IN'),
						('141158','SAIRE','HANCCO','CESAR ANDERSSON','NO RIESGO',19,'IN'),
						('155185','PEZUA','CERNADES','ARACELY','NO RIESGO',19,'IN'),
						('161762','MORA','HUICHI','ALEX CRISTIAN','NO RIESGO',19,'IN'),
						('171063','MALLQUI','APAZA','NADIABETH DIANA','NO RIESGO',19,'IN'),
						('174908','CASILLA','PERCCA','VLADIMIR DANTE','NO RIESGO',19,'IN'),
						('184192 ','ARCE','QUISPE','LISBETH','NO RIESGO',19,'IN'),
						('193003','NOA','LLASCCANOA','ELIAZAR','NO RIESGO',19,'IN'),
						('200340','QUISPE','TAYÑA','JOSE LUIS','NO RIESGO',19,'IN'),
						('204804','PEÑA','CABALLERO','JOSE LUIS','NO RIESGO',19,'IN'),

						('100505','ARONI','SOTO','WARREN STEPHEN','RIESGO',20,'IN'),
                        ('133960','CHAMPI','CHAMPI','ABRAHAN ELIAS','RIESGO',20,'IN'),
						('151450','ACHAHUANCO','ACHAHUI','EURIDICE INGRID','RIESGO',20,'IN'),
						('161761','HUAMANI','SURCO','GROBER ALBERT','RIESGO',20,'IN'),
						('174446','PORRAS','CHARCA','JAVIER GUSTAVO','RIESGO',20,'IN'),
					    ('183485','SULLCA','AQUINO','JOSE ANTONIO','RIESGO',20,'IN'),
						('193004','PARQUE','AROSQUIPA','LENIN JOAQUIN','RIESGO',20,'IN'),
						('111175','CARRASCO','CUNZA','DANIEL ALEXANDER','NO RIESGO',20,'IN'),
						('141670','HALIRE','HUAMAN','JAIME ANDREE','NO RIESGO',20,'IN'),
						('155186','ALARCON','MAMANI','JHON ALFRED','NO RIESGO',20,'IN'),
						('161764','SALAS','HUAMANI','MARITZA FLOR','NO RIESGO',20,'IN'),
						('171064','ORE','GAMARRA','ABRAHAM BENJAMIN','NO RIESGO',20,'IN'),
						('174909','CHOQUE','SARMIENTO','LEYDI DIANA','NO RIESGO',20,'IN'),
						('184194','CONDORCAHUA','AYLLONE','FERDINAN JUNIOR','NO RIESGO',20,'IN'),
						('193027','BLANCO','MOZO','CARMEN GUADALUPE','NO RIESGO',20,'IN'),
						('200341','SANCHEZ','CHACON','ELBERT CESAR','NO RIESGO',20,'IN'),
						('204806','SANCHEZ','PALOMINO','DENNIS OSWALDO','NO RIESGO',20,'IN'),

						('101526','ORUE','QUISPE','ALVARO AMERICO','RIESGO',21,'IN'),
                        ('133963','CONSA','QQUECCAÑO','FERDINAN','RIESGO',21,'IN'),
						('151737','MERINO','SOLANO','WILLIAM','RIESGO',21,'IN'),
                        ('163806','ASENCIO','ARQQUE','JHOEL FELIX','RIESGO',21,'IN'),
						('174449','SAIRE','BUSTAMANTE','EDMIL JAMPIER','RIESGO',21,'IN'),
					    ('183885','CHILE','QUIROGA','HILDEMARO','RIESGO',21,'IN'),
						('193168','ESPINOZA','OTAZU','FREDIMAR','RIESGO',21,'IN'),
						('111332','QUISPE','CALANCHI','JOSE WALTHER','NO RIESGO',21,'IN'),
						('143833','MELO','GUTIERREZ','RAUL ELVER','NO RIESGO',21,'IN'),
						('155189','HUARAYA','CHARA','BLADIMIR','NO RIESGO',21,'IN'),
						('161765','ZUÑIGA','RAMOS','DANIEL ANTONY','NO RIESGO',21,'IN'),
						('171066','QUINTO','CATACHURA','LADY DIANA','NO RIESGO',21,'IN'),
						('174910','CUSI','HUAYLLA','MIGUEL ANGEL','NO RIESGO',21,'IN'),
						('184195','CORDOVA','CCOPA','EMERSON','NO RIESGO',21,'IN'),
						('193109','COLQUE','GALINDO','JEAN FRANCO','NO RIESGO',21,'IN'),
						('200518','ALAGON','FERNANDEZ','ANGHELO','NO RIESGO',21,'IN'),
						('204807','TINOCO','CCOTO','LUIS MANUEL','NO RIESGO',21,'IN'),

						('113553','FLORES','YUCRA','IGNACIO','RIESGO',22,'IN'),
                        ('141664','CONDE','PADIN','GEORGE ADOLFO','RIESGO',22,'IN'),
						('155179','QUISPE','LAROTA','YHON LENIN','RIESGO',22,'IN'),
						('164564','ESPINAL','HUAMAN','ANGEL PLACIDO','RIESGO',22,'IN'),
                        ('182727','CCAHUANTICO','NINAMEZA','LUIS FERNANDO','RIESGO',22,'IN'),
					    ('184641','BAUTISTA','HUILLCA','RUBEN RONALD','RIESGO',22,'IN'),
						('130322','PEREZ','TOMAYLLA','BRUNO','NO RIESGO',22,'IN'),
						('150394','HUAMAN','GUEVARA','ALEXANDER JAVIER','NO RIESGO',22,'IN'),
						('160887','CALLA','YARIHUAMAN','FERNANDO RAFAEL','NO RIESGO',22,'IN'),
						('164242','INQUILTUPA','CORTEZ','PATRICK ANTONIO','NO RIESGO',22,'IN'),
						('171572','SALCEDO','HURTADO','JORGE ANDRE','NO RIESGO',22,'IN'),
						('182906','CUYO','TTITO','DENIS OMAR','NO RIESGO',22,'IN'),
						('184689','PILLCO','FLORES','LISBETH','NO RIESGO',22,'IN'),
						('194527','QUISPE','SANTA CRUZ','YOEL SANDRO','NO RIESGO',22,'IN'),
						('201229','ARANA','FLORES','SHAIEL ALMENDRA','NO RIESGO',22,'IN'),
						   
						('101658','CHOQUE','CCOA','DENNIS ALIPIO','RIESGO',23,'IN'),
                        ('134033','QUISPE','USCAMAYTA','ROBERT ANDRES','RIESGO',23,'IN'),
						('151760','SALAZAR','MUELLE','BRAYAN DARIO','RIESGO',23,'IN'),
					    ('163808','LOZANO','LLACCTAHUAMAN','ROYER BRANDON','RIESGO',23,'IN'),
						('174457','VELASQUEZ','QUISPE','OLIVER STIVEN','RIESGO',23,'IN'),
						('184191','ALVAREZ','MEJIA','ARTURO','RIESGO',23,'IN'),
						('193807','JANCCO','CONCHA','CESAR AUGUSTO','RIESGO',23,'IN'),
						('111860','CHALCO','CARRASCO','DENNIS ERICK','NO RIESGO',23,'IN'),
						('144884','POCCORI','ESCALANTE','JUAN DIEGO','NO RIESGO',23,'IN'),
						('155372','KU','ANDRADE','ANGELO PIETRI','NO RIESGO',23,'IN'),
						('161783','ALVAREZ','QUISPE','LISHIEL','NO RIESGO',23,'IN'),
						('171067 ','QUISPE','SERRANO','HILLARY CRISTINA','NO RIESGO',23,'IN'),
						('174911','HUANCARA','CCOLQQUE','ALEX HELDER','NO RIESGO',23,'IN'),
						('184207','PACCO','YLLA','YONATAN','NO RIESGO',23,'IN'),
						('193110','FIGUEROA','RODRIGUEZ','ASTRID','NO RIESGO',23,'IN'),
						('200519','OCHOA','BARRIOS','JESUS GUSTAVO','NO RIESGO',23,'IN'),
						('204808','TORREBLANCA','PAZ','SEBASTIAN VICTOR','NO RIESGO',23,'IN'),

						('101659','FERIA','TAPARA','JOSE ADOLFO','RIESGO',24,'IN'),
						('134134','MELGAREJO','SAAVEDRA','SAULO SHALON','RIESGO',24,'IN'),
						('151775','QUISPE','GONZALES','BRENDA NAHOMI','RIESGO',24,'IN'),
						('163809','MAMANI','CHINO','RUBEN','RIESGO',24,'IN'),
						('174838','CALLHUA','ALDAZABAL','OSBALDO DAN','RIESGO',24,'IN'),
						('184196','CUSI','FUENTES','GONZALO','RIESGO',24,'IN'),
						('193830','CCALA','HUAMANI','CRISTHIAN ','RIESGO',24,'IN'),
                        ('113567','QUISPE','HUARHUA','IVAN ARTHUR','NO RIESGO',24,'IN'),
						('144987','MENDOZA','CJUIRO','NILO FIDEL','NO RIESGO',24,'IN'),
						('160325','APAZA','GARRIDO','MANUEL ALFREDO','NO RIESGO',24,'IN'),
						('163525','FARFAN','ENRIQUEZ','GABRIELA','NO RIESGO',24,'IN'),
						('171068','RODRIGUEZ','HANCCO','RUDY RODRIGO','NO RIESGO',24,'IN'),
						('174912','INCA','CRUZ','CARLOS EDUARDO','NO RIESGO',24,'IN'),
						('184210','TAPIA','QUISPE','ANDRE WASHINGTON','NO RIESGO',24,'IN'),
						('193129','TTITO','HUAMAN','KEVIN JHOEL','NO RIESGO',24,'IN'),
						('200520','REYNAGA','FLORES','ANGELA VANESSA','NO RIESGO',24,'IN'),
						('204809','TORRES','MENDOZA','RAUL','NO RIESGO',24,'IN'),

						('114141','FLORES','SANTOS','YEREMI ANDREI','Riesgo',25,'IN'),
						('141674', 'VILCA','PANTIGOSO','KAROL BERLIZ', 'Riesgo',25,'IN'),
						('155192','NUÑEZ','HUALLA','ALFREDO','Riesgo',25,'IN'),
						('170440' ,'ROJAS','GARAY','JAFET CALEB','Riesgo',25,'IN'),
						('182904','CURO','MAMANI','ALEX YTALO','Riesgo',25,'IN'),
						('184651','MAMANI','TAIRO','ROY MARVIN','Riesgo',25,'IN'),
						('131610','MEDINA','VILLAFUERTE','GRAITD KATERINE','No riesgo',25,'IN'),
						('150409','TTITO','RAMOS','MANUEL DARIO','No riesgo',25,'IN'),
						('160893','OLAZABAL','CALLER','LETICIA GIULIANA','No riesgo',25,'IN'),
						('164566','MAMANI','QUINTA','MICHAEL ANTONNI','No riesgo',25,'IN'),
						('171910' ,'GUERRA','BELLIDO','JHON WALDIR','No riesgo',25,'IN'),
						('182914' ,'HUAMAN','MENDOZA','ELVIS JORGE','No riesgo',25,'IN'),
						('191874','VALENCIA','ÑAUPA','MARKO LEONEL','No riesgo',25,'IN'),
						('194916','BACILIO','HUAMAN','JEAN MARCO','No riesgo',25,'IN'),
						('204318','BELLIDO','ARMUTO','ABEL ENRIQUE','No riesgo',25,'IN'),

						('113562', 'MENDOZA','HUAILLAPUMA','ELISBAN','Riesgo',26,'IN'),
						('141672','CORNEJO','CRUZ','JULIO WILSON','Riesgo',26,'IN'),
						('155190','HINOJOSA','HUARCA','BRAYAN ALEXANDERT','Riesgo',26,'IN'),
						('170428','CASSA','LIPA','EDWAR YURI','Riesgo',26,'IN'),
						('182899','CHOQUEPATA','HUAMAN','VANESSA','Riesgo',26,'IN'),
						('184649','HUACHACA','PEDRAZA','ALVARO','Riesgo',26,'IN'),
						('130736','CUTIRE','ARCE','NICO ALVARO','No riesgo',26,'IN'),
						('150401','PARI','ARRIAGA','DENILSON','No riesgo',26,'IN'),
						('160890','CORDOVA','CASTRO','MARKO LEUGIM','No riesgo',26,'IN'),
						('164248','PUMA','POTOCINO','JOSE FRANCISCO','No riesgo',26,'IN'),
						('171805','ROJAS','SOTO','CLAUDIA LUZ','No riesgo',26,'IN'),
						('182909','ESTRELLA','VILCA','JAMES KEVIN','No riesgo',26,'IN'),
						('191870','CAHUATA','LAVILLA','YOLMY MILAGROS','No riesgo',26,'IN'),
						('194530','ZEVALLLOS','VIDAL','NYCOLL TATIANA','No riesgo',26,'IN'),
						('201231','CALLAÑAUPA','SALLO','JULIO CESAR','No riesgo',26,'IN'),

						('101664','QUISPE','RODRIGUEZ','LUIS ALEXEI','Riesgo',27,'IN'),
						('134537','HUAYTA','OBLITAS','JOSE CARLOS','Riesgo',27,'IN'),
						('151812','FERRO','ALVAREZ','JUSTINO','Riesgo',27,'IN'),
						('163810','RODRIGUEZ','HUARACA','YOFRE','Riesgo',27,'IN'),
						('174856','MAMANI','HUAMAN','KALEB GEDEON','Riesgo',27,'IN'),
						('184197','FERNANDEZ BACA','CASTRO','LUCIAN NEPTALI','Riesgo',27,'IN'),
						('193835','LAVILLA','BOLAÑOS','JERSON EDU','Riesgo',27,'IN'),
						('113572','AUCAPIÑA','SUVIZARRETA','EDWAR','No riesgo',27,'IN'),
						('144992','QUINTANILLA','CERON','JIMY NICANOR','No riesgo',27,'IN'),
						('160329','HUILLCA','MOZO','BRYAN','No riesgo',27,'IN'),
						('163671','ROBLES','SILVA','ANGELO','No riesgo',27,'IN'),
						('171069','RODRIGUEZ','OJEDA','JORGE VICTOR','No riesgo',27,'IN'),
						('174913','NAOLA','PUMA','EDWARD BRAYAN','No riesgo',27,'IN'),
						('184211','TINCUSI','CCORIMANYA','JHON JAIME','No riesgo',27,'IN'),
						('193832','CORTEZ','CCAHUANTICO','PAOLA ANDREA','No riesgo',27,'IN'),
						('200788','SULLCARANI','DIAZ','BORIS ELOY','No riesgo',27,'IN'),
						('992091','CRUZ','ZAMALLOA','OMAR ROLANDO','No riesgo',27,'IN'),

						('103171','NAHUAMEL','SARCE','JHON ANDER','Riesgo',28,'IN'),
						('134683','DURAND','NAVARRO','ANNELLY','Riesgo',28,'IN'),
						('151822','PUMA','MAMANI','NILSON MAURIÑO','Riesgo',28,'IN'),
						('163811','SENCIA','GUTIERREZ','BETO RONALDO','Riesgo',28,'IN'),
						('174864','RAMOS','CONDORI','DANNY','Riesgo',28,'IN'),
						('184198','FERNANDEZ','ALVAREZ','DIEGO','Riesgo',28,'IN'),
						('194520','LLAMOCCA','QUISPE','FRANKLIN','Riesgo',28,'IN'),
						('114146','JOVE','CHIRINOS','PERCY BRYAN','No riesgo',28,'IN'),
						('144993','IBARRA','HUAMAN','ALEXANDER PAVEL','No riesgo',28,'IN'),
						('160333','REYES','VALLE','NILSON','No riesgo',28,'IN'),
						('163807','CHATA','HUALLPAYUNCA','MILTON ANDERSON','No riesgo',28,'IN'),
						('171070','SULLCA','PERALTA','MELANIE INDIRA','No riesgo',28,'IN'),
						('174914','QUISPE','PALOMINO','LUIYI ANTONY','No riesgo',28,'IN'),
						('184604','LOPEZ','OQUENDO','ANTHONY MAYRON','No riesgo',28,'IN'),
						('193834','GODOY','LACUTA','CRISTIAN AYRTHON','No riesgo',28,'IN'),
						('200820','ATAUCHI','MAMANI','JOSE EMILIO','No riesgo',28,'IN'),
						('992175','MONDRAGON','PORRAS','LUIS CARLOS','No riesgo',28,'IN'),

						('120883','CJUNO','MACHACA','ALEX SAIN','Riesgo',29,'IN'),
						('144202','CURSE','CACERES','MAVILA DANITZA','Riesgo',29,'IN'),
						('160327','CUSI','HUAMAN','KEVIN YEISON','Riesgo',29,'IN'),
						('170751','ENRIQUEZ','QUISPE','JOHN KEVIN','Riesgo',29,'IN'),
						('182921','MOLLINEDO','PEÑA','ALVARO SEBASTIAN','Riesgo',29,'IN'),
						('184780','PAUCCAR','BLANCO','HAPMYR ERWIN','Riesgo',29,'IN'),
						('133964','GONZALES','MEZA','JHENDY EDER','No riesgo',29,'IN'),
						('151388','CACERES','QUISPE','MARIA FERNANDA','No riesgo',29,'IN'),
						('160920','CHOQUE','NAVARRO','MARCELO FABIAN','No riesgo',29,'IN'),
						('170429','CONDORI','LOPEZ','JUAN CARLOS','No riesgo',29,'IN'),
						('171916','PEREIRA','CHINCHERO','RICHARD MIKHAEL','No riesgo',29,'IN'),
						('182920','MERMA','HUAMAN','NOHEMI NATALIA','No riesgo',29,'IN'),
						('192422','HUAMAN','QUISPE','ANDY MARCELO','No riesgo',29,'IN'),
						('194919','HUAICOCHEA','CARDENAS','WILBER EMANUEL','No riesgo',29,'IN'),
						('204321','NIETO','BARRIENTOS','YISHAR PIERO','No riesgo',29,'IN'),

						('103179','YARANGA','ACHAHUI','ALDO','Riesgo',30,'IN'),
						('140984','CCAPATINTA','QQUECCAÑO','DENNIS MOISES','Riesgo',30,'IN'),
						('151830','VALDEIGLESIAS','DUEÑAS','NAJOR JOSUE','Riesgo',30,'IN'),
						('163813','VIZCARRA','VARGAS','MARCELO ANGELO','Riesgo',30,'IN'),
						('174906','APAZA','HUAMANI','FRANK CLINTON','Riesgo',30,'IN'),
						('184199','GALLEGOS','CJUIRO','LUIS ALBERTO','Riesgo',30,'IN'),
						('194522','MAMANI','MESCCO','LUIS ANTHONY','Riesgo',30,'IN'),
						('120285','PUMA','JARA',' MIGUEL ANGEL CRISOLOGO','No riesgo',30,'IN'),
						('144994','SULLCAHUAMAN','VALDEZ','DENNYS YUTARO','No riesgo',30,'IN'),
						('160338','YUPANQUI','CARRILLO','HOLGER ALFREDO','No riesgo',30,'IN'),
						('163812','VIZA','AEDO','NESTOR','No riesgo',30,'IN'),
						('171071','YARAHUAMAN','ROJAS','MILAGROS','No riesgo',30,'IN'),
						('174961','VILCAHUAMAN','CACERES','MIGUEL','No riesgo',30,'IN'),
						('184643','CASTRO','HUAYHUA','NELSON BERTOL','No riesgo',30,'IN'),
						('193837','PFOCCORI','QUISPE','ALEX HARVEY','No riesgo',30,'IN'),
						('200821','AUCAPURI','CORIMANYA','WILGER FABRICIO','No riesgo',30,'IN'),

						('111651','QUISPE','SOTO','WILLIAM','Riesgo',30,'IN'),
						('141011','SIPAUCAR','CONDORI','MARITZA MARIBEL','Riesgo',30,'IN'),
						('154630','YUCRA','VALDEZ','YEFER YOSELIN','Riesgo',30,'IN'),
						('164244','MOLOCHO','CONDORI','BRAYAN VLADYMIR','Riesgo',30,'IN'),
						('174948','HUAMAN','CHILO','ELVIS','Riesgo',30,'IN'),
						('184204','HUILLCA','QUISPE','JOEL','Riesgo',30,'IN'),
						('124799','NINA','GUARDAPUCLLA','CARLOS ALEX','No riesgo',30,'IN'),
						('150372','HANCCO','CHACO','JOSE MARIA','No riesgo',30,'IN'),
						('160545','NAOLA','PEREYRA','ALEXANDER YERIM','No riesgo',30,'IN'),
						('164236','CARBAJAL','LAURA','KOSMAR HUGO','No riesgo',30,'IN'),
						('171564','FLORES','AQUINO','LUIS ENRIQUE','No riesgo',30,'IN'),
						('182897','CALDERON','GARMENDIA','JOSEPH TIMOTHY','No riesgo',30,'IN'),
						('184648','GALICIA','CENTENO','EDSON RAUL','No riesgo',30,'IN'),
						('194521','MALDONADO','CHALCO','CRISTIAN DANIEL','No riesgo',30,'IN'),
						('200825','MENDOZA','MAYTA','ANDRE MARCELO','No riesgo',30,'IN'),

						('120008','CUETO','SANCHEZ','CARLA PALOMA','Riesgo',31,'IN'),
						('141677','NINAHUANCA','CHOQUE','JUAN CARLOS','Riesgo',31,'IN'),
						('155637','CORRALES','USCA','NESTOR','Riesgo',31,'IN'),
						('170441','VILLAFUERTE','TURPO','ALEX CHRISTOPHER','Riesgo',31,'IN'),
						('182911','GAMARRA','HERRERA','GABRIELA','Riesgo',31,'IN'),
						('184652','PANDO','MUÑOZ','ROSWELL JAIME','Riesgo',31,'IN'),
						('133959','ANCCO','PERALTA','JUAN ABEL','No riesgo',31,'IN'),
						('150411','VALLENAS','CHOQUECOTA','EDU','No riesgo',31,'IN'),
						('160894','RAMOS','CONDORI','DIEGO ARMANDO','No riesgo',31,'IN'),
						('164567','QUISPE','CHAUCCA','MELANY FABIOLA','No riesgo',31,'IN'),
						('171914','MONZON','MONTALVO','ALEXANDER JUNIOR','No riesgo',31,'IN'),
						('182916','LAZO','MENDOZA','JEREMY AXL','No riesgo',31,'IN'),
						('192417','CESPEDES','VILCA','ANGEL LUIS','No riesgo',31,'IN'),
						('194917','FLORES','CASTRO','MARY CARMEN','No riesgo',31,'IN'),
						('204319','CONDORI','LACUTA','LUIS FERNANDO','No riesgo',31,'IN'),



						('103647','QUISPE','ARONI','JESUS ADEL','Riesgo',32,'IN'),
						('140997','TRIVEÑOS','CALLER','DERICK ADOLPHO','Riesgo',32,'IN'),
						('151832','CASTELLANOS','AMANQUI','GEORGE SANTIAGO','Riesgo',32,'IN'),
						('163842','FERNANDEZ','HUILLCA','CARLOS ENRIQUE','Riesgo',32,'IN'),
						('174907','CAMPOS','SEGOVIA','JEFFERSON LENNART','Riesgo',32,'IN'),
						('184201','GUTIERREZ','TAQQUERE','LUIS FERNANDO','Riesgo',32,'IN'),
						('194526','QUISPE','SALAS','JOSE ALEXANDER','Riesgo',32,'IN'),
						('121957','ARANGURE','TORRES','ERNESTO FRANCISCO','No riesgo',32,'IN'),
						('144995','MENDOZA','INOÑAN','VANESSA','No riesgo',32,'IN'),
						('160541','AYME','CONDORI','BRANDON RODRIGO','No riesgo',32,'IN'),
						('163839','CORAZAO','HINOJOSA','REISON DARIO','No riesgo',32,'IN'),
						('171258','ESPEJO','FRANCO','MELISSA BRIGGITTE','No riesgo',32,'IN'),
						('182731','CHIRINOS','VILCA','YERSON JOAB','No riesgo',32,'IN'),
						('184645','CCOTO','MACHACA','EDWIN BRAYAN','No riesgo',32,'IN'),
						('194516','CCAÑIHUA','LAYME','ELIAZAR','No riesgo',32,'IN'),
						('200822','ESTACIO','MEDRANO','AMILCAR','No riesgo',32,'IN'),

						('114136','ALMIRON','GONZALES','JUAN RAISER','Riesgo',33,'IN'),
						('141673','RAMOS','DELGADO','AMIRE','Riesgo',33,'IN'),
						('155191','URQUIZO','CARBAJAL','VICTOR','Riesgo',33,'IN'),
						('170431','CRUZ','CARRION','JOSE LUIS','Riesgo',33,'IN'),
						('182902','CONDE','QUISPE','REINHARD VICENT','Riesgo',33,'IN'),
						('184650','HUARHUA','QUISPE','JUANA YULIANA','Riesgo',33,'IN'),
						('131532','ANTAYHUA','SAPILLADO','DAVIS WASHINGTON','No riesgo',33,'IN'),
						('150408','TACUSI','LAROTA','JHON EDWIN','No riesgo',33,'IN'),
						('160891','CRUZ','BEJAR','WILLY ALDAIR','No riesgo',33,'IN'),
						('164249','TTITO','SAYA','ALEXANDER','No riesgo',33,'IN'),
						('171879','QUISPE','MAMANI','THALIA','No riesgo',33,'IN'),
						('182910','FLORES','ROBLES','KATHERYNE SHARMELLY','No riesgo',33,'IN'),
						('191873','PUMA','HUAMANI','GLINA DE LA FLOR','No riesgo',33,'IN'),
						('194892','SONCCO','LUQUE','MAX ALEX','No riesgo',33,'IN'),
						('201232','HUERTA','MEDINA','VITO JHON','No riesgo',33,'IN'),

						('110071','MUNIVE','SALAS','CIRO','Riesgo',34,'IN'),
						('141005','FLORES','MONTOYA','NILTHON JAIR','Riesgo',34,'IN'),
						('154622','CONDORI','ALCAZAR','JUAN CARLOS','Riesgo',34,'IN'),
						('164239','CONTRERAS','RAMIREZ','CARLOS DANIEL','Riesgo',34,'IN'),
						('174941','CHOQUENAIRA','GARCIA','RONAL FRANKLIN','Riesgo',34,'IN'),
						('184202','HANCCO','LEÓN','ALEXANDER','Riesgo',34,'IN'),
						('194920','HUAMANI','CRIOLLO','JUVENAL','Riesgo',34,'IN'),
						('124211','PUMASUPA','BALLON','DAVIS VLADIMIR','No riesgo',34,'IN'),
						('145004','ESPIRILLA','MACHACA','JOSEPH ODE','No riesgo',34,'IN'),
						('160543','DONGO','ESQUIVEL','DIEGO YOSHIRO','No riesgo',34,'IN'),
						('163845','HUILLCA','HERRERA','VICTOR POOL','No riesgo',34,'IN'),
						('171259','QUISPE','LEON','WIDMAR RAUL','No riesgo',34,'IN'),
						('182765','SUMIRE','HANCCO','IVAN MARIO','No riesgo',34,'IN'),
						('184646','DIAZ','HUAYLUPO','CHRISTIAN ENRIQUE','No riesgo',34,'IN'),
						('194518','HUAMAN','JAIMES','NICANOR','No riesgo',34,'IN'),
						('200823','FERNANDEZ BACA','PILLCO','FABRICIO','No riesgo',34,'IN')

use BD_Sistema_Tutoria
go

--CREAR TABLA USUARIOS
create table Usuarios(
IdUsuarios int identity(1,1) primary key,
Usuario varchar(15) not null,
Contraseña varchar(15) not null,
Acceso varchar(20) not null
)
go

--PROCEDIMIENTO MOSTRAR REGISTROS ==> USUARIOS
create proc spMostrarUsuarios
as
select * from Usuarios
go

--PROCEDIMIENTO INSERTAR, AGREGAR REGISTROS
create proc spInsertarUsuarios
@Usuario varchar(15),
@Contraseña varchar(15),
@Acceso varchar(20)
as
insert into Usuarios values (@Usuario, @Contraseña, @Acceso)
go

--PROCEDIMIENTO EDITAR, MODIFICAR REGISTROS
create proc spEditarUsuarios
@IdUsuarios int,
@Usuario varchar(15),
@Contraseña varchar(15),
@Acceso varchar(20)
as
update Usuarios set Usuario=@Usuario, Contraseña=@Contraseña, Acceso=@Acceso where IdUsuarios=@IdUsuarios
go

--PROCEDIMIENTO ELIMINAR, BORRAR REGISTROS
create proc spEliminarUsuarios
@IdUsuarios int
as
delete Usuarios where IdUsuarios=@IdUsuarios
go

create proc [dbo].[spIniciarSesion]
@Usuario nvarchar(15),
@Contraseña nvarchar(15)
AS 
SELECT u.*
	from Usuarios u
	where u.Usuario = @Usuario and u.Contraseña = @Contraseña
go

INSERT INTO Usuarios VALUES('DIRECTOR', '1234', 'Director de Escuela')
INSERT INTO Usuarios VALUES('DOCENTE', '1234', 'Docente')
INSERT INTO Usuarios VALUES('ESTUDIANTE', '1234', 'Estudiante')