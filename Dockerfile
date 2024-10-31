# 빌드 스테이지
FROM node:alpine3.18 as build

# 작업 디렉토리 설정
WORKDIR /app

# package.json 파일 복사 및 의존성 설치 (생산 의존성만 설치)
COPY package.json package-lock.json . # package-lock.json을 포함해 의존성 문제 방지
RUN npm install --only=production && npm cache clean --force

# 나머지 소스코드 복사 및 빌드
COPY . .
RUN npm run build

# 최종 실행 이미지 (Node.js 기반)
FROM node:alpine3.18

# 작업 디렉토리 설정
WORKDIR /app

# 빌드된 파일과 node_modules 복사
COPY --from=build /app/build .           # 빌드된 파일 복사
COPY --from=build /app/node_modules ./node_modules  # node_modules 복사
COPY package.json .                      # package.json 복사

# 포트 설정
EXPOSE 3000

# 애플리케이션 실행
CMD ["npm", "start"]
