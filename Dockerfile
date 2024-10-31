# 오피셜 노드 이미지
FROM node:alpine3.18 as build

# 작업 디렉토리 설정
WORKDIR /app

# 패키지 파일 현재 디렉토리에 복사
COPY package.json .

# 패키지 설치
RUN npm install

# 나머지 소스코드 복사
COPY . .

# 빌드 없이 개발 서버를 직접 실행 (npm start)
EXPOSE 3000

CMD ["npm", "start"]