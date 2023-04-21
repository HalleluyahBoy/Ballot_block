pragma solidity ^0.8.0;

contract Ballot {
    // This struct represents a single candidate
    struct Candidate {
        string name;
        uint voteCount;
    }

    // This array holds all the candidates
    Candidate[] public candidates;

    // This mapping keeps track of which address has voted
    mapping(address => bool) public hasVoted;

    // This modifier ensures that the vote is only open during a specific period
    modifier onlyDuringVotingPeriod() {
        // Check that the current time is between the start and end times
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Voting is closed");
        _;
    }

    // These variables define the voting period
    uint public startTime;
    uint public endTime;

    // This event is emitted when a vote is cast
    event VoteCast(address indexed voter, uint candidateIndex);

    // This constructor sets the voting period and initializes the candidates
    constructor(uint _startTime, uint _endTime, string[] memory candidateNames) {
        require(_startTime < _endTime, "Invalid voting period");
        require(_startTime > block.timestamp, "Voting start time must be in the future");

        startTime = _startTime;
        endTime = _endTime;

        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    // This function allows a user to cast their vote for a candidate
    function castVote(uint candidateIndex) public onlyDuringVotingPeriod {
        require(!hasVoted[msg.sender], "You have already voted");

        // Make sure the candidate index is valid
        require(candidateIndex < candidates.length, "Invalid candidate index");

        // Mark the sender as having voted
        hasVoted[msg.sender] = true;

        // Increment the candidate's vote count
        candidates[candidateIndex].voteCount++;

        // Emit the VoteCast event
        emit VoteCast(msg.sender, candidateIndex);
    }

    // This function returns the list of candidates
    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    // This function returns the winner of the election
    function getWinner() public view returns (Candidate memory) {
        uint maxVotes = 0;
        Candidate memory winner;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winner = candidates[i];
            }
        }

        return winner;
    }
}
