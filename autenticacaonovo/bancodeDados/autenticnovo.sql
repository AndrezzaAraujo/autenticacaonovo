USE [master]
GO
/****** Object:  Database [autenticnovo]    Script Date: 18/01/2024 16:54:10 ******/
CREATE DATABASE [autenticnovo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'autenticnovo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NOVO\MSSQL\DATA\autenticnovo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'autenticnovo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NOVO\MSSQL\DATA\autenticnovo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [autenticnovo] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [autenticnovo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [autenticnovo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [autenticnovo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [autenticnovo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [autenticnovo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [autenticnovo] SET ARITHABORT OFF 
GO
ALTER DATABASE [autenticnovo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [autenticnovo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [autenticnovo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [autenticnovo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [autenticnovo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [autenticnovo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [autenticnovo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [autenticnovo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [autenticnovo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [autenticnovo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [autenticnovo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [autenticnovo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [autenticnovo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [autenticnovo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [autenticnovo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [autenticnovo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [autenticnovo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [autenticnovo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [autenticnovo] SET  MULTI_USER 
GO
ALTER DATABASE [autenticnovo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [autenticnovo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [autenticnovo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [autenticnovo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [autenticnovo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [autenticnovo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [autenticnovo] SET QUERY_STORE = ON
GO
ALTER DATABASE [autenticnovo] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [autenticnovo]
GO
/****** Object:  Table [dbo].[estado]    Script Date: 18/01/2024 16:54:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estado](
	[cod_estado] [int] IDENTITY(1,1) NOT NULL,
	[estado] [varchar](50) NULL,
 CONSTRAINT [PK_estado] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[utilizadores]    Script Date: 18/01/2024 16:54:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utilizadores](
	[cod_utilizador] [int] IDENTITY(1,1) NOT NULL,
	[utilizador] [varchar](50) NOT NULL,
	[palavra_passe] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[cod_estado] [int] NOT NULL,
 CONSTRAINT [PK_utilizadores] PRIMARY KEY CLUSTERED 
(
	[cod_utilizador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[estado] ON 

INSERT [dbo].[estado] ([cod_estado], [estado]) VALUES (1, N'ativo')
INSERT [dbo].[estado] ([cod_estado], [estado]) VALUES (2, N'desativado')
SET IDENTITY_INSERT [dbo].[estado] OFF
GO
SET IDENTITY_INSERT [dbo].[utilizadores] ON 

INSERT [dbo].[utilizadores] ([cod_utilizador], [utilizador], [palavra_passe], [email], [cod_estado]) VALUES (8, N'Andrezza Araujo', N'IQ7nerhfymQeYbukU9GJuQ==', N'jecileide.andrezza@gmail.com', 1)
INSERT [dbo].[utilizadores] ([cod_utilizador], [utilizador], [palavra_passe], [email], [cod_estado]) VALUES (9, N'Paulo Costa', N'm6tS449FU6w=', N'paulo@hotmail.com', 2)
SET IDENTITY_INSERT [dbo].[utilizadores] OFF
GO
ALTER TABLE [dbo].[utilizadores]  WITH CHECK ADD  CONSTRAINT [FK_utilizadores_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[estado] ([cod_estado])
GO
ALTER TABLE [dbo].[utilizadores] CHECK CONSTRAINT [FK_utilizadores_estado]
GO
/****** Object:  StoredProcedure [dbo].[alterar_PW]    Script Date: 18/01/2024 16:54:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[alterar_PW]
    @pwAtual AS VARCHAR(50),
    @pwNova AS VARCHAR(50),
    @confirmePw AS VARCHAR(50),
    @mensagem AS NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar se a senha atual está correta
    IF EXISTS (SELECT 1 FROM utilizadores WHERE palavra_passe = @pwAtual)
    BEGIN
        -- Verificar se a nova senha e a confirmação coincidem
        IF @pwNova = @confirmePw
        BEGIN
            -- Atualizar a senha
            UPDATE utilizadores SET palavra_passe = @pwNova WHERE palavra_passe = @pwAtual;

            -- Definir a mensagem de sucesso
            SET @mensagem = 'Senha alterada com sucesso.';
        END
        ELSE
        BEGIN
            -- Definir a mensagem de erro
            SET @mensagem = 'A nova senha e a confirmação não coincidem. Por favor, tente novamente.';
        END
    END
    ELSE
    BEGIN
        -- Definir a mensagem de erro
        SET @mensagem = 'Senha atual incorreta. Por favor, verifique e tente novamente.';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[inserir_utilizador]    Script Date: 18/01/2024 16:54:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[inserir_utilizador]
  @utilizador AS VARCHAR(50),
  @pw AS VARCHAR(50),
  @email AS VARCHAR(50),
  @cod_estado AS INT,
  @retorno INT OUTPUT

AS
BEGIN
    -- Se o utilizador e o email não existirem, inserir na base de dados
    IF NOT EXISTS (SELECT * FROM utilizadores WHERE utilizador = @utilizador OR email = @email)
    BEGIN
        -- Instruções de inserção da procedure aqui
        INSERT INTO utilizadores (utilizador, palavra_passe, email, cod_estado) VALUES (@utilizador, @pw, @email, @cod_estado)
        SET @retorno = 1 -- envio do parâmetro de saída
    END
    ELSE
    BEGIN
        SET @retorno = 0 -- envio do parâmetro de saída
    END
END
GO
/****** Object:  StoredProcedure [dbo].[login]    Script Date: 18/01/2024 16:54:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[login]
  @utilizador AS VARCHAR(50),
  @pw AS VARCHAR(50),
  @cod_estado as int,
  @retorno INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM utilizadores WHERE utilizador = @utilizador AND palavra_passe = @pw AND @cod_estado = cod_estado)
    BEGIN
        -- Utilizador e palavra-passe corretas e ativo
        SET @retorno = 1;
    END
    ELSE
    BEGIN
        -- Utilizador ou palavra-passe incorretos ou não ativo
        SET @retorno = 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[recuperar]    Script Date: 18/01/2024 16:54:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[recuperar]
	-- Add the parameters for the stored procedure here
	@email VARCHAR(50),
    @retorno INT OUTPUT,
    @novaPasse VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cod_estado INT;

    SELECT @cod_estado = cod_estado FROM utilizadores WHERE email = @email;

    IF EXISTS (SELECT 1 FROM utilizadores WHERE email = @email AND cod_estado = 1)
		BEGIN
        -- Conta ativa, faz update da palavra-passe
			SET @retorno = 1;
			UPDATE utilizadores SET palavra_passe = @novaPasse WHERE email = @email;
		END
    ELSE IF EXISTS (SELECT 1 FROM utilizadores WHERE email = @email AND cod_estado = 2)
		BEGIN
			-- Conta inativa
			SET @retorno = 2;
		END
    ELSE
		BEGIN
			-- Erro
			SET @retorno = 0;
		END
END;

GO
USE [master]
GO
ALTER DATABASE [autenticnovo] SET  READ_WRITE 
GO
