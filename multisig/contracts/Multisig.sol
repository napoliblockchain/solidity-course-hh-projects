//SPDX-License-Identifier: AGPL-3.0-only

pragma solidity ^0.8.0;

/// @notice A simple multi-signature contract.
contract Multisig {

    /// @notice This struct describes a proposal.
    struct Proposal {
        address target;
        uint256 value;
        bytes data;
        uint256 sigs;
    }

    /// @notice Mapping indicating if a given address is a signer.
    mapping(address => bool) public signers;

    /// @notice Mapping that maps an uint256 to a proposal.
    mapping(uint256 => Proposal) public proposals;

    /// @notice Mapping indicating if a proposal was signed by a given address.
    mapping(uint256 => mapping(address => bool)) public signed;

    /// @notice The number of signatures needed to execute a proposal.
    uint256 public requiredSignatures;

    /// @notice A counter for proposals.
    uint256 public proposalsCounter;


    /// @notice Event emitted when a proposal is pushed to the multisignature contract.
    event Propose(address indexed signer, uint256 indexed proposalNumber);

    /// @notice Event emitted when a proposal is signed.
    event Sign(address indexed signer, uint256 indexed proposalNumber);

    /// @notice Event emitted when a proposal is executed.
    event Execute(address indexed executor, uint256 indexed proposalNumber);

    constructor(address[] memory signers_, uint256 requiredSignatures_) {
        require(requiredSignatures_ != 0, "can't have 0 signatures to execute");

        for(uint256 i = 0; i < signers_.length; i++) {
            signers[signers_[i]] = true;
        }

        requiredSignatures = requiredSignatures_;
    }

    function propose(address target, uint256 value, bytes calldata data) external {
        require(signers[msg.sender], "not signer");

        uint256 proposalNumber = proposalsCounter++;

        proposals[proposalNumber] = Proposal({
            target: target,
            value: value,
            data: data,
            sigs: 0
        });

        emit Propose(msg.sender, proposalNumber);
    }

    // the signature is done on-chain (tx)
    function sign(uint256 proposalNumber) external {
        require(proposalNumber < proposalsCounter, "can't sign for a future proposal");
        require(signers[msg.sender], "not signer");
        require(!signed[proposalNumber][msg.sender], "already signed");

        proposals[proposalNumber].sigs += 1;

        emit Sign(msg.sender, proposalNumber);
    }

    function execute(uint256 proposalNumber) external returns (bool success, bytes memory result) {
        require(signers[msg.sender], "not signer");

        Proposal storage proposal = proposals[proposalNumber];
    
        require(proposal.sigs >= requiredSignatures, "not enough signers");

        (success, result) = proposal.target.call{value: proposal.value}(proposal.data);

        require(success, "execution failed");

        delete proposals[proposalNumber]; // delete the proposal!! 

        emit Execute(msg.sender, proposalNumber);
    }

    receive() external payable virtual {}
}
