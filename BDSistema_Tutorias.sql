/* **************************************************************************************************
   ***************************** DDL (LENGUAJE DE DEFINICIÓN DE DATOS) ******************************
   ************************************************************************************************** */
USE MASTER
GO

/* ********************************************************************
					    CREACIÓN DE LA BASE DE DATOS
   ******************************************************************** */
IF EXISTS (SELECT * 
				FROM SYSDATABASES
				WHERE NAME = 'BDSistema_Tutoria')
	DROP DATABASE BDSistema_Tutoria
GO
CREATE DATABASE BDSistema_Tutoria
GO

-- Crear tipos de datos para las claves primarias
USE BDSistema_Tutoria
	EXEC SP_ADDTYPE tyCodEscuelaP,		'VARCHAR(4)', 'NOT NULL'
	EXEC SP_ADDTYPE tyCodEstudiante,	'VARCHAR(6)', 'NOT NULL'
	EXEC SP_ADDTYPE tyCodDocente,		'VARCHAR(7)', 'NOT NULL'
	EXEC SP_ADDTYPE tyCodTutoria,		'VARCHAR(3)', 'NOT NULL'
	EXEC SP_ADDTYPE tyCodTipo,			'VARCHAR(10)', 'NOT NULL'
GO 

/* ********************************************************************
					        CREACIÓN DE TABLAS
   ******************************************************************** */
USE BDSistema_Tutoria
GO

/* *************************** TABLA ESCUELA PROFESIONAL *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'TEscuela_Profesional')
	DROP TABLE TEscuela_Profesional
GO
CREATE TABLE TEscuela_Profesional
(
	-- Lista de atributos
	CodEscuelaP tyCodEscuelaP,
	Nombre VARCHAR(40) NOT NULL,

	-- Determinar las claves 
	PRIMARY KEY (CodEscuelaP)
);
GO

/* *************************** TABLA ESTUDIANTE *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'TEstudiante')
	DROP TABLE TEstudiante
GO
CREATE TABLE TEstudiante
(
	-- Lista de atributos
	CodEstudiante tyCodEstudiante,
	APaterno VARCHAR(15) NOT NULL,
	AMaterno VARCHAR(15) NOT NULL,
	Nombre VARCHAR(10) NOT NULL,
	CodEscuelaP tyCodEscuelaP,
	Estado VARCHAR(40),

	-- Determinar las claves 
	PRIMARY KEY (CodEstudiante),
	FOREIGN KEY (CodEscuelaP) REFERENCES TEscuela_Profesional
);
GO

/* *************************** TABLA DOCENTE *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'TDocente')
	DROP TABLE TDocente
GO
CREATE TABLE TDocente
(
	-- Lista de atributos
	CodDocente tyCodDocente,
	APaterno VARCHAR(15) NOT NULL,
	AMaterno VARCHAR(15) NOT NULL,
	Nombre VARCHAR(10) NOT NULL,
	CodEscuelaP tyCodEscuelaP,

	-- Determinar las claves 
	PRIMARY KEY (CodDocente),
	FOREIGN KEY (CodEscuelaP) REFERENCES TEscuela_Profesional
);
GO

/* *************************** TABLA TUTORÍA *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'TTutoria')
	DROP TABLE TTutoria
GO
CREATE TABLE TTutoria
(
	-- Lista de atributos
	CodTutoria tyCodTutoria,
	CodEstudiante tyCodEstudiante,
	CodDocente tyCodDocente,

	-- Determinar las claves 
	PRIMARY KEY (CodTutoria),
	FOREIGN KEY (CodEstudiante) REFERENCES TEstudiante,
	FOREIGN KEY (CodDocente) REFERENCES TDocente
);
GO

/* *************************** TABLA DOCENTE CONTRATADO *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'TDocente_Contratado')
	DROP TABLE TDocente_Contratado
GO
CREATE TABLE TDocente_Contratado
(
	-- Lista de atributos
	CodDocente tyCodDocente,
	Categoria VARCHAR(2) NOT NULL,
	Horas INT NOT NULL,
	Clasificacion VARCHAR(5) NOT NULL,

	-- Determinar las claves 
	PRIMARY KEY (CodDocente),
	FOREIGN KEY (CodDocente) REFERENCES TDocente
);
GO

/* *************************** TABLA DOCENTE NOMBRADO TIPO *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'TDocente_Nombrado_Tipo')
	DROP TABLE TDocente_Nombrado_Tipo
GO
CREATE TABLE TDocente_Nombrado_Tipo
(
	-- Lista de atributos
	CodTipo tyCodTipo,
	Caracteristica VARCHAR(10) NOT NULL,

	-- Determinar las claves 
	PRIMARY KEY (CodTipo)
);
GO

/* *************************** TABLA DOCENTE NOMBRADO *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'TDocente_Nombrado')
	DROP TABLE TDocente_Nombrado
GO
CREATE TABLE TDocente_Nombrado
(
	-- Lista de atributos
	CodDocente tyCodDocente,
	CodTipo tyCodTipo,

	-- Determinar las claves 
	PRIMARY KEY (CodDocente),
	FOREIGN KEY (CodDocente) REFERENCES TDocente,
	FOREIGN KEY (CodTipo) REFERENCES TDocente_Nombrado_Tipo
);
GO

/* *************************** TABLA HISTORIAL *************************** */
IF EXISTS (SELECT * 
				FROM SYSOBJECTS
				WHERE NAME = 'Historial')
	DROP TABLE Historial
GO
CREATE TABLE Historial
(
	-- Lista de atributos
	IdHistorial INT,
	Fecha DATETIME,
	Tabla VARCHAR(30),
	Operacion VARCHAR(15),
	IdRegistroAfectado VARCHAR(20),
	ValorAnterior VARCHAR(100),
	ValorNuevo VARCHAR(100)

	-- Definir la clave primaria
	PRIMARY KEY(IdHistorial)	
)
GO

/* **************************************************************************************************
   **************************** DML (LENGUAJE DE MANIPULACIÓN DE DATOS) *****************************
   ************************************************************************************************** */
USE BDSistema_Tutoria
GO

/* **************************************************************************************************
   ********************************** TRIGGERS DE LA BASE DE DATOS **********************************
   ************************************************************************************************** */
USE BDSistema_Tutoria
GO

-- Crear un procedimiento para determinar el IdHistorial
CREATE PROCEDURE spuObtenerIdHistorial
				 @IdHistorial INT OUTPUT
AS
BEGIN
	-- Inicializar la identificación en 0
	SET @IdHistorial = 0;

	-- Determinar el IdHistorial
	SELECT @IdHistorial = COUNT(*) + 1
		FROM Historial
END;
GO

/* *************************** TRIGGERS PARA LA TABLA ESCUELA PROFESIONAL *************************** */

-- Crear un disparador para guardar el registro de inserción de la tabla TEscuela_Profesional en la tabla Historial
CREATE TRIGGER trEscuela_ProfesionalInsercion
	ON TEscuela_Profesional
	FOR INSERT
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodEscuelaP VARCHAR(4),
		Nombre VARCHAR(40),
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #INSERTED;

	-- Recorrer las tuplas de la tabla #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #INSERTED
		DECLARE @CodEscuelaP VARCHAR(4);
		DECLARE @Nombre VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEscuelaP = CodEscuelaP,
			   @Nombre = Nombre
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #INSERTED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEscuela_Profesional','INSERT',@CodEscuelaP,NULL, 
					  @Nombre);
		
		-- Eliminar la tupla insertada de la tabla #INSERTED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #INSERTED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de eliminación de la tabla TEscuela_Profesional en la tabla Historial
CREATE TRIGGER trEscuela_ProfesionalEliminacion
	ON TEscuela_Profesional
	FOR DELETE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodEscuelaP VARCHAR(4),
		Nombre VARCHAR(40),
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Determinar el número de tuplas de la tabla #DELETED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED
		DECLARE @CodEscuelaP VARCHAR(4);
		DECLARE @Nombre VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEscuelaP = CodEscuelaP,
			   @Nombre = Nombre
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #DELETED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEscuela_Profesional','DELETE',@CodEscuelaP, 
					  @Nombre,NULL);
		
		-- Eliminar la tupla insertada de la tabla #DELETED
		DELETE TOP (1) FROM #DELETED

		-- Actualizar el número de las tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de actualización de la tabla TEscuela_Profesional en la tabla Historial
CREATE TRIGGER trEscuela_ProfesionalActualizacion
	ON TEscuela_Profesional
	FOR UPDATE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodEscuelaP VARCHAR(4),
		Nombre VARCHAR(40),
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodEscuelaP VARCHAR(4),
		Nombre VARCHAR(40),
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #DELETED = #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED = #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED (ANTES)
		DECLARE @CodEscuelaPAntes VARCHAR(4);
		DECLARE @NombreAntes VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEscuelaPAntes = CodEscuelaP,
			   @NombreAntes = Nombre
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Declarar variables donde estarán los atributos de la tabla #INSERTED (DESPUÉS)
		DECLARE @CodEscuelaPDespues VARCHAR(4);
		DECLARE @NombreDespues VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEscuelaPDespues = CodEscuelaP,
			   @NombreDespues = Nombre
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Declarar e inicializar el IdRegistroAfectado
		DECLARE @IdRegistroAfectado VARCHAR(20);
		SET @IdRegistroAfectado = NULL

		-- Declarar e inicializar el ValorAnterior
		DECLARE @ValorAnterior VARCHAR(100);
		SET @ValorAnterior = NULL;

		-- Declarar e inicializar el ValorNuevo
		DECLARE @ValorNuevo VARCHAR(100);
		SET @ValorNuevo = NULL;

		-- Verificar si el cambio fue en CodEscuelaP
		IF @CodEscuelaPAntes != @CodEscuelaPDespues
		BEGIN
			SET @ValorAnterior = @CodEscuelaPAntes;
			SET @ValorNuevo = @CodEscuelaPDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEscuela_Profesional','UPDATE',@CodEscuelaPAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en Nombre
		IF @NombreAntes != @NombreDespues
		BEGIN
			SET @ValorAnterior = @NombreAntes;
			SET @ValorNuevo = @NombreDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEscuela_Profesional','UPDATE',@CodEscuelaPAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Eliminar las tuplas ya evaluadas de las tablas #DELETED y #INSERTED 
		DELETE TOP (1) FROM #DELETED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO

/* *************************** TRIGGERS PARA LA TABLA ESTUDIANTE *************************** */

-- Crear un disparador para guardar el registro de inserción de la tabla TEstudiante en la tabla Historial
CREATE TRIGGER trEstudianteInsercion
	ON TEstudiante
	FOR INSERT
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodEstudiante VARCHAR(6),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4),
		Estado VARCHAR(40)
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #INSERTED;

	-- Recorrer las tuplas de la tabla #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #INSERTED
		DECLARE @CodEstudiante VARCHAR(6);
		DECLARE @APaterno VARCHAR(15);
		DECLARE @AMaterno VARCHAR(15);
		DECLARE @Nombre VARCHAR(10);
		DECLARE @CodEscuelaP VARCHAR(4);
		DECLARE @Estado VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEstudiante = CodEstudiante,
			   @APaterno = APaterno,
			   @AMaterno = AMaterno,
			   @Nombre = Nombre,
			   @CodEscuelaP = CodEscuelaP,
			   @Estado = Estado
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #INSERTED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','INSERT',@CodEstudiante,NULL, 
					  @APaterno + ' ; ' + @AMaterno + ' ; ' + @Nombre + ' ; ' + 
					  @CodEscuelaP + ' ; ' + @Estado);
		
		-- Eliminar la tupla insertada de la tabla #INSERTED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #INSERTED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de eliminación de la tabla TEstudiante en la tabla Historial
CREATE TRIGGER trEstudianteEliminacion
	ON TEstudiante
	FOR DELETE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodEstudiante VARCHAR(6),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4),
		Estado VARCHAR(40)
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Determinar el número de tuplas de la tabla #DELETED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED
		DECLARE @CodEstudiante VARCHAR(6);
		DECLARE @APaterno VARCHAR(15);
		DECLARE @AMaterno VARCHAR(15);
		DECLARE @Nombre VARCHAR(10);
		DECLARE @CodEscuelaP VARCHAR(4);
		DECLARE @Estado VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEstudiante = CodEstudiante,
			   @APaterno = APaterno,
			   @AMaterno = AMaterno,
			   @Nombre = Nombre,
			   @CodEscuelaP = CodEscuelaP,
			   @Estado = Estado
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #DELETED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','DELETE',@CodEstudiante, 
					  @APaterno + ' ; ' + @AMaterno + ' ; ' + @Nombre + ' ; ' + 
					  @CodEscuelaP + ' ; ' + @Estado,NULL);
		
		-- Eliminar la tupla insertada de la tabla #DELETED
		DELETE TOP (1) FROM #DELETED

		-- Actualizar el número de las tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de actualización de la tabla TEstudiante en la tabla Historial
CREATE TRIGGER trEstudianteActualizacion
	ON TEstudiante
	FOR UPDATE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodEstudiante VARCHAR(6),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4),
		Estado VARCHAR(40)
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodEstudiante VARCHAR(6),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4),
		Estado VARCHAR(40)
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #DELETED = #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED = #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED (ANTES)
		DECLARE @CodEstudianteAntes VARCHAR(6);
		DECLARE @APaternoAntes VARCHAR(15);
		DECLARE @AMaternoAntes VARCHAR(15);
		DECLARE @NombreAntes VARCHAR(10);
		DECLARE @CodEscuelaPAntes VARCHAR(4);
		DECLARE @EstadoAntes VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEstudianteAntes = CodEstudiante,
			   @APaternoAntes = APaterno,
			   @AMaternoAntes = AMaterno,
			   @NombreAntes = Nombre,
			   @CodEscuelaPAntes = CodEscuelaP,
			   @EstadoAntes = Estado
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Declarar variables donde estarán los atributos de la tabla #INSERTED (DESPUÉS)
		DECLARE @CodEstudianteDespues VARCHAR(6);
		DECLARE @APaternoDespues VARCHAR(15);
		DECLARE @AMaternoDespues VARCHAR(15);
		DECLARE @NombreDespues VARCHAR(10);
		DECLARE @CodEscuelaPDespues VARCHAR(4);
		DECLARE @EstadoDespues VARCHAR(40);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodEstudianteDespues = CodEstudiante,
			   @APaternoDespues = APaterno,
			   @AMaternoDespues = AMaterno,
			   @NombreDespues = Nombre,
			   @CodEscuelaPDespues = CodEscuelaP,
			   @EstadoDespues = Estado
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Declarar e inicializar el IdRegistroAfectado
		DECLARE @IdRegistroAfectado VARCHAR(20);
		SET @IdRegistroAfectado = NULL

		-- Declarar e inicializar el ValorAnterior
		DECLARE @ValorAnterior VARCHAR(100);
		SET @ValorAnterior = NULL;

		-- Declarar e inicializar el ValorNuevo
		DECLARE @ValorNuevo VARCHAR(100);
		SET @ValorNuevo = NULL;

		-- Verificar si el cambio fue en CodEstudiante
		IF @CodEstudianteAntes != @CodEstudianteDespues
		BEGIN
			SET @ValorAnterior = @CodEstudianteAntes;
			SET @ValorNuevo = @CodEstudianteDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','UPDATE',@CodEstudianteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en APaterno
		IF @APaternoAntes != @APaternoDespues
		BEGIN
			SET @ValorAnterior = @APaternoAntes;
			SET @ValorNuevo = @APaternoDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','UPDATE',@CodEstudianteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en AMaterno
		IF @AMaternoAntes != @AMaternoDespues
		BEGIN
			SET @ValorAnterior = @AMaternoAntes;
			SET @ValorNuevo = @AMaternoDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','UPDATE',@CodEstudianteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en Nombre
		IF @NombreAntes != @NombreDespues
		BEGIN
			SET @ValorAnterior = @NombreAntes;
			SET @ValorNuevo = @NombreDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','UPDATE',@CodEstudianteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en CodEscuelaP
		IF @CodEscuelaPAntes != @CodEscuelaPDespues
		BEGIN
			SET @ValorAnterior = @CodEscuelaPAntes;
			SET @ValorNuevo = @CodEscuelaPDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','UPDATE',@CodEstudianteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en Estado
		IF @EstadoAntes != @EstadoDespues
		BEGIN
			SET @ValorAnterior = @EstadoAntes;
			SET @ValorNuevo = @EstadoDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TEstudiante','UPDATE',@CodEstudianteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Eliminar las tuplas ya evaluadas de las tablas #DELETED y #INSERTED 
		DELETE TOP (1) FROM #DELETED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO

/* *************************** TRIGGERS PARA LA TABLA DOCENTE *************************** */

-- Crear un disparador para guardar el registro de inserción de la tabla TDocente en la tabla Historial
CREATE TRIGGER trDocenteInsercion
	ON TDocente
	FOR INSERT
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodDocente VARCHAR(7),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4)
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #INSERTED;

	-- Recorrer las tuplas de la tabla #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #INSERTED
		DECLARE @CodDocente VARCHAR(7);
		DECLARE @APaterno VARCHAR(15);
		DECLARE @AMaterno VARCHAR(15);
		DECLARE @Nombre VARCHAR(10);
		DECLARE @CodEscuelaP VARCHAR(4);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodDocente = CodDocente,
			   @APaterno = APaterno,
			   @AMaterno = AMaterno,
			   @Nombre = Nombre,
			   @CodEscuelaP = CodEscuelaP
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #INSERTED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TDocente','INSERT',@CodDocente,NULL, 
					  @APaterno + ' ; ' + @AMaterno + ' ; ' + @Nombre + ' ; ' + 
					  @CodEscuelaP);
		
		-- Eliminar la tupla insertada de la tabla #INSERTED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #INSERTED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de eliminación de la tabla TDocente en la tabla Historial
CREATE TRIGGER trDocenteEliminacion
	ON TDocente
	FOR DELETE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodDocente VARCHAR(7),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4)
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Determinar el número de tuplas de la tabla #DELETED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED
		DECLARE @CodDocente VARCHAR(7);
		DECLARE @APaterno VARCHAR(15);
		DECLARE @AMaterno VARCHAR(15);
		DECLARE @Nombre VARCHAR(10);
		DECLARE @CodEscuelaP VARCHAR(4);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodDocente = CodDocente,
			   @APaterno = APaterno,
			   @AMaterno = AMaterno,
			   @Nombre = Nombre,
			   @CodEscuelaP = CodEscuelaP
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #DELETED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TDocente','DELETE',@CodDocente, 
					  @APaterno + ' ; ' + @AMaterno + ' ; ' + @Nombre + ' ; ' + 
					  @CodEscuelaP,NULL);
		
		-- Eliminar la tupla insertada de la tabla #DELETED
		DELETE TOP (1) FROM #DELETED

		-- Actualizar el número de las tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de actualización de la tabla TDocente en la tabla Historial
CREATE TRIGGER trDocenteActualizacion
	ON TDocente
	FOR UPDATE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodDocente VARCHAR(7),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4)
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodDocente VARCHAR(7),
		APaterno VARCHAR(15),
		AMaterno VARCHAR(15),
		Nombre VARCHAR(10),
		CodEscuelaP VARCHAR(4)
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #DELETED = #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED = #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED (ANTES)
		DECLARE @CodDocenteAntes VARCHAR(7);
		DECLARE @APaternoAntes VARCHAR(15);
		DECLARE @AMaternoAntes VARCHAR(15);
		DECLARE @NombreAntes VARCHAR(10);
		DECLARE @CodEscuelaPAntes VARCHAR(4);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodDocenteAntes = CodDocente,
			   @APaternoAntes = APaterno,
			   @AMaternoAntes = AMaterno,
			   @NombreAntes = Nombre,
			   @CodEscuelaPAntes = CodEscuelaP
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Declarar variables donde estarán los atributos de la tabla #INSERTED (DESPUÉS)
		DECLARE @CodDocenteDespues VARCHAR(7);
		DECLARE @APaternoDespues VARCHAR(15);
		DECLARE @AMaternoDespues VARCHAR(15);
		DECLARE @NombreDespues VARCHAR(10);
		DECLARE @CodEscuelaPDespues VARCHAR(4);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodDocenteDespues = CodDocente,
			   @APaternoDespues = APaterno,
			   @AMaternoDespues = AMaterno,
			   @NombreDespues = Nombre,
			   @CodEscuelaPDespues = CodEscuelaP
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Declarar e inicializar el IdRegistroAfectado
		DECLARE @IdRegistroAfectado VARCHAR(20);
		SET @IdRegistroAfectado = NULL

		-- Declarar e inicializar el ValorAnterior
		DECLARE @ValorAnterior VARCHAR(100);
		SET @ValorAnterior = NULL;

		-- Declarar e inicializar el ValorNuevo
		DECLARE @ValorNuevo VARCHAR(100);
		SET @ValorNuevo = NULL;

		-- Verificar si el cambio fue en CodDocente
		IF @CodDocenteAntes != @CodDocenteDespues
		BEGIN
			SET @ValorAnterior = @CodDocenteAntes;
			SET @ValorNuevo = @CodDocenteDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TDocente','UPDATE',@CodDocenteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en APaterno
		IF @APaternoAntes != @APaternoDespues
		BEGIN
			SET @ValorAnterior = @APaternoAntes;
			SET @ValorNuevo = @APaternoDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TDocente','UPDATE',@CodDocenteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en AMaterno
		IF @AMaternoAntes != @AMaternoDespues
		BEGIN
			SET @ValorAnterior = @AMaternoAntes;
			SET @ValorNuevo = @AMaternoDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TDocente','UPDATE',@CodDocenteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en Nombre
		IF @NombreAntes != @NombreDespues
		BEGIN
			SET @ValorAnterior = @NombreAntes;
			SET @ValorNuevo = @NombreDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TDocente','UPDATE',@CodDocenteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en CodEscuelaP
		IF @CodEscuelaPAntes != @CodEscuelaPDespues
		BEGIN
			SET @ValorAnterior = @CodEscuelaPAntes;
			SET @ValorNuevo = @CodEscuelaPDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TDocente','UPDATE',@CodDocenteAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Eliminar las tuplas ya evaluadas de las tablas #DELETED y #INSERTED 
		DELETE TOP (1) FROM #DELETED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO

/* *************************** TRIGGERS PARA LA TABLA TUTORIA *************************** */

-- Crear un disparador para guardar el registro de inserción de la tabla TTutoria en la tabla Historial
CREATE TRIGGER trTutoriaInsercion
	ON TTutoria
	FOR INSERT
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodTutoria VARCHAR(3),
		CodEstudiante VARCHAR(6),
		CodDocente VARCHAR(7)
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #INSERTED;

	-- Recorrer las tuplas de la tabla #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #INSERTED
		DECLARE @CodTutoria VARCHAR(3);
		DECLARE @CodEstudiante VARCHAR(6);
		DECLARE @CodDocente VARCHAR(7);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodTutoria = CodTutoria,
			   @CodEstudiante = CodEstudiante,
			   @CodDocente = CodDocente
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #INSERTED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TTutoria','INSERT',@CodTutoria,NULL, 
					  @CodEstudiante + ' ; ' + @CodDocente);
		
		-- Eliminar la tupla insertada de la tabla #INSERTED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #INSERTED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de eliminación de la tabla TTutoriae en la tabla Historial
CREATE TRIGGER trTutoriaEliminacion
	ON TTutoria
	FOR DELETE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodTutoria VARCHAR(3),
		CodEstudiante VARCHAR(6),
		CodDocente VARCHAR(7)
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Determinar el número de tuplas de la tabla #DELETED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED
		DECLARE @CodTutoria VARCHAR(3);
		DECLARE @CodEstudiante VARCHAR(6);
		DECLARE @CodDocente VARCHAR(7);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodTutoria = CodTutoria,
			   @CodEstudiante = CodEstudiante,
			   @CodDocente = CodDocente
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Insertar a la tabla Historial, la tupla insertada de la tabla #DELETED
		INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TTutoria','DELETE',@CodTutoria, 
					  @CodEstudiante + ' ; ' + @CodDocente,NULL);
		
		-- Eliminar la tupla insertada de la tabla #DELETED
		DELETE TOP (1) FROM #DELETED

		-- Actualizar el número de las tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO

-- Crear un disparador para guardar el registro de actualización de la tabla TTutoria en la tabla Historial
CREATE TRIGGER trTutoriaActualizacion
	ON TTutoria
	FOR UPDATE
AS
BEGIN
	-- Crear una tabla temporal para copiar la tabla DELETED
	CREATE TABLE #DELETED
	(
		CodTutoria VARCHAR(3),
		CodEstudiante VARCHAR(6),
		CodDocente VARCHAR(7)
	);

	-- Copiar la tabla DELETED en la tabla temporal #DELETED
	INSERT INTO #DELETED
		SELECT * 
			FROM DELETED

	-- Crear una tabla temporal para copiar la tabla INSERTED
	CREATE TABLE #INSERTED
	(
		CodTutoria VARCHAR(3),
		CodEstudiante VARCHAR(6),
		CodDocente VARCHAR(7)
	);

	-- Copiar la tabla INSERTED en la tabla temporal #INSERTED
	INSERT INTO #INSERTED
		SELECT * 
			FROM INSERTED

	-- Determinar el número de tuplas de la tabla #DELETED = #INSERTED
	DECLARE @NroTuplas INT;
	SELECT @NroTuplas = COUNT(*) FROM #DELETED;

	-- Recorrer las tuplas de la tabla #DELETED = #INSERTED
	WHILE @NroTuplas > 0
	BEGIN
		-- Declarar variables donde estarán los atributos de la tabla #DELETED (ANTES)
		DECLARE @CodTutoriaAntes VARCHAR(3);
		DECLARE @CodEstudianteAntes VARCHAR(6);
		DECLARE @CodDocenteAntes VARCHAR(7);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodTutoriaAntes = CodTutoria,
			   @CodEstudianteAntes = CodEstudiante,
			   @CodDocenteAntes = CodDocente
			FROM (SELECT TOP(1) * FROM #DELETED) AS Eliminado

		-- Declarar variables donde estarán los atributos de la tabla #INSERTED (DESPUÉS)
		DECLARE @CodTutoriaDespues VARCHAR(3);
		DECLARE @CodEstudianteDespues VARCHAR(6);
		DECLARE @CodDocenteDespues VARCHAR(7);

		-- Recuperar los datos de una tupla en las variables declaradas
		SELECT @CodTutoriaDespues = CodTutoria,
			   @CodEstudianteDespues = CodEstudiante,
			   @CodDocenteDespues = CodDocente
			FROM (SELECT TOP(1) * FROM #INSERTED) AS Insertado

		-- Determinar el IdHistorial
		DECLARE @IdHistorial INT;
		EXEC spuObtenerIdHistorial @IdHistorial OUTPUT;

		-- Declarar e inicializar el IdRegistroAfectado
		DECLARE @IdRegistroAfectado VARCHAR(20);
		SET @IdRegistroAfectado = NULL

		-- Declarar e inicializar el ValorAnterior
		DECLARE @ValorAnterior VARCHAR(100);
		SET @ValorAnterior = NULL;

		-- Declarar e inicializar el ValorNuevo
		DECLARE @ValorNuevo VARCHAR(100);
		SET @ValorNuevo = NULL;

		-- Verificar si el cambio fue en CodTutoria
		IF @CodTutoriaAntes != @CodTutoriaDespues
		BEGIN
			SET @ValorAnterior = @CodTutoriaAntes;
			SET @ValorNuevo = @CodTutoriaDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TTutoria','UPDATE',@CodTutoriaAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en CodEstudiante
		IF @CodEstudianteAntes != @CodEstudianteDespues
		BEGIN
			SET @ValorAnterior = @CodEstudianteAntes;
			SET @ValorNuevo = @CodEstudianteDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TTutoria','UPDATE',@CodTutoriaAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Verificar si el cambio fue en CodDocente
		IF @CodDocenteAntes != @CodDocenteDespues
		BEGIN
			SET @ValorAnterior = @CodDocenteAntes;
			SET @ValorNuevo = @CodDocenteDespues;

			-- Insertar a la tabla Historial, la tupla con el cambio realizado
			INSERT INTO Historial
			   VALUES(@IdHistorial,GETDATE(),'TTutoria','UPDATE',@CodTutoriaAntes,
			          @ValorAnterior,@ValorNuevo);

			-- Incrementar el IdHistorial en 1
			SET @IdHistorial = @IdHistorial + 1;
		END;

		-- Eliminar las tuplas ya evaluadas de las tablas #DELETED y #INSERTED 
		DELETE TOP (1) FROM #DELETED
		DELETE TOP (1) FROM #INSERTED

		-- Actualizar el número de tuplas
		SELECT @NroTuplas = COUNT(*) FROM #DELETED;
	END;
END;
GO