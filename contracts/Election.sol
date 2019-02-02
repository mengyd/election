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
	
	mapping(uint => Candidate) public candidates;
	mapping(address => bool) public voters;

	uint public candidatesCount;
	//uint public voteTotal;

	constructor() public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function compareString(string memory _s1, string memory _s2) public returns (bool) {
		bytes memory s1 = bytes(_s1);
		bytes memory s2 = bytes(_s2);
		return keccak256(s1) == keccak256(s2);
	}

	function addCandidate (string memory _name) private {
		//vérifier doublons
		for(uint i=1; i<=candidatesCount; i++){
			require(!compareString(string(candidates[i].name), _name));
		}
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