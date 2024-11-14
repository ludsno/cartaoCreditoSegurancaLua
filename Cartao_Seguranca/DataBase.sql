CREATE DATABASE cartao_seguro;
\c cartao_seguro;

CREATE TABLE cartoes (
    id SERIAL PRIMARY KEY,
    numero VARCHAR(16) NOT NULL UNIQUE,
    usuario_id INTEGER NOT NULL,
    limite DECIMAL(10, 2) DEFAULT 1000.00,
    bloqueado BOOLEAN DEFAULT FALSE,
    token_autenticacao VARCHAR(6)
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    senha_hash VARCHAR(255) NOT NULL
);
