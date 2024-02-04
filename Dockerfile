# Production Build

# Stage 1: Build react client
FROM node:18-alpine as frontend

# Working directory be app
WORKDIR /usr/app/frontend/

COPY frontend/package*.json ./

# Install dependencies
RUN npm install

# copy local files to app folder
COPY frontend/ ./
RUN ls

RUN npm run build

# Stage 2 : Build Server

FROM node:18-alpine

WORKDIR /usr/src/app/
COPY --from=frontend /usr/app/frontend/dist/ ./frontend/dist/
RUN ls

WORKDIR /usr/src/app/backend/
COPY backend/package*.json ./
RUN npm install -qy
COPY backend/ ./

EXPOSE 3000

CMD ["npm", "start"]