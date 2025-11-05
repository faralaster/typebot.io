# Etapa 1: Build com Node
FROM node:20 AS builder
WORKDIR /app

# Copia o código
COPY . .

# Instala Python e ferramentas (por segurança)
RUN apt-get update && apt-get install -y python3 make g++

# Instala dependências e faz o build
RUN npm install -g bun && bun install && bun run --filter=builder build


# Etapa 2: Execução com Bun
FROM oven/bun:1
WORKDIR /app

# Copia tudo do builder
COPY --from=builder /app /app

# Comando de inicialização
CMD ["bun", "run", "--filter=builder", "start"]
