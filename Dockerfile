# ---------- Stage 1: Build Flutter Web App ----------
# Use prebuilt Flutter image (includes SDK, Dart, Gradle, fonts, etc.)
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy your Flutter project
COPY . .

# Enable Flutter web (usually already enabled)
RUN flutter config --enable-web

# Build-time args. Default /api-proxy uses same-origin proxy (CORS workaround on Render).
ARG API_BASE_URL=/api-proxy
ARG USE_MOCK=false
ARG USE_AMI_MOCK=false
ARG ENCRYPTION_KEY=bel247_encryption_key_32_chars
ARG ENVIRONMENT=production
ARG MOCK_API_BASE_URL=mock://data
ARG PROD_API_BASE_URL=https://api.bel247.com/v1
ARG JWT_ACCESS_TOKEN_DURATION=15
ARG JWT_REFRESH_TOKEN_DURATION=10080
ARG APP_NAME=BEL247 WebApp
ARG APP_VERSION=1.0.0

# Get dependencies
RUN flutter pub get

# Build the Flutter web release (ARGs above ensure correct API URL when env not passed at build time)
# Quote APP_NAME so "BEL247 WebApp" is not split (Flutter would treat "WebApp" as target file)
RUN flutter build web --release \
  --dart-define=API_BASE_URL="$API_BASE_URL" \
  --dart-define=USE_MOCK="$USE_MOCK" \
  --dart-define=USE_AMI_MOCK="$USE_AMI_MOCK" \
  --dart-define=ENCRYPTION_KEY="$ENCRYPTION_KEY" \
  --dart-define=ENVIRONMENT="$ENVIRONMENT" \
  --dart-define=MOCK_API_BASE_URL="$MOCK_API_BASE_URL" \
  --dart-define=PROD_API_BASE_URL="$PROD_API_BASE_URL" \
  --dart-define=JWT_ACCESS_TOKEN_DURATION="$JWT_ACCESS_TOKEN_DURATION" \
  --dart-define=JWT_REFRESH_TOKEN_DURATION="$JWT_REFRESH_TOKEN_DURATION" \
  --dart-define=APP_NAME="$APP_NAME" \
  --dart-define=APP_VERSION="$APP_VERSION"

# Inject runtime API URL into index.html so the app uses it (Render env / build-time ARG)
RUN sed -i "s|__API_BASE_URL__|$API_BASE_URL|g" /app/build/web/index.html

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

# Copy build output to Nginx web root
COPY --from=build /app/build/web /usr/share/nginx/html

# Nginx config: serves app + proxies /api-proxy/ to real API (CORS workaround)
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (Render expects this)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
