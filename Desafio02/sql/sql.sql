CREATE DATABASE Engenharia_credisis;
use Engenharia_credisis;

CREATE TABLE dim_clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    data_nascimento DATE,
    renda_mensal DECIMAL(10,2),
    regiao VARCHAR(20),
    data_carga DATETIME
);

CREATE TABLE fato_contratos (
    id_contrato INT PRIMARY KEY,
    id_cliente INT,
    valor_contrato DECIMAL(12,2),
    saldo_devedor DECIMAL(12,2),
    data_contratacao DATE,
    prazo_meses INT,
    status_contrato VARCHAR(20),
    data_carga DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES dim_clientes(id_cliente)
);

CREATE TABLE fato_transacoes (
    id_cliente INT,
    ano_mes DATE,
    tipo_transacao VARCHAR(20),
    valor_total DECIMAL(12,2),
    qtd_transacoes INT,
    validade_inicio DATETIME,
    validade_fim DATETIME,
    versao INT,
    PRIMARY KEY (id_cliente, ano_mes, tipo_transacao, versao),
    FOREIGN KEY (id_cliente) REFERENCES dim_clientes(id_cliente)
);

SELECT * from fato_transacoes;
