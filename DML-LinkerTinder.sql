INSERT INTO enderecos (cep, cidade, estado) VALUES
    ('01310100', 'São Paulo',      'SP'),
    ('20040020', 'Rio de Janeiro', 'RJ'),
    ('30130010', 'Belo Horizonte', 'MG'),
    ('80010010', 'Curitiba',       'PR'),
    ('90010280', 'Porto Alegre',   'RS');

INSERT INTO candidatos (nome, sobrenome, email, cpf, data_nasc, descricao, senha, cep) VALUES
    ('Sandubinha', 'Silva',    'sandubinha@email.com', '11122233344', '1998-03-15', 'Dev apaixonado por Groovy e Spring.',   'senha123', '01310100'),
    ('Fernanda',   'Costa',   'fernanda@email.com',   '22233344455', '1995-07-22', 'Especialista em dados e Python.',        'senha123', '20040020'),
    ('Lucas',      'Mendes',  'lucas@email.com',      '33344455566', '2000-01-10', 'Frontend Angular e React.',             'senha123', '30130010'),
    ('Juliana',    'Rocha',   'juliana@email.com',     '44455566677', '1997-11-05', 'Engenheira de software, foco em Java.', 'senha123', '80010010'),
    ('Rafael',     'Pereira', 'rafael@email.com',      '55566677788', '1993-09-30', 'DevOps e infraestrutura cloud.',        'senha123', '90010280');

INSERT INTO empresas (nome, cnpj, email, descricao, senha, cep) VALUES
    ('Pastelsoft',     '11222333000181', 'rh@pastelsoft.com',  'ERPs para restaurantes em Spring + Angular.', 'empresa123', '01310100'),
    ('TechBurger',     '22333444000192', 'rh@techburger.com',  'Soluções mobile-first.',                      'empresa123', '20040020'),
    ('CloudFrango',    '33444555000103', 'rh@cloudfrango.com', 'Infraestrutura e DevOps.',                    'empresa123', '30130010'),
    ('DataEsfiha',     '44555666000114', 'rh@dataesfiha.com',  'Análise de dados e BI.',                      'empresa123', '80010010'),
    ('StartupCoxinha', '55666777000125', 'rh@coxinha.com',     'Fintech de pagamentos digitais.',             'empresa123', '90010280');

INSERT INTO competencias (nome) VALUES
    ('Java'), ('Groovy'), ('Spring'), ('Angular'), ('React'),
    ('Python'), ('DevOps'), ('PostgreSQL'), ('Docker'), ('AWS');

INSERT INTO candidato_competencias (candidato_id, competencia_id) VALUES
    (1, 2),(1, 3),(1, 8),
    (2, 6),(2, 8),
    (3, 4),(3, 5),
    (4, 1),(4, 3),
    (5, 7),(5, 9),(5, 10);

INSERT INTO vagas (empresa_id, titulo, descricao, cep) VALUES
    (1, 'Dev Backend Groovy',   'Vaga para dev backend com Groovy e Spring.', '01310100'),
    (1, 'Dev Frontend Angular', 'Vaga para dev frontend Angular.',            '01310100'),
    (2, 'Dev Mobile React',     'Desenvolvimento de apps com React Native.',  '20040020'),
    (3, 'Engenheiro DevOps',    'Infraestrutura Docker e AWS.',               '30130010'),
    (4, 'Analista de Dados',    'Análise com Python e PostgreSQL.',           '80010010');

INSERT INTO vaga_competencias (vaga_id, competencia_id) VALUES
    (1, 2),(1, 3),(1, 8),
    (2, 4),
    (3, 5),
    (4, 7),(4, 9),(4, 10),
    (5, 6),(5, 8);

INSERT INTO curtidas_candidato (candidato_id, vaga_id) VALUES
    (1, 1), (2, 5), (3, 2), (4, 1), (5, 4);

INSERT INTO curtidas_empresa (empresa_id, candidato_id, vaga_id) VALUES
    (1, 1, 1),
    (4, 2, 5),
    (1, 3, 2),
    (3, 5, 4);

INSERT INTO matches (candidato_id, empresa_id, vaga_id) VALUES
    (1, 1, 1),
    (2, 4, 5),
    (3, 1, 2),
    (5, 3, 4);