module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Mapping);
  deployer.deploy(Dummy).then(function(){
    return deployer.deploy(Refugee, Dummy.address);
  });
  deployer.deploy(Refugee);
};
