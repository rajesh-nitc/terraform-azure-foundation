# Base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev

ENV REACT_APP_APIM_URL=http://localhost:3500

# Copy the rest of the app's source code
COPY . .

# Build the React app
RUN npm run build

# Expose the port on which the app will run
EXPOSE 3000

# Start the app
CMD ["npm", "start"]