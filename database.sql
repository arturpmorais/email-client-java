use BD17175
go

--
-- apaga objetos
--

if OBJECT_ID('Usuario') is not null
	drop table Usuario
go

if OBJECT_ID('Email') is not null
	drop table Email
go

--
-- cria objetos
--

create table Usuario(
	id    int identity primary key,
	nome  varchar(50) not null,
	email varchar(50) not null,
	senha varchar(50) not null,
)

create table Email(
	id        int identity primary key,
	id_dono   int foreign key references Usuario(id),
	email     varchar(50) not null,
	senha     varchar(200) not null,
	porta     int         not null,
	host      varchar(30) not null,
	protocolo varchar(4)  not null
)

--
-- procs
--

--
-- inserts para testes
--

-- usuarios
insert into Usuario values('Artur Morais', 'arturpmrs@gmail.com', 'senha')
insert into Usuario values('Felipe Corerato', 'fcorerato@gmail.com', 'senha')

-- emails
insert into Email   values(1, 'contatestetur000@gmail.com', 'Senha123', 993, 'gmail', 'imap')


select * from Usuario
Select * from Email
