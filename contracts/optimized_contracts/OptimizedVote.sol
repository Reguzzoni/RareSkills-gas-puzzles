// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

// DONE
library VoteLibrary {
    struct Voter {
        uint8 vote;
        uint8 voted;
    }

    struct Proposal {
        uint8 voteCount;
        uint8 ended;
        bytes32 name;
    }
}

contract OptimizedVote {

    mapping(address => VoteLibrary.Voter) public voters;

    VoteLibrary.Proposal[] proposals;

    function createProposal(bytes32 _name) external {
        VoteLibrary.Proposal memory _proposal;
        _proposal.name = _name;
        proposals.push(_proposal);
    }

    function vote(uint8 _proposal) external {
        VoteLibrary.Voter storage _voter = voters[msg.sender];
        require(_voter.voted == 0, 'already voted');
        _voter.vote = _proposal;
        _voter.voted = 1;

        unchecked {
            proposals[_proposal].voteCount += 1;    
        }
    }

    function getVoteCount(uint8 _proposal) external view returns (uint8) {
        return proposals[_proposal].voteCount;
    }
}
