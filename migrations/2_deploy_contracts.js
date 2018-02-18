var ViewContract = artifacts.require("ViewContract");
var VoteContract = artifacts.require("VoteContract");


module.exports = function(deployer) {
  deployer.deploy(ViewContract);
};

module.exports = function(deployer) {
  deployer.deploy(VoteContract);
}
