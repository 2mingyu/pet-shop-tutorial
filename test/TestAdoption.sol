pragma solidity ^0.5.0;

import "truffle/Assert.sol";  // 테스트에서 사용할 assertion(주장) 제공. pass/fail 을 반환.
import "truffle/DeployedAddresses.sol"; // 테스트를 실행할 때 Truffle은 테스트 중인 계약의 새로운 인스턴스를 블록체인에 배포함. DeployedAddresses.sol은 배포된 계약의 주소를 가져옴.
import "../contracts/Adoption.sol"; // 테스트 대상 스마트 컨트랙트.

contract TestAdoption {
  // The address of the adoption contract to be tested
  Adoption adoption = Adoption(DeployedAddresses.Adoption()); // 테스트할 스마트 컨트랙트의 주소를 얻기 위해 DeployedAddresses 호출.

  // The id of the pet that will be used for testing
  uint expectedPetId = 8; // 테스트에 사용될 PetId.

  //The expected owner of adopted pet is this contract
  address expectedAdopter = address(this);  // TestAdoption 계약이 트랜잭션을 전송하므로, expectedAdopter을 현재 계약의 주소를 가져오는 계약 전체 변수인 this로 설정.

  // Testing the adopt() function
  function testUserCanAdoptPet() public {
    uint returnedId = adoption.adopt(expectedPetId);  // adopt() 함수는 성공 시 매개변수로 사용된 petId를 반환하도록 작성했었음.

    Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned."); // returnedId와 expectedPetId가 동일하지 않으면 message 출력.
  }

  // Testing retrieval of a single pet's owner
  function testGetAdopterAddressByPetId() public {
    address adopter = adoption.adopters(expectedPetId); // adopters 배열 변수 선언 시 자동으로 생성된 getter 메소드에 key로 expectedPetId를 사용.

    Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be this contract");  // adopter과 expectedAdopter가 동일하지 않으면 message 출력.
  }

  // Testing retrieval of all pet owners
  // 전체 배열에 대한 getter 테스트.
  function testGetAdopterAddressByPetIdInArray() public {
    // Store adopters in memory rather than contract's storage
    address[16] memory adopters = adoption.getAdopters(); // Solidity의 memory 속성은 값을 contract's storage에 저장하는 대신 memory에 임시 저장. memory에 저장된 데이터는 함수 종료 시 소멸. 가스 비용 감소. 함수의 매개변수와 반환값은 기본적으로 memory에 저장되는데, 복잡한 데이터 타입(예: 배열, 구조체)은 memory 키워드를 명시적으로 사용해야 함.

    Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract");
  }

}