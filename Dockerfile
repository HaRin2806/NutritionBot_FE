# Dockerfile
FROM node:23 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve with nginx
FROM nginx:alpine

# Copy build output
COPY --from=build /app/dist /usr/share/nginx/html

# Copy nginx config as template
COPY nginx.conf /etc/nginx/templates/default.conf.template

# Expose the PORT environment variable (Railway sẽ set giá trị này)
EXPOSE $PORT

CMD ["nginx", "-g", "daemon off;"]