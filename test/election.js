const election = artifacts.require("election");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("election", function (/* accounts */) {
  it("should assert true", async function () {
    await election.deployed();
    return assert.isTrue(true);
  });
});
