const Adoption = artifacts.require("Adoption"); // artifacts.require()은 Truffle 프레임워크의 기능. 스마트 컨트랙트의 아티팩트를 불러옴. 아티팩트는 스마트 컨트랙트의 바이너리, ABI(Application Binary Interface), 그 외의 메타데이터를 포함.

contract("Adoption", (accounts) => {  // accounts는 이 테스트를 사용할 때 네트워크에서 사용 가능한 계정을 제공.
  let adoption;
  let expectedAdopter;

  before(async () => {  // before은 테스트 프레임워크에서 제공하는 초기 설정용 함수. 테스트 케이스들이 실행되기 전에 필요한 데이터를 준비하거나, 특정 상태를 설정하는 데 사용.
      adoption = await Adoption.deployed();
  });

  describe("adopting a pet and retrieving account addresses", async () => {
    before("adopt a pet using accounts[0]", async () => {
      await adoption.adopt(8, { from: accounts[0] }); // 첫 번째 계정으로 petId: 8 인 adopt 함수 호출.
      expectedAdopter = accounts[0];
    });

    it("can fetch the address of an owner by pet id", async () => { // it 함수는 Mocha 테스트 프레임워크에서 제공하는 함수. 테스트 케이스를 정의하는 데 사용.
      const adopter = await adoption.adopters(8);
      assert.equal(adopter, expectedAdopter, "The owner of the adopted pet should be the first account.");  // 사용자가 assert 기능을 사용할 수 있도록 Truffle이 Chai를 import.
    });
  
    it("can fetch the collection of all pet owners' addresses", async () => {
      const adopters = await adoption.getAdopters();
      assert.equal(adopters[8], expectedAdopter, "The owner of the adopted pet should be in the collection.");
    });
  });

});