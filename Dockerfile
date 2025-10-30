# ---------- Stage 1: Build Flutter Web App ----------
    FROM ghcr.io/cirruslabs/flutter:stable AS build

    # Install git (often needed for Flutter dependencies)
    RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
    
    # Set working directory inside the container
    WORKDIR /app
    
    # Copy pubspec files first for better caching
    COPY pubspec.* ./
    
    # Get dependencies
    RUN flutter pub get
    
    # Copy the rest of the project
    COPY . .
    
    # Ensure Flutter web is enabled
    RUN flutter config --enable-web
    
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