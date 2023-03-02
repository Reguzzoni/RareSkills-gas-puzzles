// SPDX-License-Identifier: GPL-3.0

/**
// TODO
// 4008
contract OptimizedDistribute {
    

    uint256 immutable private amount;
    address immutable private contributor1;
    address immutable private contributor2;
    address immutable private contributor3;
    address immutable private contributor4;
    uint256 immutable private createTime;
    

    constructor(address[4] memory _contributors) payable {
        contributor1 = payable(_contributors[0]);
        contributor2 = payable(_contributors[1]);
        contributor3 = payable(_contributors[2]);
        contributor4 = payable(_contributors[3]);

        // pre calculate amount
        unchecked {
            amount = address(this).balance >> 2;
        }
        createTime = block.timestamp;
    }

    function distribute() external {
        require(
            block.timestamp - 1 weeks > createTime,
            "cannot distribute yet"
        );

        


        payable(contributor4).send(amount);
        payable(contributor3).send(amount);
        payable(contributor2).send(amount);
        payable(contributor1).send(amount);
        selfdestruct(payable(contributor4));
    }
}

*/

contract OptimizedDistribute {

    // ideas
    // convert list to map
    // cast payable into list type
    // convert to private map
    // convert to immutable and indipendent variables
    uint256 immutable private amount;
    address immutable private contributor1;
    address immutable private contributor2;
    address immutable private contributor3;
    address immutable private contributor4;
    uint256 immutable private createTime;
    //uint8 private lockedReentrancy;

    constructor(address[4] memory _contributors) payable {
        // split
        contributor1 = _contributors[0];
        contributor2 = _contributors[1];
        contributor3 = _contributors[2];
        contributor4 = _contributors[3];
        // pre calculate amount
        unchecked {
            amount = address(this).balance >> 2;
        }
        createTime = block.timestamp;
    }

    function distribute() external {
        require(
            block.timestamp - 1 weeks > createTime,
            "cannot distribute yet"
        );
        
        // maybe bulk send call
        // maybe delete contributors after sending
        // maybe trasfer all to one user and then transfer to others? to get non-zero to zero reward
        // maybe .send call instead of .transfer call but CARE OF REENTRANCY
        /* 
            require(lockedReentrancy == 0, "reentrancy locked");
            lockedReentrancy = 1;)
        */
        payable(contributor1).send(amount);
        payable(contributor2).send(amount);
        payable(contributor3).send(amount);

        //https://www.alchemy.com/overviews/selfdestruct-solidity#:~:text=Selfdestruct%20is%20a%20keyword%20in,want%20to%20terminate%20a%20contract.
        selfdestruct(payable(contributor4));
        
    }
}