--usuario--
--id (pk)
--email
--senha

create table Usuario(
	id    int identity primary key,
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
	protocolo varchar(4)  not null
)
