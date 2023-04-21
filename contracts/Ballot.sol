// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ballot {
    // Define the structure of a voter
    struct Voter {
        bool voted;
        uint voteIndex;
    }

    // Define the structure of a candidate
    struct Candidate {
        string name;
        uint voteCount;
    }

    // Define the variables for the contract
    address public chairperson;
    mapping(address => Voter) public voters;
    Candidate[] public candidates;

    // Define the events for the contract
    event Voted(address indexed voter, uint indexed candidateIndex);

    // Constructor function
    constructor(string[] memory candidateNames) {
        chairperson = msg.sender;

        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    // Vote function
    function vote(uint candidateIndex) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.voteIndex = candidateIndex;
        candidates[candidateIndex].voteCount++;
        emit Voted(msg.sender, candidateIndex);
    }

    // Get the total number of votes for a candidate
    function getVoteCount(uint candidateIndex) public view returns (uint) {
        return candidates[candidateIndex].voteCount;
    }
}
