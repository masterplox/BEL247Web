FROM dart:stable AS build

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable /flutter
ENV PATH="/flutter/bin:${PATH}"

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Verify Flutter installation
RUN flutter doctor -v

WORKDIR /app

COPY pubspec.* ./
RUN flutter pub get

COPY . .

RUN flutter config --enable-web
RUN flutter build web --release

# ---------- Stage 2: Serve ----------
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]