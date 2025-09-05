CREATE DATABASE AviSafe;
-- DROP DTABASE AviSafe;

USE AviSafe;

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dtLeitura DATETIME DEFAULT current_timestamp,
leituraTemp DECIMAL (5,2),
leituraUmi INT 
);

CREATE TABLE Usuario  (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR(50) NOT NULL,
email VARCHAR(80) UNIQUE NOT NULL,
telefone VARCHAR(15),
cnpj CHAR (14) NOT NULL UNIQUE,
statusUsuario VARCHAR(30),
CONSTRAINT chkStatus 
	CHECK (statusUsuario IN ('ativo', 'desativado'))
);




INSERT INTO Usuario (nomeEmpresa, email, telefone, cnpj, statusUsuario) VALUES
('Secgalinhas', 'secgalinhas@gmail.com', '5511982348743','11103662000103', 'ativo'),
('ChickenCO', 'chickenco@gmail.com', '5511903152624', '34876905000141', 'ativo'),
('Granja Viana', 'granjaviana@gmail.com', '5511903987500', '21664309000156', 'ativo'),
('Granja Faria', 'granjafaria@gmail.com', '5555901376601', '98863274000109', 'ativo'),
('Granja Limas', 'granjalima@gmail.com', '5551925467439', '78619119000134', 'desativado');



SELECT * FROM Usuario;

SELECT nomeEmpresa, cnpj FROM Usuario;

UPDATE Usuario SET email = 'granjarespfaria@gmail.com'
      WHERE idUsuario = 4;

ALTER TABLE Usuario RENAME COLUMN email TO emailResp;

DESCRIBE Usuario;

ALTER TABLE Usuario MODIFY COLUMN emailResp VARCHAR (50);

ALTER TABLE Usuario ADD COLUMN sigla CHAR(2);

 UPDATE Usuario SET sigla = 'sp'
      WHERE idUsuario IN (1, 2, 3);
    
SHOW TABLES;

ALTER TABLE Usuario DROP COLUMN sigla;

SELECT CONCAT ('A empresa ' , nomeEmpresa, ' com o CNPJ ', cnpj, ', está ' , statusUsuario, ' em nosso sistema') FROM Usuario;

SELECT * ,
      CASE 
	 WHEN statusUsuario = 'desativado' THEN 'Usuário sem acesso ao sistema'
    END AS 'Status do Usuario'
    FROM Usuario;


SELECT * FROM Usuario 
where nomeEmpresa like 'C%';





CREATE TABLE Galpoes(
idGalpao INT PRIMARY KEY AUTO_INCREMENT,
nomeGalpao VARCHAR(30),
qtdSensores INT,
tamanho FLOAT,
responsavel VARCHAR(50),
statusGalpao VARCHAR(30),
CONSTRAINT chkStatusGalpao
	CHECK (statusGalpao IN ('ativo', 'desativado'))
);

INSERT INTO Galpoes (nomeGalpao, qtdSensores, tamanho, responsavel, statusGalpao) VALUES 
      ('Galpão Leste', 5, 350.5, 'Maria Santos', 'ativo'),
      ('Galpão Oeste', 3, 280.2, 'Gabriela Oliveira', 'ativo'),
      ('Galpão Norte', 6, 420.8, 'João Pereira', 'desativado'),
      ('Galpão Sul', 4, 310.3, 'Ana Silva', 'ativo'),
      ('Galpão Central', 7, 500.0, 'Fernanda Santos', 'ativo');

SELECT * FROM Galpoes;

SELECT nomeGalpao, statusGalpao FROM Galpoes; 

SELECT nomeGalpao, responsavel, statusGalpao FROM Galpoes
      WHERE statusGalpao = 'ativo';
    
INSERT INTO Galpoes VALUES 
      (DEFAULT, 'Galpão Novo Horizonte', 8, 560.8, 'Juliana Ribeiro', 'desativado');

DELETE FROM Galpoes 
      WHERE idGalpao = 4;

UPDATE Galpoes SET responsavel = 'Matheus Silva'
      WHERE idGalpao = 6;
    
SELECT CONCAT(nomeGalpao, ' ', qtdSensores) AS 'Quantidade de Sensores no Galpão'
      FROM Galpoes;
    
SELECT nomeGalpao, qtdSensores, responsavel,
      CASE 
    WHEN statusGalpao = 'ativo' THEN 'Galpão em Funcionamento'
    ELSE 'Galpão Desativado'
    END AS 'Status'
    FROM Galpoes;
    
SELECT nomeGalpao, qtdSensores, responsavel FROM Galpoes 
      WHERE responsavel like 'J%';

CREATE TABLE Plano (
idPlano INT PRIMARY KEY AUTO_INCREMENT,
statusPlano VARCHAR(15),
CONSTRAINT chkStatusPlano
	CHECK (statusPlano IN ('pago', 'pendente', 'atrasado')),
    
tipoPlano VARCHAR(15),
CONSTRAINT chkTipoPlano
	CHECK (tipoPlano IN ('mensal', 'anual')),
    
dtVencimento DATE,
valorPlano DECIMAL (7,2)
);




CREATE TABLE Pagamento (
idPagamento INT PRIMARY KEY AUTO_INCREMENT,
formaPagamento VARCHAR(30) NOT NULL,
CONSTRAINT chkFormaPagamento
	CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
dtPagamento DATETIME
);





