CREATE TABLE enderecos (
    cep    CHAR(8)     PRIMARY KEY,
    cidade VARCHAR(80) NOT NULL,
    estado CHAR(2)     NOT NULL,
    pais   VARCHAR(60) NOT NULL DEFAULT 'Brasil'
);

CREATE TABLE candidatos (
    id        SERIAL       PRIMARY KEY,
    nome      VARCHAR(80)  NOT NULL,
    sobrenome VARCHAR(80)  NOT NULL,
    email     VARCHAR(120) NOT NULL UNIQUE,
    cpf       CHAR(11)     NOT NULL UNIQUE,
    data_nasc DATE         NOT NULL,
    descricao TEXT,
    senha     VARCHAR(255) NOT NULL,
    cep       CHAR(8)      NOT NULL REFERENCES enderecos(cep)
);

CREATE TABLE empresas (
    id        SERIAL       PRIMARY KEY,
    nome      VARCHAR(120) NOT NULL,
    cnpj      CHAR(14)     NOT NULL UNIQUE,
    email     VARCHAR(120) NOT NULL UNIQUE,
    descricao TEXT,
    senha     VARCHAR(255) NOT NULL,
    cep       CHAR(8)      NOT NULL REFERENCES enderecos(cep)
);

CREATE TABLE competencias (
    id   SERIAL      PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE candidato_competencias (
    candidato_id   INT NOT NULL REFERENCES candidatos(id)  ON DELETE CASCADE,
    competencia_id INT NOT NULL REFERENCES competencias(id) ON DELETE CASCADE,
    PRIMARY KEY (candidato_id, competencia_id)
);

CREATE TABLE vagas (
    id         SERIAL       PRIMARY KEY,
    empresa_id INT          NOT NULL REFERENCES empresas(id) ON DELETE CASCADE,
    titulo     VARCHAR(120) NOT NULL,
    descricao  TEXT,
    cep        CHAR(8)      NOT NULL REFERENCES enderecos(cep)
);

CREATE TABLE vaga_competencias (
    vaga_id        INT NOT NULL REFERENCES vagas(id)        ON DELETE CASCADE,
    competencia_id INT NOT NULL REFERENCES competencias(id) ON DELETE CASCADE,
    PRIMARY KEY (vaga_id, competencia_id)
);


CREATE TABLE curtidas_candidato (
    candidato_id INT       NOT NULL REFERENCES candidatos(id) ON DELETE CASCADE,
    vaga_id      INT       NOT NULL REFERENCES vagas(id)      ON DELETE CASCADE,
    curtido_em   TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (candidato_id, vaga_id)
);

CREATE TABLE curtidas_empresa (
    empresa_id   INT       NOT NULL REFERENCES empresas(id)   ON DELETE CASCADE,
    candidato_id INT       NOT NULL REFERENCES candidatos(id) ON DELETE CASCADE,
    vaga_id      INT       NOT NULL REFERENCES vagas(id)      ON DELETE CASCADE,
    curtido_em   TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (empresa_id, candidato_id, vaga_id)
);

CREATE TABLE matches (
    id           SERIAL    PRIMARY KEY,
    candidato_id INT       NOT NULL REFERENCES candidatos(id) ON DELETE CASCADE,
    empresa_id   INT       NOT NULL REFERENCES empresas(id)   ON DELETE CASCADE,
    vaga_id      INT       NOT NULL REFERENCES vagas(id)      ON DELETE CASCADE,
    matched_em   TIMESTAMP NOT NULL DEFAULT NOW()
);