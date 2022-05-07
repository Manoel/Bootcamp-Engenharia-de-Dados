--
-- Banco de dados: DB_IGTI
--

USE master
go

set nocount on;
go

-- Drop database
IF DB_ID('DB_IGTI') IS NOT NULL begin 
   ALTER DATABASE DB_IGTI set single_user with rollback immediate; 
   DROP DATABASE DB_IGTI;
end

-- Create database
CREATE DATABASE DB_IGTI;
GO

USE DB_IGTI;
GO

---------------------------------------------------------------------
-- Create Tables
---------------------------------------------------------------------

--
-- Estrutura da tabela TblArea_Conhecimento
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblArea_Conhecimento]') and schema_id = 1)
BEGIN
	DROP TABLE TblArea_Conhecimento
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblArea_Conhecimento]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblArea_Conhecimento] 
(
  id_area_conhecimento int identity(1,1) NOT NULL,
  descricao varchar(60) NOT NULL,
  CONSTRAINT PK_TblAreaConhecimento_id_area_conhecimento PRIMARY KEY CLUSTERED (id_area_conhecimento),
  CONSTRAINT id_area_conhecimento_UNIQUE UNIQUE (id_area_conhecimento),
  CONSTRAINT descricao_UNIQUE UNIQUE (descricao)
) 
END

--
-- Extraindo dados da tabela TblArea_Conhecimento
--

INSERT INTO TblArea_Conhecimento ( descricao) VALUES
('Espiritualismo'),
('Infanto-Juvenil'),
('Economia'),
('Medicina'),
('literatura nacional'),
('história'),
('Fantasia'),
('filosofia'),
('tecnologia da informação'),
( 'Comédia'),
( 'Economia 2'),
( 'Saúde'),
( 'Nutrição'),
( 'Matemática'),
( 'Astronomia'),
( 'literatura  estrangeira'),
( 'artes'),
( 'entretenimento'),
( 'administração e negócios'),
( 'engenharia'),
( 'sociologia');

-- --------------------------------------------------------

--
-- Estrutura da tabela TblAutor
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblAutor]') and schema_id = 1)
BEGIN
	DROP TABLE TblAutor
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblAutor]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblAutor] 
(
  id_autor int identity(1,1) NOT NULL,
  nome varchar(60) NOT NULL,
  biografia varchar(max) DEFAULT NULL,
  CONSTRAINT PK_TbAutor_id_autor PRIMARY KEY CLUSTERED (id_autor),
)
END
--
-- Extraindo dados da tabela TblAutor
--

INSERT INTO TblAutor ( nome, biografia) VALUES
('Roberto Martins Figueiredo', 'Roberto Martins Figueiredo é um biomédico brasileiro, conhecido como Dr. Bactéria ao participar do quadro Tá limpo do programa Fantástico. Na série, ele falava dos perigos microscópicos que se escondem no cotidiano, esclarecendo dúvidas sobre contaminação de alimentos, higiene, saúde pública e temas relacionados.'),
('Daniel Kahneman', 'Daniel Kahneman é um teórico da economia comportamental, a qual combina a economia com a ciência cognitiva para explicar o comportamento aparentemente irracional da gestão do risco pelos seres humanos.'),
('Hilary Duff', NULL),
('Robson Pinheiro', 'Robson Pinheiro Santos é um médium psicógrafo brasileiro. Suas obras psicografadas destacam-se pela influência da Umbanda.'),
('Cecelia Ahern', NULL),
('Arlene Eisenberg', 'Arlene Leila Scharaga Eisenberg foi uma autora mais conhecida por suas contribuições aos pais na literatura de auto-ajuda. Eisenberg co-escreveu o que foi descrito como a \''bíblia da gravidez americana\'', o que esperar quando você está esperando'),
('Sandee Hathaway', NULL),
('Heidi Murkoff', 'Heidi Murkoff é autora da série de guias de gravidez O que esperar quando você está esperando. Ela também é a criadora de WhatToExpect.com e fundadora da Fundação What to Expect. A revista Time nomeou Murkoff como uma das 100 pessoas mais influentes do mundo em 2011.'),
('Julio Cesar de Barros', 'Jornalista e Escritor'),
( 'Maria José Valero', 'Bióloga e Escritora'),
( 'Jared Diamond', NULL),
( 'Monteiro Lobato', 'José Bento Renato Monteiro Lobato foi um escritor, ativista, diretor e produtor brasileiro. Foi um importante editor de livros inéditos e autor de importantes traduções.'),
( 'Machado de Assis', 'Joaquim Maria Machado de Assis foi um escritor brasileiro, considerado por muitos críticos, estudiosos, escritores e leitores um dos maiores senão o maior nome da literatura do Brasil.'),
( 'Yuval Noah Harari', 'Professor israelense de História');

-- --------------------------------------------------------

--
-- Estrutura da tabela TblEditora
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblEditora]') and schema_id = 1)
BEGIN
	DROP TABLE TblEditora
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblEditora]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblEditora] 
(
  id_editora int identity(1,1) NOT NULL,
  nome_editora varchar(45) NOT NULL,
  cidade varchar(45) DEFAULT NULL,
  pais varchar(45) NOT NULL,
  telefone int DEFAULT NULL,
  representante varchar(45) DEFAULT NULL,
  CONSTRAINT PK_TbAutoria_id_editora PRIMARY KEY CLUSTERED (id_editora),
  CONSTRAINT id_editora_UNIQUE UNIQUE (id_editora),
  CONSTRAINT nome_editora_UNIQUE UNIQUE (nome_editora)
)
END
--
-- Extraindo dados da tabela TblEditora
--

INSERT INTO TblEditora ( nome_editora, cidade, pais, telefone, representante) VALUES
('Casa dos Espiritos', 'Porto Alegre', 'Brasil', 32334455, 'ANOVA'),
('Editora Lê', 'Belo Horizonte', 'Brasil', 32344456, 'ATENAS'),
('Id Editora', NULL, 'Brasil', 32354457, 'DOTEARTE'),
('Objetiva', NULL, 'Brasil', 32364458, 'NEVE'),
('Manole', 'Rio de Janeiro', 'Brasil', 32374459, 'ATENAS'),
('Novo Conceito', NULL, 'Brasil', 32384460, 'ANOVA'),
('Benvirá', NULL, 'Brasil', 32384461, 'ANOVA'),
('Scipione', 'Londres', 'Inglaterra', 32394462, 'REIKI'),
('Atica', NULL, 'Inglaterra', 32404463, 'ANOVA'),
( 'Campus', 'Rio de Janeiro', 'Brasil', 32414464, 'REIKI'),
( 'Novatec', 'São Paulo', 'Brasil', 32424465, 'ANOVA'),
( 'Bookman', 'Boston', 'Estados Unidos', 32434466, 'ATENAS'),
( 'Record', 'Miami', 'Estados Unidos', 32444467, 'NEVE');

-- --------------------------------------------------------

----
---- Estrutura da tabela TblEmprestimo
----

--IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblEmprestimo]') and schema_id = 1)
--BEGIN
--	DROP TABLE TblEmprestimo
--END
--IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblEmprestimo]') and schema_id = 1)
--BEGIN
--CREATE TABLE [dbo].[TblEmprestimo] 
--(
--  id_exemplar int NOT NULL,
--  id_usuario int NOT NULL,
--  dt_emprestimo date NOT NULL,
--  dt_prevista_devolucao date NOT NULL,
--  dt_devolucao date DEFAULT NULL,
--  hora time DEFAULT NULL,
--  CONSTRAINT fk_emprestimo_usuario1_idx FOREIGN KEY(id_usuario)
--    REFERENCES TblUsuario(id_usuario),
--  CONSTRAINT fk_emprestimo_exemplar1 FOREIGN KEY(id_exemplar)
--	REFERENCES TblExemplar(id_exemplar)

--  --KEY fk_emprestimo_usuario1_idx (id_usuario),
--  --KEY fk_emprestimo_exemplar1 (id_exemplar)
--)
--END

----
---- Extraindo dados da tabela TblEmprestimo
----

--INSERT INTO TblEmprestimo (id_exemplar, id_usuario, dt_emprestimo, dt_prevista_devolucao, dt_devolucao, hora) VALUES
--(19, 12, '2004-09-22', '2004-10-02', '2004-10-02', '12:14:23'),
--(20, 14, '1998-03-23', '1998-04-02', '1998-04-02', '17:42:46'),
--(21, 12, '1990-08-26', '1990-09-05', '1990-09-05', '10:02:07'),
--(22, 8, '2018-11-27', '2018-12-07', '2018-12-07', '09:43:58'),
--(23, 15, '1990-03-21', '1990-03-31', '1990-04-01', '16:08:10'),
--(1, 12, '2009-01-14', '2009-01-24', '2009-01-24', '09:48:24'),
--(25, 4, '2009-10-28', '2009-11-07', '2009-11-07', '16:31:50'),
--(11, 3, '2002-02-21', '2002-03-03', '2002-03-03', '09:34:01'),
--(5, 12, '2019-04-14', '2019-04-24', '2019-04-24', '11:13:45'),
--(19, 11, '1994-10-26', '1994-11-05', '1994-11-05', '14:57:32'),
--(4, 7, '2020-02-15', '2020-02-25', '2020-02-25', '09:16:38'),
--(7, 12, '2017-04-08', '2017-04-18', '2017-04-18', '12:23:41'),
--(19, 4, '1990-07-07', '1990-07-17', '1990-07-17', '09:03:01'),
--(19, 1, '2006-10-08', '2006-10-18', '2006-10-18', '09:35:03'),
--(12, 12, '2021-05-11', '2021-05-21', NULL, NULL),
--(13, 7, '1990-12-22', '1991-01-01', '1991-01-01', '08:35:41'),
--(15, 6, '2010-05-09', '2010-05-19', '2010-05-19', '11:42:36'),
--(8, 12, '1999-06-05', '1999-06-15', '1999-06-15', '10:41:00'),
--(15, 5, '2004-03-26', '2004-04-05', '2004-04-05', '17:46:41'),
--(19, 12, '2021-04-09', '2021-04-19', '2021-04-19', '16:00:31'),
--(12, 6, '2021-05-03', '2021-05-13', '2021-05-17', '15:05:08'),
--(25, 5, '1991-11-22', '1991-12-02', '1991-12-02', '08:24:31'),
--(16, 1, '1994-12-22', '1995-01-01', '1995-01-01', '09:48:41'),
--(19, 4, '2016-07-23', '2016-08-02', '2016-08-02', '10:00:34'),
--(33, 8, '2004-04-28', '2004-05-08', '2004-05-08', '13:51:09'),
--(8, 9, '1995-08-08', '1995-08-18', '1995-08-18', '16:11:16'),
--(33, 9, '1992-08-20', '1992-08-30', '1992-08-30', '08:15:47'),
--(27, 7, '2012-04-27', '2012-05-07', '2012-05-07', '12:50:38'),
--(19, 8, '2021-03-14', '2021-03-24', '2021-03-24', '14:28:05'),
--(34, 11, '1996-06-09', '1996-06-19', '1996-06-19', '15:22:56'),
--(18, 15, '2006-09-16', '2006-09-26', '2006-09-26', '14:08:13'),
--(6, 15, '2013-09-05', '2013-09-15', '2013-09-15', '12:45:43'),
--(19, 17, '1991-06-21', '1991-07-01', '1991-07-01', '14:50:11'),
--(3, 11, '1997-04-17', '1997-04-27', '1997-04-27', '17:59:59'),
--(5, 10, '2012-09-21', '2012-10-01', '2012-10-01', '08:55:46');

-- --------------------------------------------------------

--
-- Estrutura da tabela TblExemplar
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblExemplar]') and schema_id = 1)
BEGIN
	DROP TABLE TblExemplar
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblExemplar]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblExemplar] 
(
  id_exemplar int identity(1,1) NOT NULL,
  id_livro int DEFAULT NULL,
  isbn varchar(45) DEFAULT NULL,
  idexemplar smallint DEFAULT NULL,
  situacao varchar(20) DEFAULT NULL,
  CONSTRAINT PK_TblExemplar_id_exemplar PRIMARY KEY CLUSTERED (id_exemplar)
)
END
--
-- Extraindo dados da tabela TblExemplar
--

INSERT INTO TblExemplar ( id_livro, isbn, idexemplar, situacao) VALUES
(1, '764321', 1, 'disponível'),
(1, '764321', 2, 'disponível'),
(2, '4347421', 1, 'extraviado'),
(3, '64732829', 1, 'em manutenção'),
(3, '64732829', 2, 'disponível'),
(4, '236678678', 1, 'disponível'),
(5, '12354321', 1, 'disponível'),
(6, '67849098', 1, 'disponível'),
(7, '274532617', 1, 'disponível'),
( 8, '7644309', 1, 'disponível'),
( 9, '98076534', 1, 'disponível'),
( 10, '3214667-1', 1, 'emprestado'),
( 10, '3214667-1', 2, 'extraviado'),
( 11, '3214667-2', 1, 'disponível'),
( 11, '3214667-2', 2, 'disponível'),
( 11, '3214667-2', 3, 'disponível'),
( 12, '12323456-1', 1, 'disponível'),
( 12, '12323456-1', 2, 'disponível'),
( 13, '8764321-1', 1, 'disponível'),
( 13, '8764321-1', 2, 'disponível'),
( 13, '8764321-1', 3, 'disponível'),
( 14, '8764321-2', 1, 'disponível'),
( 14, '8764321-2', 2, 'em manutenção'),
( 14, '8764321-2', 3, 'disponível'),
( 15, '8764321-3', 1, 'disponível'),
( 16, '98764321-1', 1, 'disponível'),
( 16, '98764321-1', 2, 'disponível'),
( 16, '98764321-1', 3, 'disponível'),
( 17, '98764321-2', 1, 'em manutenção'),
( 17, '98764321-2', 2, 'disponível'),
( 18, '98764321-3', 1, 'disponível'),
( 19, '68764321-1', 1, 'disponível'),
( 22, '123456-1', 1, 'disponível'),
( 22, '123456-1', 2, 'disponível'),
( 23, '123456-2', 1, 'disponível');

-- --------------------------------------------------------

--
-- Estrutura da tabela TblIdioma
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblIdioma]') and schema_id = 1)
BEGIN
	DROP TABLE TblIdioma
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblIdioma]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblIdioma] 
(
  id_idioma int identity(1,1) NOT NULL,
  descricao varchar(45) NOT NULL,
  CONSTRAINT PK_TblIdioma_id_idioma PRIMARY KEY CLUSTERED (id_idioma),
  CONSTRAINT descricao_UNIQUE UNIQUE (descricao)
)
END
--
-- Extraindo dados da tabela TblIdioma
--

INSERT INTO TblIdioma ( descricao) VALUES
( 'Português'),
( 'Inglês'),
( 'Espanhol'),
( 'Alemão');

-- --------------------------------------------------------

--
-- Estrutura da tabela TblLivro
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblLivro]') and schema_id = 1)
BEGIN
	DROP TABLE TblLivro
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblLivro]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblLivro] 
(
  id_livro int identity(1,1) NOT NULL,
  titulo_livro varchar(100) NOT NULL,
  ano_edicao int DEFAULT NULL,
  numero_edicao int DEFAULT NULL,
  isbn varchar(45) DEFAULT NULL,
  preco decimal(10,0) DEFAULT NULL,
  id_area_conhecimento int DEFAULT NULL,
  id_editora int NOT NULL,
  id_idioma int NOT NULL,
  CONSTRAINT PK_TblLivro_id_livro PRIMARY KEY CLUSTERED (id_livro),
  CONSTRAINT id_livro_UNIQUE UNIQUE (id_livro),
  CONSTRAINT ISBN_UNIQUE UNIQUE (isbn),

  CONSTRAINT FK_livro_editora_idx FOREIGN KEY(id_editora)
    REFERENCES TblEditora(id_editora),
  CONSTRAINT FK_livro_area_conhecimento1_idx FOREIGN KEY(id_area_conhecimento)
	REFERENCES TblArea_Conhecimento(id_area_conhecimento),
  CONSTRAINT FK_livro_idioma FOREIGN KEY(id_idioma)
	REFERENCES TblIdioma(id_idioma)

  --KEY `fk_livro_editora_idx` (`id_editora`),
  --KEY `fk_livro_area_conhecimento1_idx` (`id_area_conhecimento`),
  --KEY `fk_livro_idioma` (`id_idioma`)
) 
END
--
-- Extraindo dados da tabela TblLivro
--

INSERT INTO TblLivro ( titulo_livro, ano_edicao, numero_edicao, isbn, preco, id_area_conhecimento, id_editora, id_idioma) VALUES
('Pelas Ruas de Calcutá', 1990, 1, '764321', '36', 1, 5, 1),
('Devoted - Devoção', 2000, 1, '4347421', '27', 1, 4, 1),
('Rápido e Devagar - Duas Formas de Pensar', 2015, 3, '64732829', '44', 3, 8, 2),
('Xô, Bactéria! Tire Suas Dúvidas Com Dr. Bactéria', 2019, 10, '236678678', '33', NULL, 4, 1),
('P.s. - Eu Te Amo ', 2010, 4, '12354321', '24', 4, 4, 1),
('O Que Esperar Quando Você Está Esperando', 2000, 3, '67849098', '38', NULL, 4, 1),
('As Melhores Frases Em Veja', 2017, 1, '274532617', '24', 7, 4, 1),
('Bichos Monstruosos', 2015, 1, '7644309', '25', 6, 12, 1),
('Casas Mal Assombradas', 1995, 1, '98076534', '28', 6, 10, 1),
( 'Colapso', 2005, 12, '3214667-1', '93', 6, 13, 1),
( 'Colapso', 2005, 12, '3214667-2', '93', 6, 13, 2),
( 'Armas, germes e aço', 2017, 23, '12323456-1', '101', 6, 13, 1),
( 'Memórias Póstumas de Brás Cubas', 1881, 1, '8764321-1', '23', 5, 1, 1),
( 'Memórias Póstumas de Brás Cubas', 1881, 1, '8764321-2', '23', 9, 1, 3),
( 'Memórias Póstumas de Brás Cubas', 1881, 1, '8764321-3', '23', 5, 12, 2),
( 'Dom Casmurro', 1899, 1, '98764321-1', '26', 5, 1, 1),
( 'Dom Casmurro', 1899, 1, '98764321-2', '36', 5, 12, 2),
( 'Dom Casmurro', 1899, 1, '98764321-3', '26', 5, 1, 3),
( 'Quincas Borba', 1891, 1, '68764321-1', '36', 5, 5, 1),
( 'Sapiens: Uma breve história da humanidade', 2018, 1, '123456-1', '50', 6, 5, 1),
( 'Sapiens: Uma breve história da humanidade', 2018, 1, '123456-2', '50', 6, 5, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela TblAutoria
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblAutoria]') and schema_id = 1)
BEGIN
	DROP TABLE TblAutoria
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblAutoria]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblAutoria] 
(
  id_autor int NOT NULL,
  id_livro int NOT NULL,
  CONSTRAINT PK_TbAutoria_id_autor PRIMARY KEY CLUSTERED (id_autor,id_livro),
  CONSTRAINT FK_autoria_livro1_idx FOREIGN KEY(id_livro)
    REFERENCES TblLivro(id_livro),
  --KEY `fk_autoria_livro1_idx` (`id_livro`)
)
END
--
-- Extraindo dados da tabela TblAutoria
--

INSERT INTO TblAutoria (id_autor, id_livro) VALUES
(1, 4),
(2, 3),
(3, 2),
(4, 1),
(5, 5),
(6, 7),
(6, 8),
(7, 9),
(8, 10),
(10, 11),
(11, 11),
(12, 11),
(13, 13),
(14, 13),
(15, 13),
(16, 13),
(17, 13),
(18, 13),
(19, 13),
(22, 14),
(23, 14);

-- --------------------------------------------------------

--
-- Estrutura da tabela TblUsuario
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblUsuario]') and schema_id = 1)
BEGIN
	DROP TABLE TblUsuario
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblUsuario]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblUsuario] 
(
  id_usuario int identity(1,1) NOT NULL,
  nome varchar(45) NOT NULL,
  cpf bigint NOT NULL,
  rg int DEFAULT NULL,
  dt_nascimento date DEFAULT NULL,
  sexo varchar(9) DEFAULT NULL,
  email varchar(70) NOT NULL,
  cep varchar(8) NOT NULL,
  logradouro varchar(500) NOT NULL,
  numero smallint NOT NULL,
  bairro varchar(60) NOT NULL,
  cidade varchar(60) NOT NULL,
  uf varchar(2) NOT NULL,
  tel_fixo bigint NOT NULL,
  tel_celular bigint DEFAULT NULL,
  status varchar(10) NOT NULL,
  CONSTRAINT PK_TblUsuario_id_usuario PRIMARY KEY CLUSTERED (id_usuario),
)
END
--
-- Extraindo dados da tabela TblUsuario
--

INSERT INTO TblUsuario ( nome, cpf, rg, dt_nascimento, sexo, email, cep, logradouro, numero, bairro, cidade, uf, tel_fixo, tel_celular, status) VALUES
('Mariana Fátima Viana', 17587654968, 185600827, '1963-06-24', 'Feminino', 'marianafatimaviana@sheilabenavente.com.br', '69314533', 'Rua Cândido Pereira', 987, 'Doutor Sílvio Botelho', 'Boa Vista', 'RR', 9537490617, 95986602819, 'Ativo'),
('Jéssica Daniela da Mata', 22803230445, 428875907, '1954-02-19', 'Feminino', 'jessicadanieladamata-92@thibe.com.br', '74713240', 'Rua Guaiaquil', 605, 'Jardim Novo Mundo', 'Goiânia', 'GO', 6228169418, 62998439117, 'Ativo'),
('Juan Paulo Pereira', 9779961828, 484305256, '1943-11-27', 'Masculino', 'juanpaulopereira_@magicday.com.br', '69901758', 'Rua Arco-íris', 605, 'Vitória', 'Rio Branco', 'AC', 6826298043, 68999318454, 'Ativo'),
('Elias Raul Teixeira', 36878713129, 380335566, '1960-11-03', 'Masculino', 'eeliasraulteixeira@bat.com', '77403230', 'Rua 3', 478, 'Jardim Eldorado', 'Gurupi', 'TO', 6335431427, 63987244742, 'Ativo'),
('Marcos Vinicius Bento Fogaça', 37362747004, 165559299, '2001-09-05', 'Masculino', 'marcosviniciusbentofogaca@yaooh.com', '71261330', 'Quadra Quadra 3 Conjunto 25', 208, 'Setor Leste (Vila Estrutural - Guará)', 'Brasília', 'DF', 6139883293, 61996206560, 'Ativo'),
('Rafaela Isabel Raimunda Aparício', 1017588635, 467470571, '1984-07-04', 'Feminino', 'rafaelaisabelraimundaaparicio-92@arablock.com.br', '57083064', 'Vila Padre Cícero', 850, 'Antares', 'Maceió', 'AL', 8228640060, 82985070436, 'Suspenso'),
('Ana Louise Agatha Galvão', 74652481241, 329087575, '1960-05-19', 'Feminino', 'aanalouiseagathagalvao@abdalathomaz.adv.br', '54410323', '1ª Travessa Maria Rita Barradas', 909, 'Piedade', 'Jaboatão dos Guararapes', 'PE', 8127840834, 81997453396, 'Ativo'),
('Analu Evelyn Milena Aparício', 48892704508, 488384667, '1950-05-20', 'Feminino', 'analuevelynmilenaaparicio_@yahool.com.br', '78731432', 'Rua Gv-22', 401, 'Setor Residencial Granville II', 'Rondonópolis', 'MT', 6637208818, 66999067930, 'Ativo'),
('Francisca Julia Gonçalves', 67463166295, 322052579, '1944-02-27', 'Feminino', 'franciscajuliagoncalves@fernandesfilpi.com.br', '60356610', 'Travessa Boata', 100, 'Antônio Bezerra', 'Fortaleza', 'CE', 8537720094, 85988887344, 'Ativo'),
( 'Brenda Sebastiana Regina da Conceição', 9387021572, 499837794, '1949-12-27', 'Feminino', 'brendasebastianareginadaconceicao@solutionimoveis.com.br', '96506395', 'Rua Bruno Reinaldo Kipper', 456, 'Nossa Senhora de Fátima', 'Cachoeira do Sul', 'RS', 5137389592, 51988887387, 'Ativo'),
( 'Sophia Tatiane Lopes', 2023823110, 222874235, '1997-12-26', 'Feminino', 'STL@yahool.com.br', '79104460', 'Rua 66', 205, 'Vila Nova Campo Grande', 'Campo Grande', 'MS', 6725963752, 67999550907, 'Ativo'),
( 'Marcelo de Lima', 21002949467, 495922705, '1996-12-20', 'Masculino', 'marceloolima@gabiaatelier.com.br', '68927393', 'Travessa L14 do Provedor', 691, 'Provedor', 'Santana', 'AP', 9635009775, 96996507201, 'Ativo'),
( 'Maitê Allana Galvão', 33898989640, 500757008, '2000-11-19', 'Feminino', 'mmaiteallanagalvao@pq.cnpq.br', '24716400', 'Rua Sampaio Rodrigues', 487, 'Jardim Catarina', 'São Gonçalo', 'RJ', 2125071076, 21998339757, 'Ativo'),
( 'Patricia Nina Antônia Teixeira', 60294169873, 247838664, '1977-05-11', 'Feminino', 'patricianinaantoniateixeira@jonasmartinez.com', '68902017', 'Rua Três', 619, 'Beirol', 'Macapá', 'AP', 9636264952, 96998152747, 'Ativo'),
( 'Jairo Amaral', 98765432189, 99999999, '2000-12-09', 'Masculino', 'jairo@email.com', '78731432', 'Rua Gv-22', 401, 'Setor Residencial Granville II', 'Rondonópolis', 'MT', 6637208818, NULL, 'Ativo'),
( 'Milene Barcellos', 12345678907, 97123467, '1975-07-13', 'Feminino', 'mbarcallos@gmail.com', '77403230', 'Rua 4', 123, 'Jardim Eldorado', 'Gurupi', 'TO', 6425431427, 63987241213, 'Ativo'),
( 'Clarice Damasceno', 16273849573, 234876987, '2005-12-21', 'Feminino', 'clarice@hotmail.com', '74713240', 'Rua Guaiaquil', 604, 'Jardim Novo Mundo', 'Goiânia', 'GO', 8534520094, 63982141213, 'Ativo');

--
-- Estrutura da tabela TblEmprestimo
--

IF EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblEmprestimo]') and schema_id = 1)
BEGIN
	DROP TABLE TblEmprestimo
END
IF NOT EXISTS (SELECT * FROM SYS.objects WHERE object_id = OBJECT_ID(N'[TblEmprestimo]') and schema_id = 1)
BEGIN
CREATE TABLE [dbo].[TblEmprestimo] 
(
  id_exemplar int NOT NULL,
  id_usuario int NOT NULL,
  dt_emprestimo date NOT NULL,
  dt_prevista_devolucao date NOT NULL,
  dt_devolucao date DEFAULT NULL,
  hora time(0) DEFAULT NULL,
  CONSTRAINT fk_emprestimo_usuario1_idx FOREIGN KEY(id_usuario)
    REFERENCES TblUsuario(id_usuario),
  CONSTRAINT fk_emprestimo_exemplar1 FOREIGN KEY(id_exemplar)
	REFERENCES TblExemplar(id_exemplar)

  --KEY fk_emprestimo_usuario1_idx (id_usuario),
  --KEY fk_emprestimo_exemplar1 (id_exemplar)
)
END


--
-- Extraindo dados da tabela TblEmprestimo
--

INSERT INTO TblEmprestimo (id_exemplar, id_usuario, dt_emprestimo, dt_prevista_devolucao, dt_devolucao, hora) VALUES
(19, 12, '2004-09-22', '2004-10-02', '2004-10-02', '12:14:23'),
(20, 14, '1998-03-23', '1998-04-02', '1998-04-02', '17:42:46'),
(21, 12, '1990-08-26', '1990-09-05', '1990-09-05', '10:02:07'),
(22, 8, '2018-11-27', '2018-12-07', '2018-12-07', '09:43:58'),
(23, 15, '1990-03-21', '1990-03-31', '1990-04-01', '16:08:10'),
(1, 12, '2009-01-14', '2009-01-24', '2009-01-24', '09:48:24'),
(25, 4, '2009-10-28', '2009-11-07', '2009-11-07', '16:31:50'),
(11, 3, '2002-02-21', '2002-03-03', '2002-03-03', '09:34:01'),
(5, 12, '2019-04-14', '2019-04-24', '2019-04-24', '11:13:45'),
(19, 11, '1994-10-26', '1994-11-05', '1994-11-05', '14:57:32'),
(4, 7, '2020-02-15', '2020-02-25', '2020-02-25', '09:16:38'),
(7, 12, '2017-04-08', '2017-04-18', '2017-04-18', '12:23:41'),
(19, 4, '1990-07-07', '1990-07-17', '1990-07-17', '09:03:01'),
(19, 1, '2006-10-08', '2006-10-18', '2006-10-18', '09:35:03'),
(12, 12, '2021-05-11', '2021-05-21', NULL, NULL),
(13, 7, '1990-12-22', '1991-01-01', '1991-01-01', '08:35:41'),
(15, 6, '2010-05-09', '2010-05-19', '2010-05-19', '11:42:36'),
(8, 12, '1999-06-05', '1999-06-15', '1999-06-15', '10:41:00'),
(15, 5, '2004-03-26', '2004-04-05', '2004-04-05', '17:46:41'),
(19, 12, '2021-04-09', '2021-04-19', '2021-04-19', '16:00:31'),
(12, 6, '2021-05-03', '2021-05-13', '2021-05-17', '15:05:08'),
(25, 5, '1991-11-22', '1991-12-02', '1991-12-02', '08:24:31'),
(16, 1, '1994-12-22', '1995-01-01', '1995-01-01', '09:48:41'),
(19, 4, '2016-07-23', '2016-08-02', '2016-08-02', '10:00:34'),
(33, 8, '2004-04-28', '2004-05-08', '2004-05-08', '13:51:09'),
(8, 9, '1995-08-08', '1995-08-18', '1995-08-18', '16:11:16'),
(33, 9, '1992-08-20', '1992-08-30', '1992-08-30', '08:15:47'),
(27, 7, '2012-04-27', '2012-05-07', '2012-05-07', '12:50:38'),
(19, 8, '2021-03-14', '2021-03-24', '2021-03-24', '14:28:05'),
(34, 11, '1996-06-09', '1996-06-19', '1996-06-19', '15:22:56'),
(18, 15, '2006-09-16', '2006-09-26', '2006-09-26', '14:08:13'),
(6, 15, '2013-09-05', '2013-09-15', '2013-09-15', '12:45:43'),
(19, 17, '1991-06-21', '1991-07-01', '1991-07-01', '14:50:11'),
(3, 11, '1997-04-17', '1997-04-27', '1997-04-27', '17:59:59'),
(5, 10, '2012-09-21', '2012-10-01', '2012-10-01', '08:55:46');
GO

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
