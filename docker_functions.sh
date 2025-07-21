#!/bin/sh

# To include this file: source ~/Dev/bash/docker_functions.sh

# Check Docker is running
# To call function: is_docker_running
is_docker_running() {
  open -a docker
  # Wait until Docker daemon is responsive
  until docker info >/dev/null 2>&1; do
    echo "🕓 Waiting for Docker to be ready..."
    sleep 5
  done
  echo "✅ Docker is ready"
  
  open -a "Docker Desktop" || true
  open "docker-desktop://dashboard" || true
}

# Stop all running containers
# To call function: stop_all_containers
stop_all_containers() {
  echo "⏹️ Stopping all running containers..."
  docker stop $(docker ps -q)

  echo "🧹 Removing all stopped containers..."
  docker rm $(docker ps -aq)

  echo "🕓 Waiting for all containers to be fully stopped..."
  while [ "$(docker ps -q)" ]; do
    sleep 1
  done
  echo "✅ All containers have been stopped and removed"
}

# Check all containers are running
# To call function: check_all_containers_running
check_all_containers_running() {
  # Get list of container IDs
  containers=$(docker-compose ps -q)
  expected=$(echo "$containers" | wc -l | tr -d ' ')

  while true; do
    ready=0
    for id in $containers; do
      status=$(docker inspect -f '{{.State.Status}}' "$id" 2>/dev/null)
      if [[ "$status" == "running" || "$status" == "exited" ]]; then
        ready=$((ready + 1))
      fi
    done

    if [ "$ready" -ge "$expected" ]; then
      echo "✅ All $ready containers are running or exited."
      break
    else
      echo "🕓 Waiting for containers... ($ready/$expected ready)"
      sleep 5
    fi
  done
}

# Wait for Django server to start
# To call function: wait_for_django_server web
wait_for_django_server() {
  container_name="${1:-web}"  # Use first argument, or 'web' if not provided
  container_id=$(docker-compose ps -q "$container_name")
  echo "🕓 Waiting for Django dev server to start..."
  
  while true; do
    if docker logs "$container_id" 2>&1 | grep -q 'Starting development server at https://0.0.0.0:8000/'; then
      echo "✅ Django dev server is running"
      break
    fi
    if docker logs "$container_id" 2>&1 | grep -q 'Development server is running at https://0.0.0.0:8000/'; then
      echo "✅ Django dev server is running"
      break
    fi
    sleep 5
  done
}
