# 빌드 스테이지
FROM node:alpine3.18 as build

# 작업 디렉토리 설정
WORKDIR /app

# package.json 파일과 의존성 설치 (생산 의존성만 설치)
COPY package.json package-lock.json ./  # 두 파일 모두 복사
RUN npm install --only=production && npm cache clean --force

# 나머지 소스코드 복사 및 빌드
COPY . .
RUN npm run build

# 최종 실행 이미지
FROM node:alpine3.18
WORKDIR /app

# 빌드된 파일, node_modules, package.json 복사
COPY --from=build /app/build .               # 빌드된 파일 복사
COPY --from=build /app/node_modules ./node_modules  # node_modules 복사
COPY --from=build /app/package.json .        # package.json 복사

# 포트 설정 및 애플리케이션 실행
EXPOSE 3000
CMD ["npm", "start"]
