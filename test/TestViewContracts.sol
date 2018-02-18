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
    test.createOpenMarket("www.google.com");
    test.viewing("www.google.com");
    uint returnedId = test.getViewBalance();
    uint expected = 19;
    Assert.equal(returnedId, expected, "User should have 19 view tokens");
  }

  function testViewsInMarket() public{
    uint returnedId = test.getMarketView("www.google.com");
    uint expected = 1;
    Assert.equal(returnedId, expected, "Google views should be 1 ;)");
  }

  function testAddVotes() public{
    test.addVote("www.google.com", 3, false);
    test.addVoteManualNoOrigin("www.google.com", 2, true);
    uint returnedId = test.getViewBalance();
    uint expected = 28;
    Assert.equal(returnedId, expected, "Views should be 19+9 = 28 after 3 votes submitted");
  }

  function testRemainderVotes() public{
    uint returnedId = test.getVoteBalance();
    uint expected = 7;
    Assert.equal(returnedId, expected, "10 votes, used 3, left with 7");
  }

  function testCloseMarketVotesCount() public{
    test.closeMarket("www.google.com");
    uint returnedId = test.getVoteBalance();
    uint expected = 10;
    Assert.equal(returnedId, expected, "7 + 3 * uint(5/3) = 7 + 3 = 10");
  }

}
