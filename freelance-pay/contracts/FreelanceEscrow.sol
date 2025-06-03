// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/// @title 프리랜서 자동 보상 스마트컨트랙트
/// @notice 고용주가 보상을 예치하고, 마일스톤 완료 시 프리랜서에게 자동 지급
contract FreelanceEscrow {
    address public employer;
    address public freelancer;

    struct Milestone {
        string description;    // 작업 설명
        uint amount;           // 보상 금액 (wei)
        bool submitted;        // 작업 제출 여부
        bool approved;         // 고용주 승인 여부
        bool paid;             // 지급 여부
    }

    Milestone[] public milestones;
    uint public totalAmount;

    /// @notice 배포 시 고용주가 총 보상금과 마일스톤 리스트를 설정
    /// @param _freelancer 프리랜서 지갑 주소
    /// @param descriptions 마일스톤별 설명
    /// @param amounts 마일스톤별 보상금 (ETH 단위 → wei로 변환 필요)
    constructor(
        address _freelancer,
        string[] memory descriptions,
        uint[] memory amounts
    ) payable {
        require(descriptions.length == amounts.length, "Length mismatch");

        employer = msg.sender;
        freelancer = _freelancer;

        uint sum = 0;
        for (uint i = 0; i < descriptions.length; i++) {
            milestones.push(Milestone({
                description: descriptions[i],
                amount: amounts[i],
                submitted: false,
                approved: false,
                paid: false
            }));
            sum += amounts[i];
        }

        require(msg.value == sum, "Must deposit full amount");
        totalAmount = sum;
    }

    modifier onlyEmployer() {
        require(msg.sender == employer, "Only employer");
        _;
    }

    modifier onlyFreelancer() {
        require(msg.sender == freelancer, "Only freelancer");
        _;
    }

    /// @notice 프리랜서가 작업 제출
    function submitWork(uint index) external onlyFreelancer {
        Milestone storage m = milestones[index];
        require(!m.submitted, "Already submitted");
        m.submitted = true;
    }

    /// @notice 고용주가 작업 승인
    function approveWork(uint index) external onlyEmployer {
        Milestone storage m = milestones[index];
        require(m.submitted, "Not submitted");
        require(!m.approved, "Already approved");
        require(!m.paid, "Already paid");
        m.approved = true;

        _releasePayment(index);
    }

    /// @dev 승인된 마일스톤에 대해 보상 전송
    function _releasePayment(uint index) internal {
        Milestone storage m = milestones[index];
        require(m.approved && !m.paid, "Not eligible");
        m.paid = true;
        payable(freelancer).transfer(m.amount);
    }

    /// @notice 마일스톤 개수 조회
    function getMilestoneCount() external view returns (uint) {
        return milestones.length;
    }

    /// @notice 마일스톤 정보 조회
    function getMilestone(uint index) external view returns (
        string memory description,
        uint amount,
        bool submitted,
        bool approved,
        bool paid
    ) {
        Milestone storage m = milestones[index];
        return (m.description, m.amount, m.submitted, m.approved, m.paid);
    }
}
