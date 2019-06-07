--usuario--
--id (pk)
--email
--senha

create table Usuario(
	id    int identity primary key,
	nome  varchar(50) not null,
	email varchar(50) not null,
	senha varchar(50) not null,
)



--emails--
--id (pk)
--idDono (fk para usuario)
--email
--senha
--porta
--protocolo

create table Email(
	id        int identity primary key,
	id_dono   int foreign key references Usuario(id),
	email     varchar(50) not null,
	senha     varchar(50) not null,
	porta     int         not null,
	host      varchar(30) not null,
	protocolo varchar(4)  not null
)

--insert para testes--
insert into Usuario values('Artur Morais', 'arturpmrs@gmail.com', 'senha')
insert into Usuario values('Felipe Corerato', 'fcorerato@gmail.com', 'senha')
