pragma solidity ^0.5.0;

contract Election {
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}

	event votedEvent (
		uint indexed _candidateId
	);
	//addr
	mapping(uint => Candidate) public candidates;
	mapping(address => bool) public voters;

	uint public candidatesCount;
	//uint public voteTotal;

	constructor() public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate (string memory _name) private {
		//vérifier doublons
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote (uint _candidateId) public {
		require(!voters[msg.sender]);
		require(_candidateId > 0 && _candidateId <= candidatesCount);
		voters[msg.sender] = true;
		candidates[_candidateId].voteCount ++;
		//voteTotal++;
		emit votedEvent(_candidateId);
	}

}