CREATE DATABASE Campeonato2;

CREATE TABLE Clube
(
    ID INT IDENTITY (1,1),
    Nome VARCHAR(50) NOT NULL,
    Apelido VARCHAR(50) NOT null,
    Dt_Criacao DATE NOT NULL,
    Gol_Contra INT DEFAULT 0,
    Gol_Feito INT DEFAULT 0,
    Pontuacao INT DEFAULT 0,

    CONSTRAINT PK_Time PRIMARY KEY (ID)
);

CREATE TABLE Jogo
(
    Time_Casa INT NOT NULL,
    Time_Visitante INT NOT NULL,
    Gols_Casa INT DEFAULT 0,
    Gols_Visitante INT DEFAULT 0,
    Soma_Gols INT DEFAULT 0,

    CONSTRAINT PK_Jogo PRIMARY KEY (Time_Casa, Time_Visitante),
    CONSTRAINT FK_Jogo_Time1 FOREIGN KEY (Time_Casa) REFERENCES Clube (ID),
    CONSTRAINT FK_Jogo_Time2 FOREIGN KEY (Time_Visitante) REFERENCES Clube (ID)
);


CREATE TABLE Campeonato
(
    ID INT IDENTITY (1,1),
    Nome VARCHAR(50) NOT NULL,
    Ano INT NOT NULL,

    CONSTRAINT PK_Campeonato PRIMARY KEY (ID)
);


SELECT *
FROM Clube;

SELECT *
FROM Campeonato;

SELECT *
FROM Jogo;

--- Cadastrar Times ---

INSERT INTO Clube
    (Nome, Apelido, Dt_Criacao)
VALUES
    ('Clube A', 'Timão A', '1987-03-15'),
    ('Clube B', 'Timão B', '1988-04-16'),
    ('Clube C', 'Timão C', '1989-05-17'),
    ('Clube D', 'Timão D', '1990-06-18'),
    ('Clube E', 'Timão E', '1991-07-19');

--- Cadastrar Jogos ---

INSERT INTO Jogo
    (Time_Casa, Time_Visitante, Gols_Casa, Gols_Visitante)
VALUES
    (1, 2, 3, 1),
    (2, 1, 3, 1),
    (1, 3, 3, 1),
    (3, 1, 4, 3),
    (1, 4, 0, 0),
    (4, 1, 1, 1),
    (1, 5, 4, 1),
    (5, 1, 3, 2),
    (2, 3, 3, 1),
    (3, 2, 4, 3),
    (2, 4, 3, 2),
    (4, 2, 3, 1),
    (2, 5, 3, 2),
    (5, 2, 4, 3),
    (3, 4, 3, 1),
    (4, 3, 4, 3),
    (3, 5, 3, 2),
    (5, 3, 3, 1),
    (4, 5, 3, 2),
    (5, 4, 3, 3);

