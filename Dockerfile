# Usa imagem oficial do Bun para evitar falhas de instalação
FROM oven/bun:1.1.20

# Define diretório de trabalho
WORKDIR /app

# Copia todos os arquivos para dentro da imagem
COPY . .

# 🧠 Instala dependências de build necessárias para "isolated-vm"
RUN apt-get update && apt-get install -y python3 make g++ && ln -sf python3 /usr/bin/python

# Instala dependências e constrói o projeto
RUN bun install
RUN bun run --filter=builder build

# Comando padrão ao iniciar o container
CMD ["bun", "run", "--filter=builder", "start"]
