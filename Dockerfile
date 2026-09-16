FROM node:22-slim

RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-venv ca-certificates \
  && python3 -m venv /opt/skillbridge-venv \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN /opt/skillbridge-venv/bin/pip install --no-cache-dir -r requirements.txt \
  && npm install -g corepack@latest \
  && corepack pnpm install \
  && corepack pnpm run build

ENV PATH="/opt/skillbridge-venv/bin:${PATH}"
ENV NODE_ENV=production
EXPOSE 3000
CMD ["node", "dist/index.js"]
