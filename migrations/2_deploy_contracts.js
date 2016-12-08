module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(UserMapping);
  deployer.deploy(UserAssetMapping);
  deployer.deploy(UserAssets);
  deployer.deploy(User);
  deployer.deploy(Asset);
};
