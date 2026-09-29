# ---------- build stage ----------
FROM node:22-slim AS build
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

# Vite bakes VITE_* values in at build time
ARG VITE_SUPABASE_URL
ARG VITE_SUPABASE_PUBLISHABLE_KEY
ARG VITE_SUPABASE_PROJECT_ID
ARG VITE_NETRA_API_URL=http://localhost:8000/predict
ENV VITE_SUPABASE_URL=$VITE_SUPABASE_URL \
    VITE_SUPABASE_PUBLISHABLE_KEY=$VITE_SUPABASE_PUBLISHABLE_KEY \
    VITE_SUPABASE_PROJECT_ID=$VITE_SUPABASE_PROJECT_ID \
    VITE_NETRA_API_URL=$VITE_NETRA_API_URL \
    NITRO_PRESET=node-server

RUN npm run build

# ---------- run stage ----------
FROM node:22-slim
WORKDIR /app
COPY --from=build /app/.output ./.output

ENV PORT=8080 HOST=0.0.0.0 NODE_ENV=production
EXPOSE 8080
CMD ["node", ".output/server/index.mjs"]
