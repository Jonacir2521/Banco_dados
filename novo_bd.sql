-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 16-Abr-2021 às 22:13
-- Versão do servidor: 10.4.18-MariaDB
-- versão do PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `novo_bd`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `alocacao`
--

CREATE TABLE `alocacao` (
  `aloca_id` int(10) UNSIGNED NOT NULL,
  `func_id` int(10) UNSIGNED NOT NULL,
  `proj_sigla` char(3) NOT NULL,
  `aloca_inicio` datetime DEFAULT current_timestamp(),
  `aloca_fim` datetime DEFAULT NULL
) ;

--
-- Extraindo dados da tabela `alocacao`
--

INSERT INTO `alocacao` (`aloca_id`, `func_id`, `proj_sigla`, `aloca_inicio`, `aloca_fim`) VALUES
(1, 1, 'XYZ', '2019-01-01 00:00:00', NULL),
(2, 2, '123', '2020-01-01 00:00:00', NULL),
(3, 3, 'XYZ', '2019-01-01 00:00:00', '2020-01-01 00:00:00'),
(4, 4, 'PQR', '2018-01-01 00:00:00', NULL),
(5, 5, '123', '2019-01-01 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamento`
--

CREATE TABLE `departamento` (
  `depto_id` int(10) UNSIGNED NOT NULL,
  `depto_nome` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `departamento`
--

INSERT INTO `departamento` (`depto_id`, `depto_nome`) VALUES
(1, 'COMPRAS'),
(2, 'VENDAS'),
(3, 'CONTABILIDADE'),
(4, 'INFORMÁTICA');

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionario`
--

CREATE TABLE `funcionario` (
  `func_id` int(10) UNSIGNED NOT NULL,
  `func_nome` varchar(100) NOT NULL,
  `func_nasc` date NOT NULL,
  `func_sexo` enum('F','M') DEFAULT NULL,
  `func_salario` decimal(12,2) UNSIGNED DEFAULT NULL,
  `depto_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `funcionario`
--

INSERT INTO `funcionario` (`func_id`, `func_nome`, `func_nasc`, `func_sexo`, `func_salario`, `depto_id`) VALUES
(1, 'JOSÉ DA SILVA', '2000-01-01', 'M', '5000.00', 1),
(2, 'MARIA DA SILVA', '1987-02-01', 'F', '8000.50', 1),
(3, 'JOÃO DA SILVA', '1970-01-01', 'M', '5500.50', 2),
(4, 'ANTONIO ALC NTARA', '2000-03-01', 'M', '6500.00', 2),
(5, 'MARIA DE SOUZA', '1990-05-01', 'F', '6500.00', NULL),
(6, 'LUIZ MOURA', '1960-05-01', 'M', '7500.00', 4),
(7, 'JOANA OLIVEIRA', '1975-02-01', 'F', '9000.70', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `projeto`
--

CREATE TABLE `projeto` (
  `proj_sigla` char(3) NOT NULL,
  `proj_nome` varchar(45) NOT NULL,
  `proj_interno` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `projeto`
--

INSERT INTO `projeto` (`proj_sigla`, `proj_nome`, `proj_interno`) VALUES
('123', 'Projeto 123', 0),
('ABC', 'Projeto ABC', 0),
('PQR', 'Projeto PQR', 1),
('XYZ', 'Projeto XYZ', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alocacao`
--
ALTER TABLE `alocacao`
  ADD PRIMARY KEY (`aloca_id`),
  ADD KEY `aloca_proj_idx` (`proj_sigla`),
  ADD KEY `aloca_func_idx` (`func_id`);

--
-- Índices para tabela `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`depto_id`);

--
-- Índices para tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`func_id`),
  ADD KEY `func_depto_idx` (`depto_id`);

--
-- Índices para tabela `projeto`
--
ALTER TABLE `projeto`
  ADD PRIMARY KEY (`proj_sigla`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alocacao`
--
ALTER TABLE `alocacao`
  MODIFY `aloca_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `departamento`
--
ALTER TABLE `departamento`
  MODIFY `depto_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `func_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `alocacao`
--
ALTER TABLE `alocacao`
  ADD CONSTRAINT `aloca_func_fk` FOREIGN KEY (`func_id`) REFERENCES `funcionario` (`func_id`),
  ADD CONSTRAINT `aloca_proj_fk` FOREIGN KEY (`proj_sigla`) REFERENCES `projeto` (`proj_sigla`);

--
-- Limitadores para a tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `func_depto_fk` FOREIGN KEY (`depto_id`) REFERENCES `departamento` (`depto_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
