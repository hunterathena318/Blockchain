pragma solidity >=0.4.22 <0.9.0;

contract Election {
	// Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}

	struct Student {
		uint id;
		string name;
		string class;
		uint avg;
	}

	Student[] public blockClass;

	mapping(uint => Candidate) public candidates;
	mapping(uint => Student) public students;
	mapping(uint => address) public addressContract;
	mapping(address => bool) public voters;

	uint public candidatesCount;
	string public candidate;
	string public employer;

	// Constructor
	constructor() public {
		employer = "HTA";
	}

	function logEmployer() public {
		employer = "HTA";
	}

	function demo() public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate (string memory _name) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote (uint _candidateId) public {
		// require that they haven't voted before
		require(!voters[msg.sender]);

		// require a valid candidate
		require(_candidateId > 0 && _candidateId <= candidatesCount);

		// record that voter has voted
		voters[msg.sender] = true;

		// update candidate vote Count
		candidates[_candidateId].voteCount ++;
	}

}