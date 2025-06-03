# 🧾 Freelance Escrow Contract

**스마트컨트랙트 기반 프리랜서 자동 보상 시스템**  
프리랜서가 정해진 작업을 완료하면 고용주가 검토 후 보상을 자동으로 지급하는 스마트컨트랙트 DApp입니다.

---

## 🚀 프로젝트 개요

- **개발 목적:** 프리랜서와 고용주 간의 보상 신뢰 문제 해결
- **핵심 기능:** 작업 단위로 보상을 자동 지급하는 스마트컨트랙트
- **기술 스택:** Solidity, Hardhat, Ethers.js, Node.js, Docker (Ubuntu 20.04)

---

## 📂 프로젝트 구조

```
freelance-pay/
├── contracts/              # 스마트컨트랙트 코드
│   └── FreelanceEscrow.sol
├── scripts/                # 배포 스크립트
│   └── deploy.js
├── test/                   # (선택) 테스트 코드
├── hardhat.config.js       # Hardhat 설정
├── package.json
└── README.md
```

---

## 🛠️ 개발 환경

- Ubuntu 20.04 (Docker 기반)
- Node.js 18.x
- Hardhat (Local Ethereum Testnet)
- VS Code + Remote SSH

---

## 📦 설치 방법

```bash
# 프로젝트 디렉토리로 이동
cd freelance-pay

# 패키지 설치
npm install
```

---

## ⚙️ 배포 방법 (로컬 테스트넷)

1. 하드햇 로컬 노드 실행:

```bash
npx hardhat node
```

2. 배포 스크립트 실행:

```bash
npx hardhat run scripts/deploy.js --network localhost
```

---

## ✅ 스마트컨트랙트 기능

- 고용주가 프리랜서 주소, 작업 리스트, 보상금 등록
- 업무 완료 후 고용주가 승인하면 해당 작업 보상 자동 전송
- 예치금 부족 시 배포 실패
- 향후 Web3 UI 연동 가능

---

## 📌 향후 계획

- Web 프론트엔드(UI) 연동 (React + Web3.js)
- 업무 승인 트리거 조건 다양화
- Polygon 또는 Sepolia 테스트넷 배포

---

## 🧑‍💻 개발자

- **이천우 (Lee Cheonwoo)**
- GitHub: [WK-Hanelso](https://github.com/WK-Hanelso)
- Email: wk.hanelso@gmail.com

---

> 이 프로젝트는 포트폴리오 및 블록체인 스마트컨트랙트 학습 목적으로 제작되었습니다.
