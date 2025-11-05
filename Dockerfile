# Etapa 1: Build com Node
FROM node:20 AS builder
WORKDIR /app

# Copia os arquivos
COPY . .

# Instala dependências do sistema
RUN apt-get update && apt-get install -y python3 make g++

# Instala bun
RUN npm install -g bun

# Vai até o app builder e roda o build
WORKDIR /app/apps/builder
RUN bun install
RUN bun run build


# Etapa 2: Execução com Bun
FROM oven/bun:1
WORKDIR /app

# Copia os arquivos gerados
COPY --from=builder /app /app

WORKDIR /app/apps/builder
CMD ["bun", "run", "start"]
