# ---------- Stage 1: Build Flutter Web App ----------
# Use a prebuilt Flutter image that includes the SDK and dependencies
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory inside the container
WORKDIR /app

# Copy all Flutter project files into the container
COPY . .

# Ensure Flutter web is enabled (just in case)
RUN flutter config --enable-web

# Get dependencies
RUN flutter pub get

# Build the Flutter web release
RUN flutter build web --release

# ---------- Stage 2: Serve Using Nginx ----------
FROM nginx:alpine

# Copy the compiled Flutter web app from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 for Render
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
