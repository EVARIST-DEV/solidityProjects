//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract voting {
    // Structure to represent a candidate
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    // Array to store candidates
    Candidate[] public candidates;

    // Mapping to keep track of whether an address has voted or not
    mapping(address => bool) public hasVoted;

    // Function to add a candidate
    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }

    // Function to vote for a candidate
    function vote(uint256 _candidateIndex) public {
        require(_candidateIndex < candidates.length, "Invalid candidate index");

        // Ensure the voter has not voted before
        require(!hasVoted[msg.sender], "You have already voted");

        // Increment vote count for the chosen candidate
        candidates[_candidateIndex].voteCount++;

        // Mark the sender as having voted
        hasVoted[msg.sender] = true;
    }

    // Function to get the total number of candidates
    function getCandidateCount() public view returns (uint256) {
        return candidates.length;
    }

    // Function to get details of a candidate by index
    function getCandidate(uint256 _index) public view returns (string memory, uint256) {
        require(_index < candidates.length, "Invalid candidate index");
        Candidate memory candidate = candidates[_index];
        return (candidate.name, candidate.voteCount);
    }
}
