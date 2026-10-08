# Use the official Nginx lightweight image
FROM nginx:alpine

# Copy the local index.html file to Nginx's default public directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to access the container externally
EXPOSE 80
