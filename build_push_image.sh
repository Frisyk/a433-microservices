#!/bin/bash

# Variabel untuk GitHub Packages username dan nama image
github_username="frisyk" # Sesuaikan dengan username GitHub Anda
image_name="item-app"
project="a433-microservices"
tag="v1"
github_repo="ghcr.io/$github_username/$project"

# Build Docker image dari Dockerfile
docker build -t $image_name:$tag .

# Lihat daftar image lokal
docker images

# Menamai ulang image agar sesuai dengan format GitHub Packages
docker tag $image_name:$tag $github_repo:$tag

# Login ke GitHub Packages menggunakan Personal Access Token (PAT)
cat ./pass.txt | docker login ghcr.io --username $github_username --password-stdin

# Push image ke GitHub Packages
docker push $github_repo:$tag

# Menjalankan container menggunakan Docker Compose dan menyimpan log ke log.txt
docker-compose up -d > log.txt 2>&1

# Menampilkan log secara real-time (opsional)
docker-compose logs -f
