# Use a imagem oficial do Ruby
FROM ruby:3.2.0

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Define o diretório de trabalho
WORKDIR /app

# Copia o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instala as gems
RUN bundle install

# Copia o restante do código da aplicação
COPY . .

# Expõe a porta que a aplicação vai usar
EXPOSE 3000

# Comando para iniciar o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]
