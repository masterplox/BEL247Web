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
RUN flutter build web --release

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

# Copy build output to Nginx web root
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 (Render expects this)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
