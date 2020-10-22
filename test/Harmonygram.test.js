const { accounts, contract } = require('@openzeppelin/test-environment');

const { expect } = require('chai');

const Harmonygram = contract.fromArtifact('Harmonygram');

describe('Harmonygram', function () {
  const [ owner ] = accounts;

  beforeEach(async function() {
    this.Harmonygram = await Harmonygram.new({ from: owner });
  });

  it('the deployer is the owner', async function () {
    expect(await this.Harmonygram.name()).to.equal('Harmonygram');
  });

  
});