pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/VoteContract.sol";

contract TestVoteContracts {
  VoteContract test2 = VoteContract(DeployedAddresses.VoteContract());

  function TestAddVoteBalance() public {
    test2.createWallet();
    uint returnedId = test2.addVoteBalance();
    uint expected = 10;
    Assert.equal(returnedId, expected, "User should have 10 vote tokens");
  }

}
