create schema if not exists oficina;
use oficina;
-- Tabela Cliente
CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Endereço VARCHAR(100),
    Telefone VARCHAR(15)
);

-- Tabela Veículo
CREATE TABLE Veículo (
    VeículoID INT PRIMARY KEY,
    ClienteID INT,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

-- Tabela Serviço
CREATE TABLE Serviço (
    ServiçoID INT PRIMARY KEY,
    VeículoID INT,
    FuncionárioID INT,
    Data DATE NOT NULL,
    Descrição TEXT,
    Custo DECIMAL(10, 2),
    FOREIGN KEY (VeículoID) REFERENCES Veículo(VeículoID),
    FOREIGN KEY (FuncionárioID) REFERENCES Funcionário(FuncionárioID)
);

-- Tabela Peça
CREATE TABLE Peça (
    PeçaID INT PRIMARY KEY,
    Descrição VARCHAR(100) NOT NULL,
    Preço DECIMAL(10, 2)
);

-- Tabela Funcionário
CREATE TABLE Funcionário (
    FuncionárioID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cargo VARCHAR(50),
    Salário DECIMAL(10, 2)
);

-- vamos popular nossa tabela com alguns exemplos

-- Inserção de dados de exemplo
INSERT INTO Cliente (ClienteID, Nome, Endereço, Telefone) VALUES
    (1, 'João Silva', 'Rua A, 123', '123-456-7890'),
    (2, 'Maria Souza', 'Av. B, 456', '987-654-3210');

INSERT INTO Veículo (VeículoID, ClienteID, Marca, Modelo, Ano) VALUES
    (1, 1, 'Toyota', 'Corolla', 2018),
    (2, 2, 'Ford', 'Fiesta', 2020);

INSERT INTO Funcionário (FuncionárioID, Nome, Cargo, Salário) VALUES
    (1, 'Carlos Santos', 'Mecânico', 3000.00),
    (2, 'Ana Rodrigues', 'Atendente', 2500.00);

-- vamos utilizar algumas queries básicas

show databases;
show tables;

-- Recuperar todos os clientes
SELECT * FROM Cliente;

-- Recuperar todos os veículos
SELECT * FROM Veículo;

-- Recuperar todos os funcionários
SELECT * FROM Funcionário;

SELECT * FROM Veículo WHERE ClienteID = 1;

SELECT * FROM Serviço WHERE VeículoID = 1;

-- Calcular o custo total de todos os serviços
SELECT SUM(Custo) AS CustoTotal FROM Serviço;


SELECT * FROM Peça WHERE Preço > 50.00;

-- Listar os veículos em ordem decrescente de ano
SELECT * FROM Veículo ORDER BY Ano DESC;

-- Listar os funcionários em ordem alfabética de nome
SELECT * FROM Funcionário ORDER BY Nome;

-- Recuperar os funcionários que realizaram mais de 3 serviços
SELECT FuncionárioID, COUNT(*) AS TotalServiços FROM Serviço GROUP BY FuncionárioID HAVING TotalServiços >= 1;

-- Recuperar os detalhes de um serviço, incluindo nome do cliente e modelo do veículo
SELECT S.ServiçoID, C.Nome AS Cliente, V.Modelo AS VeículoModelo, S.Data, S.Custo
FROM Serviço S
JOIN Veículo V ON S.VeículoID = V.VeículoID
JOIN Cliente C ON V.ClienteID = C.ClienteID
WHERE S.ServiçoID = 1;


