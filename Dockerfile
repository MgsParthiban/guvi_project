# Use a lightweight web server for serving static files
FROM nginx:alpine

# Copy the built files to Nginx's default public directory
COPY ./build /usr/share/nginx/html

# Expose the port Nginx listens on (default is 80)
EXPOSE 80

# Command to start Nginx
CMD ["nginx", "-g", "daemon off;"]

