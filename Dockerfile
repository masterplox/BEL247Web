# ---------- Stage 1: Build Flutter Web App ----------
# Use prebuilt Flutter image (includes SDK, Dart, Gradle, fonts, etc.)
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy your Flutter project
COPY . .

# Enable Flutter web (usually already enabled)
RUN flutter config --enable-web

# Get dependencies
RUN flutter pub get

# Build the Flutter web release
RUN flutter build web --release \
--dart-define=API_BASE_URL=$API_BASE_URL \
--dart-define=USE_MOCK=$USE_MOCK \
--dart-define=ENCRYPTION_KEY=$ENCRYPTION_KEY \
--dart-define=ENVIRONMENT=$ENVIRONMENT \
--dart-define=MOCK_API_BASE_URL=$MOCK_API_BASE_URL \
--dart-define=PROD_API_BASE_URL=$PROD_API_BASE_URL \
--dart-define=JWT_ACCESS_TOKEN_DURATION=$JWT_ACCESS_TOKEN_DURATION \
--dart-define=JWT_REFRESH_TOKEN_DURATION=$JWT_REFRESH_TOKEN_DURATION \
--dart-define=APP_NAME=$APP_NAME \
--dart-define=APP_VERSION=$APP_VERSION


# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

# Copy build output to Nginx web root
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 (Render expects this)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
