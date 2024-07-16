# INSS Discount Application

Este é um projeto de exemplo para calcular o desconto do INSS usando Ruby on Rails. O projeto inclui autenticação de usuário com Devise, testes automatizados com RSpec e está dockerizado para facilitar a configuração e execução.

## Requisitos

- Docker
- Docker Compose

## Configuração

Siga os passos abaixo para configurar e iniciar a aplicação:

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/seu-usuario/inss_discount.git
   cd inss_discount

2. **Crie e inicialize os containers com Docker Compose:**

   ```bash
   docker-compose build
   docker-compose up

3. **Execute as migrações do banco de dados:**
   Em um novo terminal, execute:

   ```bash
   docker-compose run web rake db:create db:migrate

4. **Acesse a aplicação:**

   ```bash
   A aplicação estará disponível em http://localhost:3000

## Testes

1. **Para rodar os testes automatizados, utilize o seguinte comando:**
   ```bash
   docker-compose run web rspec

## Funcionalidades
- Autenticação de Usuário: Utilizando Devise para gerenciar login e logout.
- Cadastro de Proponentes: Criação, leitura, atualização e exclusão de proponentes.
- Cálculo do INSS: Cálculo automático do desconto do INSS baseado no salário do proponente.
- Relatórios e Gráficos: Relatórios agrupados por faixas salariais e gráficos utilizando Chart.js.


