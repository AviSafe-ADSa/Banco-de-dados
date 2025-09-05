-- entregavel planilhas sql individual
-- nome: Jorge Luiz Cardoso de Siqueira
-- data: '02/09/2025'

create database EntregavelPI;
use EntregavelPI;

create table Plano(
	id int primary key auto_increment,
    usuario varchar(30) ,
    tipoPlano varchar (10) , -- só pode ser semestral e anual
	dataInicio date ,
    dataFim date,-- nao pode ser menor que a data de inicio
    
    constraint chkTipoPlano check(tipoPlano in('semestral','anual')),
	constraint chkDataFim check(dataFim>=dataInicio)		
	);
    
drop table Plano;

-- criar tabela dos dados captados pelo sensor
create table DadosSensor(
	idDado int primary key auto_increment,
    temperatura float(4,2) not null,
    umidade float(4,2) not null,
    data date,
    hora time
    );
    
desc DadosSensor;

-- selecionar temperatura e umidade da noite
select * from DadosSensor
	where hora >='18:00:00';
-- selecionar temperatura e umidade da madrugada
select * from DadosSensor
	where hora >'01:00:00' and hora<'6:00:00';
    
-- selecionar temperatura e umidade da manha
select * from DadosSensor
	where hora >= '6:00:00' and hora<'12:00:00';
    
-- selecionar a temperatura e umidade da tarde
select * from DadosSensor
	where hora>'12:00:01' and hora<'18:00:00';
    
-- selecionar os momentos que a temperatura passou do recomendado
select * from DadosSensor	
	where temperatura>20.00;
    
    
-- criar tabela do cadastro dos usuarios]
create table cadastro(
	idUsuario int primary key auto_increment,
    nome varchar(30),
    email varchar(40),
    cpf varchar (11),
    telefone varchar(10));