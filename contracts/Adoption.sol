pragma solidity ^0.5.0;	// 필요한 Solidity 최소 버전 명시. 0.5.0 이상.

contract Adoption {
	address[16] public adopters;	// Solidity에는 address라는 고유한 type이 있음. type이 address이고 length가 16인 배열로 adopters 변수 정의. Public 변수에는 자동으로 getter 메소드 포함.

	// Adopting a pet
	function adopt(uint petId) public returns (uint) {	// type이 uint(integer)인 매개변수 petId 지정. 반환 type으로 uint 지정.
		require(petId >= 0 && petId <= 15);	// petId가 배열 범위 내에 있는지 확인.

		adopters[petId] = msg.sender;	// 함수를 호출한 사람이나 스마트 컨트랙트의 주소는 msg.sender로 표시됨. adopters 배열에 msg.sender 추가.

		return petId;	// 확인용 return
	}

	// Retrieving the adopters
	// 자동으로 생성된 getter는 지정된 key에서 single value만 반환함. 전체 배열을 반환하는 함수 작성.
	function getAdopters() public view returns (address[16] memory) {	// 매개변수 없음. 반환 type은 address[16]. view 키워드는 함수가 계약 상태를 수정하지 않는다는 의미.
		return adopters;
	}
}