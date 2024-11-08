# 使用 Node.js 镜像来构建 Vue 项目
FROM node:12-alpine AS build-stage

# 设置工作目录
WORKDIR /app

# 将 package.json 和 package-lock.json 复制到容器中
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 将项目的其他文件复制到容器中
COPY  . .

# 设置默认的 BASE_API 值
ARG BASE_API=http://172.18.75.142:8201
ENV BASE_API=${BASE_API}

# 构建 Vue 项目
RUN npm run build

# 使用 Nginx 镜像来部署生成的静态文件
FROM nginx:alpine

# 将构建阶段生成的静态文件复制到 Nginx 默认静态文件目录
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 暴露端口
EXPOSE 8090

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
