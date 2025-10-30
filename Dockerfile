# ---------- Stage 1: Build Flutter Web App ----------
# Use an official Flutter image that already has the SDK preinstalled
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set the working directory
WORKDIR /app

# Copy the Flutter project files
COPY . .

# Make sure web is enabled (just in case)
RUN flutter config --enable-web

# Fetch dependencies
RUN flutter pub get

# Build the Flutter web release
RUN flutter build web --release

# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

# Copy the built web assets to the nginx html directory
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
