module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Mapping);
  deployer.deploy(refugee);
  deployer.autolink();
};
