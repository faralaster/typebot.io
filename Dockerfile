# Etapa 1: Build monorepo
FROM node:20 AS builder
WORKDIR /app

# Copia todos os arquivos
COPY . .

# Dependências básicas
RUN apt-get update && apt-get install -y python3 make g++

# Instala bun
RUN npm install -g bun

# Instala dependências do monorepo
RUN bun install

# Builda todos os pacotes
RUN npx turbo run build --filter=builder --no-cache

# Etapa 2: Build do builder (Next.js)
WORKDIR /app/apps/builder
RUN bun run build


# Etapa 3: Runtime
FROM oven/bun:1
WORKDIR /app

COPY --from=builder /app /app

WORKDIR /app/apps/builder
CMD ["bun", "run", "start"]
