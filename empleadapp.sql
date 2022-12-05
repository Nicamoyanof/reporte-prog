create database empleadapp

use empleadapp

create table roles(
id_rol int identity,
nombre_rol varchar(50)
constraint pk_rol primary key (id_rol)
)

create table usuarios(
id_usuario int identity,
email varchar(256),
contraseña varchar(100),
id_rol int 
constraint pk_user primary key (id_usuario),
constraint fk_rol_user foreign key (id_rol)
						references roles(id_rol)
)

CREATE TABLE cargos(
	id_cargo int identity ,
	nombre varchar(150)
	constraint pk_cargo primary key (id_cargo)
);

create TABLE personas(
	id_persona int identity PRIMARY KEY,
	nombre varchar(150),
	apellido varchar(150),
	cuil varchar(150),
	telefono varchar(150),
	email varchar(250),
	id_cargo int,
	id_usuario int
	CONSTRAINT fk_cargo_persona FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo),
	CONSTRAINT fk_user_persona FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

create table modalidades_trabajos(
id_modalidad int identity primary key,
nombre_modalidad varchar(250)
)

create table categorias_trabajos(
id_categoria int identity primary key,
nombre_categoria varchar(250)
)

CREATE TABLE tipos_pagos(
	id_tipo_pago int identity PRIMARY KEY,
    nombre_pago int
)

create TABLE contratos(
    id_contrato int identity PRIMARY KEY,
    id_empleador int,
    id_emplado int,
	id_modalidad int,
	id_categoria int,
    id_tipo_pago int,
	patagonia bit,
    fecha_ingreso datetime,
    horas_semanales int,
	CONSTRAINT fk_modalidad_contrato FOREIGN KEY (id_modalidad) REFERENCES modalidades_trabajos(id_modalidad),
	CONSTRAINT fk_categoria_contrato FOREIGN KEY (id_categoria) REFERENCES categorias_trabajos(id_categoria),
    CONSTRAINT fk_empleador_contrato FOREIGN KEY (id_empleador) REFERENCES personas(id_persona),
    CONSTRAINT fk_empleado_contrato  FOREIGN KEY (id_emplado) REFERENCES personas(id_persona),
    CONSTRAINT fk_tipo_pago_contrato FOREIGN KEY (id_tipo_pago) REFERENCES tipos_pagos(id_tipo_pago)
);


create table facturas(
	id_factura int identity primary key,
	valor_sueldo float,
	fecha_inicio datetime,
	fecha_pago_completo datetime,
	id_contrato int
	CONSTRAINT fk_contrato_factura FOREIGN KEY (id_contrato) REFERENCES contratos(id_contrato)
);

create table descripciones_pagos(
	id_descripcion int identity primary key,
	 varchar(500)
);

create table detalles_facturas(
	id_detalle_factura int identity primary key,
	id_descripcion int,
	fecha_pago datetime,
	cantidad float,
	id_factura int
	CONSTRAINT fk_dtfact_factura FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
	CONSTRAINT fk_dtfact_desc FOREIGN KEY (id_descripcion) REFERENCES descripciones_pagos(id_descripcion)
);

create proc sp_empleado_contrato
@nombre varchar(150),
@apellido varchar(150),
@cuil varchar(150),
@telefono varchar(150),
@email varchar(250),
@id_cargo int,
@id_empleador int,
@id_modalidad int,
@id_categoria int,
@id_tipo_pago int,
@patagonia bit,
@fecha_ingreso int,
@horas_semanales int
as
	declare @id_persona int
	insert into personas values (@nombre, @apellido,@cuil,@telefono,@email,@id_cargo, null)
	select @id_persona =SCOPE_IDENTITY() from personas

	insert into contratos values (@id_empleador,@id_persona,@id_modalidad,@id_categoria,@id_tipo_pago,@patagonia,@fecha_ingreso,@horas_semanales)

	select  SCOPE_IDENTITY()  from personas


	INSERT INTO contratos  VALUES (6,1013,2,4,1,0 ,'11/11/2022 0:00:00',25)

	select * from contratos

	update contratos
	set id_empleador = 6,
	id_emplado = 1014,
	id_modalidad = 2,
	id_categoria = 4,
	id_tipo_pago = 1,
	patagonia = 0,
	fecha_ingreso = GETDATE(),
	horas_semanales = 26
	where id_contrato = 1


insert into detalles_facturas values (2,getdate(),5.10,1)

select * from contratos

select * from facturas f join contratos c on c.id_contrato = f.id_contrato where c.id_emplado = 1014 and Month(f.fecha_inicio) = 11 and YEAR(f.fecha_inicio) = 2022