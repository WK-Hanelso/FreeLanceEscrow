# 베이스 이미지
FROM ubuntu:20.04

# 환경 변수 설정
ENV DEBIAN_FRONTEND=noninteractive

# ARG: 사용자 정의
ARG USERNAME=hanelso
ARG UID=1000
ARG GID=1000

# 필수 패키지 설치 + 유저 생성
RUN apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    git \
    vim \
    zsh \
    tmux \
    python3.8 \
    python3.8-venv \
    python3-pip \
    tzdata \
    gnupg \
    ca-certificates && \
    ln -sf /usr/bin/python3.8 /usr/bin/python3 && \
    groupadd -g ${GID} ${USERNAME} && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Node.js 18.x 설치
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Hardhat 초기 설치 (전역 X, 프로젝트 내부에서 npm으로 설치할 것)
RUN npm install -g npm && npm install -g hardhat

# 작업 디렉토리 설정
WORKDIR /workspace

# 사용자 전환
USER ${USERNAME}

# 프롬프트 꾸미기 (구분용)
ENV PS1="\[\e[1;32m\][${USERNAME}@\h:\w]\$\[\e[0m\] "