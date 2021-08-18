pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";

contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna); /* define event which can be emitted and then listened on the frontend */

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; /* number of possible combinations */

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies; /* array of zombies, index is zombie id */

    mapping (uint => address) public zombieToOwner; /* map of zombie id : owner address */
    
    mapping (address => uint) ownerZombieCount; /* map of owner address : num of zombies */
    function _createZombie(string memory _name, uint _dna) internal { /* internal so that child contract can access it */
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1; /* create zombie, add it to list of zombies, get its id (index) */
        zombieToOwner[id] = msg.sender; /* add zombie to map of zombie id:address */
        ownerZombieCount[msg.sender]++; /* increment the count of owner zombies */
        emit NewZombie(id, _name, _dna); /* emit event that new zombie is created */
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str))); /* turns string into buffer, then hashes it (~sha256), them casts to uint */
        return rand % dnaModulus; /* num between 0 and 10e16 (padded with zeros on frontend to make it 16 digits if needed) */
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0); /* allow only if our address hasn't created a zombie yet */
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
