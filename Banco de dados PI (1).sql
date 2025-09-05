-- GRUPO 7 (Avi Safe)

-- GIOVANNA ALVES PINA 01252076
-- GIOVANA QUEROBINO BRANQUINHO 01252073
-- GIOVANNA DE OLIVEIRA 01252004
-- GUSTAVO ALVES MOTA 01252071
-- JORGE LUIZ CARDOSO DE SIQUEIRA 01252082
-- GABRIEL FONTES DE SOUSA 01252024
-- IGOR ALEXSANDRO FELIX CARDOSO 01252072






CREATE DATABASE AviSafe;
-- DROP DTABASE AviSafe;

USE AviSafe;

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dtLeitura DATETIME DEFAULT current_timestamp,
leituraTemp DECIMAL (5,2),
leituraUmi INT 
);

INSERT INTO Sensor (leituraTemp, leituraUmi) VALUES
(99.22, 40),
(59.20, 38),
(62.52, 44),
(93.25, 47),
(32.62, 48);

SELECT * FROM sensor;

SELECT dtLeitura AS 'DataDaLeitura',
	leituraTemp AS 'LeituraDaTemperaturaºC',
	leituraUmi AS 'LeituraDaUmidade%'
    FROM Sensor;
    
SELECT concat ('Em ', dtLeitura, ' foi coletada a temperatura ', leituraTemp,'ºC e o 
nível de umidade em ', leituraUmi,'%' ) AS 'Dados do Arduino' FROM Sensor;

INSERT INTO Sensor VALUES
(DEFAULT, DEFAULT,24.00, 50),
(DEFAULT, DEFAULT,20.30, 60),
(DEFAULT, DEFAULT,25.6, 55),
(DEFAULT, DEFAULT,19.2, 62);

SELECT * FROM Sensor;

UPDATE Sensor SET leituraUmi = 56
WHERE idSensor = 6;

DELETE FROM Sensor WHERE idSensor = 7;

ALTER TABLE Sensor ADD COLUMN diadasemana VARCHAR (25);

DESC Sensor;

ALTER TABLE Sensor MODIFY COLUMN diadasemana VARCHAR (30);

DESC Sensor;

ALTER TABLE Sensor RENAME COLUMN diadasemana TO DiaDaSemana;

SELECT * FROM Sensor;

ALTER TABLE Sensor DROP COLUMN DiaDaSemana;


SELECT dtLeitura, leituraTemp,
	CASE
    WHEN leituraTemp >= 50 THEN 'Temperatura crítica'
    WHEN leituraTemp <=30 THEN 'Temperatura normal'
	ELSE 'Temperatura elevada'
    END AS 'Status de Temperatura'
    FROM Sensor;
    
    
SELECT * FROM Sensor ORDER BY dtLeitura DESC;

SELECT * FROM Sensor ORDER BY dtleitura ASC;

SELECT * FROM Sensor
WHERE leituraUmi >=48;

SELECT * FROM Sensor
WHERE idSensor LIKE '14';

SELECT * FROM Sensor
WHERE idSensor NOT LIKE '10';

SELECT * FROM Sensor
WHERE idSensor != '6';


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
    
    
    
    
    
-- ---------------------------------------------------------------------------------------
-- criar tabela sobre sobre os os planos, junto com as regras de check
    
CREATE TABLE Plano (
idPlano INT PRIMARY KEY AUTO_INCREMENT,
statusPlano VARCHAR(15),
CONSTRAINT chkStatusPlano
	CHECK (statusPlano IN ('pago', 'pendente', 'atrasado')),
    
tipoPlano VARCHAR(15),
CONSTRAINT chkTipoPlano
	CHECK (tipoPlano IN ('mensal', 'anual')),
    
dtAssinatura DATE,
valorPlano DECIMAL (7,2)
);




DESC Plano;
-- inserir dados de planos assinados de 2025
INSERT Plano VALUES
	(DEFAULT, 'pago','mensal','2025-10-08',10000.00),
    (DEFAULT,'pendente','mensal','2025-06-10',1274.00),
    (DEFAULT,'atrasado','anual','2025-05-10',18000.00),
    (DEFAULT,'atrasado','mensal','2025-08-27',10000.00),
    (DEFAULT,'pendente','anual','2025-01-04',14678.00),
    (DEFAULT,'pago','mensal','2025-12-27',19000.00),
    (DEFAULT,'pago','mensal','2025-07-18',10000.00),
    (DEFAULT,'pendente','anual','2025-01-01',2810.00),
    (DEFAULT,'pago','anual','2025-11-07',2190.00);
    
SELECT * FROM Plano;



-- ver quais não foram pagos

SELECT * FROM Plano
	WHERE statusPlano IN ('pendente','atrasado');
    
    
-- select para ver a situação dos planos de 2025

SELECT *,
		CASE
    WHEN tipoPlano = 'Mensal' AND statusPlano = 'atrasado' THEN 'Plano Mensal Atrasado'
    WHEN tipoPlano = 'anual' AND statusPlano = 'atrasado' THEN 'Plano Anual Atrasado'
    WHEN tipoPlano = 'Mensal' AND statusPlano = 'pendente' THEN 'Plano Mensal Pendente'
	WHEN tipoPlano = 'Anual' AND statusPlano = 'pendente' THEN 'Plano Anual Pendente'
	WHEN tipoPlano = 'Mensal' AND statusPlano = 'pago' THEN 'Plano Mensal Pago'
	WHEN tipoPlano = 'Anual' AND statusPlano = 'pago' THEN 'Plano Anual Pago'
    END AS 'Situação de Pagamento'
    FROM plano;
 
 
-- ver os planos assinados no primeiro semestre    

select * from Plano
	where dtAssinatura < '2025-06-01';

-- ver os planos assinados no segundo semestre de 2025

select * from Plano
	where dtAssinatura>= '2025-06-01';


        
SELECT * FROM plano;



-- -----------------------------------------------------------------


CREATE TABLE Pagamento (
idPagamento INT PRIMARY KEY AUTO_INCREMENT,
formaPagamento VARCHAR(30) NOT NULL,
CONSTRAINT chkFormaPagamento
	CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
dtPagamento DATETIME
);
 
INSERT INTO Pagamento VALUES
(DEFAULT, 'pix', '2025-09-20 12:00:00'),
(DEFAULT, 'credito', '2025-12-02 13:10:00'),
(DEFAULT, 'transferencia', '2025-07-06 10:20:00'),
(DEFAULT, 'boleto', '2025-04-10 09:30:00'),
(DEFAULT, 'pix', '2025-11-15 11:00:00'),
(DEFAULT, 'boleto', '2025-08-11 15:45:00'),
(DEFAULT, 'credito', '2025-05-03 16:00:00'),
(DEFAULT, 'transferencia', '2025-06-02 17:28:00');

SELECT * FROM Pagamento;


ALTER TABLE Pagamento MODIFY COLUMN formaPagamento VARCHAR (60);

SELECT concat('Em ', dtPagamento, ' foi realizado o pagamento em ', formaPagamento) AS 'Forma de Pagamento' FROM Pagamento;

SELECT *, 
	CASE
    WHEN formaPagamento = 'pix' THEN 'Gerar QR CODE'
	WHEN formaPagamento = 'credito' THEN 'Solicitar aprovação'
    WHEN formaPagamento = 'boleto' THEN 'Gerar PDF'
	WHEN formaPagamento = 'transferencia' THEN 'Gerar comprovante'
    END AS 'Status do Pagamento'
    FROM pagamento;
    

SHOW TABLES;
    
TRUNCATE TABLE pagamento;
    
DROP TABLE pagamento;