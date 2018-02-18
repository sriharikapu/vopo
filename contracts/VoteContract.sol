pragma solidity ^0.4.17;

contract VoteContract{


    uint viewVoteRatio = 3;

    struct wallets{
        uint viewBalance;
        uint voteBalance;
    }

    mapping (address => wallets) balances;

    struct voteCount{
      address _address;
      uint _number;
      bool _vote;
    }

    struct Market{
        uint _time;
        uint _latestVote;
        uint _viewTokenCount;
        mapping (uint => voteCount) listOfVotes;
    }

    mapping (bytes32 => Market) openMarkets;

    function createOpenMarket(string _website) public {
        openMarkets[keccak256(_website)] =  Market({
          _time: now,
          _latestVote: 0,
          _viewTokenCount: 0
        });
    }

    function addVote(string _website, uint number, bool vote) public {
        require(balances[msg.sender].voteBalance >= number);

        balances[msg.sender].viewBalance += viewVoteRatio*number;
        balances[msg.sender].voteBalance -= number;

        bytes32 website = keccak256(_website);
        uint latestVote = openMarkets[website]._latestVote;

        openMarkets[website].listOfVotes[latestVote] =  voteCount({
              _address: msg.sender,
              _number: number,
              _vote: vote
          });

        openMarkets[website]._latestVote++;
    }


    function closeMarket(string _website) public returns (uint) {
      uint yesCounts = 0;
      uint noCounts = 0;
      bytes32 website = keccak256(_website);

      for (uint i = 0; i < openMarkets[website]._latestVote; i++){
        if (!openMarkets[website].listOfVotes[i]._vote){
          noCounts += openMarkets[website].listOfVotes[i]._number;
        }
        else
          yesCounts += openMarkets[website].listOfVotes[i]._number;
      }
      uint yratio = (yesCounts+noCounts)/yesCounts;
      uint nratio = (yesCounts+noCounts)/noCounts;

      if (yesCounts > noCounts){
        for (i = 0; i < openMarkets[website]._latestVote; i++){
          if (openMarkets[website].listOfVotes[i]._vote){
            balances[openMarkets[website].listOfVotes[i]._address].voteBalance
            += yratio * openMarkets[website].listOfVotes[i]._number;
          }
        }
      }
      else{
        for (i = 0; i < openMarkets[website]._latestVote; i++){
          if (!openMarkets[website].listOfVotes[i]._vote){
            balances[openMarkets[website].listOfVotes[i]._address].voteBalance
            += nratio * openMarkets[website].listOfVotes[i]._number;
          }
        }
      }
    }

    // These 5 functions are solely for testing
      function createWallet() public{
        balances[msg.sender] = wallets(0,0);
      }

      function addViewBalance() public returns (uint){
        balances[msg.sender].viewBalance+=10;
        return balances[msg.sender].viewBalance;
      }

      function addVoteBalance() public returns (uint){
        balances[msg.sender].voteBalance+=10;
        return balances[msg.sender].voteBalance;
      }

      function getViewBalance() public view returns (uint){
        return balances[msg.sender].viewBalance;
      }

      function getVoteBalance() public view returns (uint){
        return balances[msg.sender].voteBalance;
      }

}
