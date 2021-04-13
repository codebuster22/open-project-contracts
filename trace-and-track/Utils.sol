// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library Utils{
    function hash(string memory s1, address s2, string memory s3) private pure returns (bytes32){
        //First, get all values as bytes
        bytes memory b_s1 = bytes(s1);
        bytes20 b_s2 = bytes20(s2);
        bytes memory b_s3 = bytes(s3);

        //Then calculate and reserve a space for the full string
        string memory s_full = new string(b_s1.length + b_s2.length + b_s3.length);
        bytes memory b_full = bytes(s_full);
        uint j = 0;
        uint i;
        for(i = 0; i < b_s1.length; i++){
            b_full[j++] = b_s1[i];
        }
        for(i = 0; i < b_s2.length; i++){
            b_full[j++] = b_s2[i];
        }
        for(i = 0; i < b_s3.length; i++){
            b_full[j++] = b_s3[i];
        }

        //Hash the result and return
        return keccak256(b_full);
    }
}