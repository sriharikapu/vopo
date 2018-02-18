//TODO:
//1. Optimize for gas

pragma solidity ^0.4.17;

contract ViewContract{

    struct wallets{
        uint viewBalance;
        uint voteBalance;
    }

  mapping (address => wallets) balances;

  function createWallet() public{
    balances[msg.sender] = wallets(0,0);
  }

	function viewing1() public{
		require(balances[msg.sender].viewBalance > 0);
    balances[msg.sender].viewBalance--;
	}

// These 4 functions are solely for testing purposes
  function addViewBalance() public returns (uint){
    balances[msg.sender].viewBalance += 10;
    return balances[msg.sender].viewBalance;
  }

  function addVoteBalance() public returns (uint){
    balances[msg.sender].voteBalance+=10;
    return balances[msg.sender].voteBalance;
  }

  function getViewBalance() view returns (uint){
    return balances[msg.sender].viewBalance;
  }

  function getVoteBalance() view returns (uint){
    return balances[msg.sender].voteBalance;
  }
}
