// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

// DONE
contract OptimizedArraySum {
    uint256[] array;

    function setArray(uint256[] memory _array) external {
        require(_array.length < 11, "too long");
        array = _array;
    }

    function getArraySum() external view returns (uint256 sum) {
        uint256 arrayLen = array.length;
        uint256 i;
        while (i < arrayLen) {
            sum += array[i];
            unchecked {
                i++;
            }
        }

        return sum;
    }
}
