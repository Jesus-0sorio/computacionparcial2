FROM node:18 AS build

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist/index.html /usr/share/nginx/html
COPY --from=build /app/dist/assets/ /usr/share/nginx/html/todo-react-ts/assets/
COPY --from=build /app/dist/vite.svg /usr/share/nginx/html/todo-react-ts

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]