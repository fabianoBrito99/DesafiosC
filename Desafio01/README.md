# Desafio 01 de Risco de Crédito – Cálculo da Perda Esperada (PE)

Este projeto tem como objetivo aplicar técnicas de análise estatística e modelagem preditiva para apoiar a gestão de risco de crédito, com foco no cálculo da **Perda Esperada (PE = PD × EAD × LGD)**.

---

## Parte 1: Análise Exploratória de Dados (EDA)

- Avaliação de qualidade dos dados: identificamos ausência de valores nulos e padronizamos tipos.
- Análise de distribuição das variáveis principais: idade, renda, score, valor contratado, prazo.
- Segmentos de maior risco foram identificados com base na **distribuição de inadimplência** por:
  - Produto 
  - Região 
  - Faixa de Score
  - Faixa de Renda e Profissão

---

## Parte 2: Construção de Variáveis-Chave

### PD – Probability of Default
- O critério de default adotado foi: **atraso ≥ 90 dias**
- A PD foi calculada por faixa de score, produto, região, faixa de renda e profissão
- As variáveis explicativas mais significativas foram: score de crédito, produto, profissão e renda

### EAD – Exposure at Default
- Já preenchido em caso de default
- Análise da distribuição foi feita e sugeriu-se que valores contratados e tipo de produto influenciam

### LGD – Loss Given Default
- Pré-calculada como `perda_real / ead`
- Segmentada por tipo de produto, profissão, renda e posse de imóvel
- Profissões e renda mais baixas tendem a ter maiores perdas

---

## Parte 3: Cálculo da Perda Esperada (PE)

- A PE foi calculada para diferentes segmentações: por score, produto, região, renda e profissão
- Identificadas as **10 maiores operações em termos de PE**
- Essas operações mostram alto EAD, alto LGD e PD moderada, concentradas em produtos como Cheque Especial e regiões Norte/Sudeste

---

## Parte 4: Modelos Preditivos de PD

### Modelos Aplicados:
- **Regressão Logística** (com variáveis numéricas e categóricas)
- **Árvore de Decisão**
- **Regressão Linear**: 
- **Random Forest**: 

### Regressão Linear

Foi utilizada para investigar a relação entre variáveis contínuas, como:

- `idade_cliente` vs. `score_credito`: para entender se clientes mais velhos têm maior score
- `idade_cliente` vs. `pe_score`: para verificar se a perda esperada é mais alta em clientes mais jovens

Estudando mais a fundo vi que a Regressão Linear é útil para **explicar tendência geral** e correlação entre variáveis contínuas.

---

### Random Forest

Foi utilizada para prever a probabilidade de inadimplência com base em:

- `idade_cliente`
- `score_credito`

A Random Forest foi escolhida por:

- Capturar relações **não lineares** entre idade/score e risco
- Identificar **regiões de risco** com maior precisão que a regressão logística
- Lidar bem com **desequilíbrio de classes** (`class_weight='balanced'`)

Por fim gerei graficos de **dispersão colorida** mostrando a probabilidade prevista de inadimplência por idade e por score de crédito. Facilitando a interpletação dos dados e tomadas de decisão.

### Justificativa das variáveis utilizadas:
- `score_credito`, `renda_cliente`, `idade_cliente`, `tempo_emprego`, `numero_dependentes`
- `produto`, `regiao`, `profissao`, `possui_imovel`, `possui_veiculo`

#### VARIÁVEIS NUMÉRICAS:
- **score_credito**      → Reflete risco de crédito do cliente (diretamente ligado à chance de inadimplência)
- **renda_cliente**       → Capacidade de pagamento
- **idade_cliente**       → Clientes mais jovens ou muito idosos podem ter padrões de risco diferentes
- **tempo_emprego**      → Estabilidade financeira
- **numero_dependentes**  → Pressão sobre a renda

#### VARIÁVEIS CATEGÓRICAS:
- **produto**             → Produtos mais arriscados (ex: cheque especial)
- **regiao**           → Diferenças socioeconômicas por região
- **profissao**           → Alguns empregos têm maior estabilidade
- **possui_imovel**       → Pode ser indicativo de patrimônio (menor risco)
- **possui_veiculo**      → Pode ajudar como proxy de renda ou estabilidade

### Avaliação dos Modelos:
- AUC, Precisão, Recall e Matriz de Confusão
- Modelos simples, mas com resultados interpretáveis
- Random Forest apresentou curva de risco visual interessante por idade e por score

---

## Parte 5: Conclusões e Recomendações

### Quais perfis de clientes são mais arriscados? 

Perfis mais arriscados com base na PE e gráficos:

- Score de crédito baixo ou médio
- Clientes com LGD > 0.9


Há produtos/regiões que concentram mais inadimplência? 
- Produtos: Cheque Especial, Cartão, Crédito Pessoal
- Regiões com mais PE: Norte e Sudeste

### Que recomendações você daria para política de crédito?

    1. Ajustar limites e taxas para produtos mais arriscados.
    
    2. Personalizar políticas por região.
    
    3. Exigir garantias reais em operações de alto risco.
    
    4. Criar alertas para operações com:
        - EAD alto + LGD alto
        - Score baixo ou médio
        - Produtos rotativos

Reavaliar limites e garantias para clientes com perfis semelhantes aos inadimplentes

### Oportunidades de Melhoria na Base de Dados

- Se o cliente já deu default antes(seria bom para ter um historico de default)
- Quantidade total de parcelas pagas em atraso
- Tempo como cliente da instituição