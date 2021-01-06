pragma solidity >=0.4.22 <0.9.0;

contract Election {
	// Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}
	mapping(uint => Candidate) public candidates;
	uint public candidatesCount;
	string public candidate;

	// Constructor
//	constructor() public { }

	function demo() public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate (string memory _name) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

}