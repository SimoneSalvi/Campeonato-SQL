USE Campeonato2;
GO

-->> TRIGGERS <<--


-- Calcula Pontos e Gols
CREATE OR ALTER TRIGGER CalculaPontuacao ON Jogo after insert
AS
BEGIN
    DECLARE @Time_Casa int, @Time_Visitante int, @Gols_Casa int,  @Gols_Visitante int, 
            @ID int, @Gol_Contra int, @Gol_Feito int, @Pontuacao int

    SELECT @ID = ID, @Gol_Contra = Gol_Contra, @Gol_Feito = Gol_Feito, @Pontuacao = Pontuacao
    FROM Clube

    SELECT @Time_Casa = Time_Casa, @Time_Visitante = Time_Visitante, @Gols_Casa = Gols_Casa, @Gols_Visitante = Gols_Visitante
    FROM Jogo

    IF(@Gols_Casa > @Gols_Visitante) UPDATE Clube SET Pontuacao = (@Pontuacao + 3) WHERE @Time_Casa = ID

    IF(@Gols_Casa < @Gols_Visitante) UPDATE Clube SET Pontuacao = (@Pontuacao + 5) WHERE @Time_Visitante = ID

    IF(@Gols_Casa = @Gols_Visitante) UPDATE Clube SET Pontuacao = (@Pontuacao + 1) WHERE @Time_Casa = ID and @Time_Visitante = ID

    UPDATE Clube SET Gol_Contra = (@Gol_Contra + @Gols_Visitante), Gol_Feito = (@Gol_Feito + @Gols_Casa) WHERE @Time_Casa = ID

    UPDATE Clube SET Gol_Contra = (@Gol_Contra + @Gols_Casa), @Gol_Feito = (@Gol_Feito + @Gols_Visitante) WHERE @Time_Visitante = ID

END;

-- Soma o total de gols da partida
GO
CREATE OR ALTER TRIGGER SomaGolsJogo on Jogo after INSERT
AS
BEGIN
    DECLARE @Gols_Casa int,  @Gols_Visitante int, @Soma_Gols INT
    SELECT @Gols_Casa = Gols_Casa, @Gols_Visitante = Gols_Visitante, @Soma_Gols = Soma_Gols
    FROM Jogo

    SET @Soma_Gols = @Gols_Casa + @Gols_Visitante

    UPDATE Jogo SET Soma_Gols = @Soma_Gols
END;

-->> PROCEDURES <<--

-- Calcula Pontos e Gols

--  Define o campeão
GO
CREATE OR ALTER PROC DeterminaCampeao
AS
BEGIN
    SELECT TOP(1)
        Pontuacao, Nome
    FROM Clube
    ORDER BY Pontuacao DESC;
END;

EXEC.DeterminaCampeao

--  Define os 5 primeiros
GO
CREATE OR ALTER PROC Determina5Primeiros
AS
BEGIN
    SELECT TOP(5)
        Pontuacao, Nome
    FROM Clube
    ORDER BY Pontuacao DESC;
END;

EXEC.Determina5Primeiros

-- Quem fez mais gols no campeonato

GO
CREATE OR ALTER PROC FezMaisGols
AS
BEGIN
    SELECT MAX(Gol_Feito) as 'Maior quantidade de Gols', Nome
    FROM Clube
    GROUP BY Nome
END;

EXEC.FezMaisGols

-- Qual jogo teve mais gols?
GO
CREATE OR ALTER PROC PartidaMaisGols
AS
BEGIN
    SELECT Max(Soma_Gols) as 'Maior numero de gols no jogo', Time_Casa, Time_Visitante
    FROM Jogo
    GROUP BY Soma_Gols
END;



