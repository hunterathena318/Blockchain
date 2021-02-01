const FucksToken = artifacts.require("./FucksToken.sol");
const PigERC20 = artifacts.require("./PigERC20.sol");
const ERC20Interface = artifacts.require("./ERC20Interface.sol");
const Mytoken = artifacts.require("./Mytoken.sol");
const DappERCToken = artifacts.require("./DappERCToken.sol");
const ConHeo = artifacts.require("./ConHeo.sol")

module.exports = function(deployer) {
    // deployer.deploy(FucksToken);
    // deployer.deploy(ERC20Interface);
    deployer.deploy(Mytoken);
    deployer.deploy(ConHeo);
};