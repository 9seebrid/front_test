# 오피셜 노드 이미지
FROM node:alpine3.18 as build

# 작업 디렉토리 설정
WORKDIR /app

# 패키지 파일 현재 디렉토리에 복사
COPY package.json .

# npm 캐시를 사용해 설치 속도를 높이고 잠금 문제 방지
RUN npm install --no-fund --no-audit

# 나머지 소스코드 복사
COPY . .

# 포트 설정 (기본 개발 서버 포트)
EXPOSE 3000

# 애플리케이션을 직접 실행
CMD ["npm", "start"]
