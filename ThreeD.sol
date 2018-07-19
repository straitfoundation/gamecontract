pragma solidity ^0.4.18;


/**
 * The contractName contract does this and that...
 */
contract ThreeD {
    uint256 public jackPot;
    uint[3] NumberAndCount;
    uint Trophy;
    uint status;
    mapping (address => NumberAndCOunt[]) userMapping;
    bytes32[] userAddressKey;
    address[] userAddress;
    address[] winner;

    function _getTokenRandom (bytes32[] source) internal view returns(uint res) {
        bytes32 _value1 = source[0];
        bytes32 _value2 = source[0];
        bytes32 _value3 = source[0];

        for (uint256 i = 0; i < source.length; i++) {
            if (i % 3 == 0) {
               _value1 = _value1 ^ source[i]; 
            }else if (i % 3 == 1) {
               _value2 = _value2 ^ source[i];  
            }else{
                _value3 = _value3 ^ source[i]; 
            }
            
        }

        res = (uint256(_value1) % 10) * 100 + (uint256(_value2) % 10) * 10 + (uint256(_value3) % 10);
    }

    function add(address _parter, bytes32 part_key, uint _number, uint _count) internal {
        NumberAndCount memory _numer_and_count = NumberAndCount(_number,
         _count, now)
        userMapping[_parter].push(_numer_and_count);
        userAddress.push(_parter);
        userAddressKey.push(part_key);
        jackPot += _count;
    }
    
    function  partIn(bytes32 part_key, uint _number, uint _count) external {
        require (0 < _number < 999);
        require (_count > 0);
        add(msg.sender, part_key, _number, _count);
    }

    function getPart() external view returns(NumberAndCount[]){
        return myMapping[msg.sender];
        
    }
    
    function getInfo () external view returns(
        uint trophy,
        uint _status,
        uint256 _count,
        uint256 jackpotCount) {
        trophy = Trophy;
        _status = status;
        _count = userAddress.length;
        jackpotCount = jackPot;
    }

    function addRandom (bytes32 _key) external returns(bool res){
        userAddressKey.push(_key);
        res = true;
    }
    
    
    function openGame () returns(bool res) external returns(bool){
        require (userAddressKey.length > 3);
        bool res;

        trophy = _getTokenRandom(userAddressKey);
        for (uint256 i = 0; i < userAddress.length; i++) {
            NumberAndCount[] memory _user_part_info = userMapping[userAddress[i]];

            for (uint256 j = 0; j < _user_part_info.length; j++) {
                if (trophy == _user_part_info[j][0]){
                    winner.push(userAddress[i]);
                }
            }

        }

        if (winner.length > 0){
            res = true;
            status = 1;
        }else {
            res = false;
            status = 2;
        }

        return res;
    }
       
}
