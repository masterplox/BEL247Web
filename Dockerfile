FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y curl unzip git xz-utils zip libglu1-mesa

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable Flutter web
RUN flutter config --enable-web

# Pre-download dependencies
WORKDIR /app
COPY . .
RUN flutter pub get

# Build the web app
RUN flutter build web

# Serve with a simple web server
RUN apt-get install -y nginx
RUN cp -r build/web/* /var/www/html/

CMD ["nginx", "-g", "daemon off;"]
