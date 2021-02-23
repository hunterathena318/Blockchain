const HDWalletProvider = require("@truffle/hdwallet-provider");
require('dotenv').config();

module.exports = {
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      // port: 7545,
      port:8545,
      network_id: "*" // Match any network id
    },
    develop: {
      port: 8545
    },
    ropsten: {
      provider: function () {
        return new HDWalletProvider(process.env.PRIVATE_KEY, `https://ropsten.infura.io/v3/${process.env.INFURA_API_KEY}`)
      },
      skipDryRun: true,
      gas: 6000000,
      gasPrice: 30000000000,
      network_id: 3
    },
  },
  // See <http://truffleframework.com/docs/advanced/configuration>
  compilers: {
    solc: {
      version: "0.5.2",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
