const FucksToken = artifacts.require("./FucksToken.sol");
const PigERC20 = artifacts.require("./PigERC20.sol");
const ERC20Interface = artifacts.require("./ERC20Interface.sol");
const Mytoken = artifacts.require("./Mytoken.sol");

module.exports = function(deployer) {
    // deployer.deploy(FucksToken);
    // deployer.deploy(ERC20Interface);
    deployer.deploy(Mytoken);
};
