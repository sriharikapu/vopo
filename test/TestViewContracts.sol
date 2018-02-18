pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ViewContract.sol";


contract TestViewContracts {
  ViewContract test = ViewContract(DeployedAddresses.ViewContract());

  // Testing the adopt() function
  function testAddViewBalance() public {
    test.createWallet();
    uint returnedId = test.addViewBalance();
    uint expected = 10;
    Assert.equal(returnedId, expected, "User should have 10 view tokens");
  }

   //Testing retrieval of a single pet's owner
  function testAddViewBalance2() public {
    uint returnedId = test.addViewBalance();
    uint expected = 20;
    Assert.equal(returnedId, expected, "User should have 20 view tokens");
  }

  // Testing retrieval of all pet owners
  function testAddVoteBalance() public {
    uint returnedId = test.addVoteBalance();
    uint expected = 10;
    Assert.equal(returnedId, expected, "User should have 10 vote tokens");
  }

  function testView() public{
    test.viewing1();
    uint returnedId = test.getViewBalance();
    uint expected = 19;
    Assert.equal(returnedId, expected, "User should have 19 view tokens");
  }

}
