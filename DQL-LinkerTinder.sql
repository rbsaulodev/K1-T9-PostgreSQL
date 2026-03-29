-- 1. Candidatos com suas competências
SELECT c.nome, c.sobrenome, STRING_AGG(comp.nome, ', ') AS competencias
FROM candidatos c
JOIN candidato_competencias cc ON cc.candidato_id = c.id
JOIN competencias comp ON comp.id = cc.competencia_id
GROUP BY c.id;

-- 2. Vagas com competências exigidas e cidade
SELECT v.titulo, em.nome AS empresa, STRING_AGG(comp.nome, ', ') AS competencias, en.cidade
FROM vagas v
JOIN empresas em          ON em.id  = v.empresa_id
JOIN enderecos en         ON en.cep = v.cep
JOIN vaga_competencias vc ON vc.vaga_id = v.id
JOIN competencias comp    ON comp.id = vc.competencia_id
GROUP BY v.id, em.nome, en.cidade;

-- 3. Matches existentes
SELECT c.nome AS candidato, e.nome AS empresa, v.titulo AS vaga, m.matched_em
FROM matches m
JOIN candidatos c ON c.id = m.candidato_id
JOIN empresas   e ON e.id = m.empresa_id
JOIN vagas      v ON v.id = m.vaga_id;

-- Testa: candidatos.cep > enderecos.cep
SELECT c.nome, c.sobrenome, c.email, e.cidade, e.estado, e.pais
FROM candidatos c
JOIN enderecos e ON e.cep = c.cep;

-- 2. empresas → enderecos
-- Testa: empresas.cep > enderecos.cep
SELECT em.nome AS empresa, em.cnpj, en.cidade, en.estado
FROM empresas em
JOIN enderecos en ON en.cep = em.cep;

-- 3. candidatos ↔ competencias (N:N)
-- Testa: candidato_competencias → candidatos + competencias
SELECT c.nome, c.sobrenome, STRING_AGG(comp.nome, ', ') AS competencias
FROM candidatos c
JOIN candidato_competencias cc   ON cc.candidato_id = c.id
JOIN competencias comp           ON comp.id = cc.competencia_id
GROUP BY c.id, c.nome, c.sobrenome;

-- 4. vagas → empresas → enderecos (corrigido: alias "en" no lugar de "end")
-- Testa: vagas.empresa_id > empresas.id e vagas.cep > enderecos.cep
SELECT v.titulo, em.nome AS empresa, en.cidade, en.estado
FROM vagas v
JOIN empresas  em ON em.id  = v.empresa_id
JOIN enderecos en ON en.cep = v.cep;

-- 5. vagas ↔ competencias (N:N)
-- Testa: vaga_competencias → vagas + competencias
SELECT v.titulo, STRING_AGG(comp.nome, ', ') AS competencias_exigidas
FROM vagas v
JOIN vaga_competencias vc ON vc.vaga_id = v.id
JOIN competencias comp    ON comp.id = vc.competencia_id
GROUP BY v.id, v.titulo;

-- 6. curtidas_candidato → candidatos + vagas
-- Testa: curtidas_candidato.candidato_id > candidatos e .vaga_id > vagas
SELECT c.nome AS candidato, v.titulo AS vaga_curtida, cc.curtido_em
FROM curtidas_candidato cc
JOIN candidatos c ON c.id = cc.candidato_id
JOIN vagas      v ON v.id = cc.vaga_id;

-- 7. curtidas_empresa → empresas + candidatos + vagas
-- Testa: curtidas_empresa → empresas, candidatos e vagas
SELECT em.nome AS empresa, c.nome AS candidato, v.titulo AS vaga, ce.curtido_em
FROM curtidas_empresa ce
JOIN empresas   em ON em.id = ce.empresa_id
JOIN candidatos c  ON c.id  = ce.candidato_id
JOIN vagas      v  ON v.id  = ce.vaga_id;

-- 8. matches → candidatos + empresas + vagas
-- Testa: matches → candidatos, empresas e vagas
SELECT c.nome AS candidato, em.nome AS empresa, v.titulo AS vaga, m.matched_em
FROM matches m
JOIN candidatos c  ON c.id  = m.candidato_id
JOIN empresas   em ON em.id = m.empresa_id
JOIN vagas      v  ON v.id  = m.vaga_id;

-- 9. visão completa: candidato + competencias vs vaga + competencias (base do match)
-- Testa todas as tabelas de uma vez
SELECT
    c.nome                                    AS candidato,
    STRING_AGG(DISTINCT cc_comp.nome, ', ')   AS competencias_candidato,
    v.titulo                                  AS vaga,
    STRING_AGG(DISTINCT vc_comp.nome, ', ')   AS competencias_vaga,
    em.nome                                   AS empresa
FROM candidatos c
JOIN candidato_competencias cc ON cc.candidato_id = c.id
JOIN competencias cc_comp      ON cc_comp.id = cc.competencia_id
JOIN curtidas_candidato cur    ON cur.candidato_id = c.id
JOIN vagas v                   ON v.id = cur.vaga_id
JOIN vaga_competencias vcj     ON vcj.vaga_id = v.id
JOIN competencias vc_comp      ON vc_comp.id = vcj.competencia_id
JOIN empresas em               ON em.id = v.empresa_id
GROUP BY c.id, c.nome, v.id, v.titulo, em.nome;
