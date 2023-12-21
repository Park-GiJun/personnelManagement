
var globalJsonData; // 전역 변수로 JSON 데이터를 저장

window.onload = function() {
	// 서버에 POST 요청 보내기
	fetch('../Contorller/ReferenceLoad.do', {
		method: 'POST',
	})
		.then(response => response.json())
		.then(data => {
			console.log(data);
			globalJsonData = data; // 데이터를 전역 변수에 저장
			updateSelectOptions(data);
			updateTableWithJsonData(document.getElementById("exampleSelect1").value, data); // 초기 테이블 데이터 설정

		})
		.catch(error => {
			console.error('Error:', error);
		});
	document.getElementById("sendButton").addEventListener("click", collectAndSendSelectedData);
	// Select 요소 변경 이벤트 리스너 설정
	document.getElementById("exampleSelect1").addEventListener("change", function() {
		updateTableWithJsonData(this.value, globalJsonData); // 옵션 변경 시 테이블 업데이트
	});
};

// updateTableWithJsonData 함수 정의
function updateTableWithJsonData(selectedOption, jsonData) {
	if (!jsonData || !jsonData[selectedOption]) {
		return;
	}

	var data = jsonData[selectedOption]; // 선택된 옵션에 해당하는 데이터
	var tableBody = document.querySelector("#referenceTabel");
	tableBody.innerHTML = ''; // 기존 테이블 내용 제거

	['first', 'second', 'third', 'fourth', 'fifth'].forEach(function(prefix) {
		if (data.hasOwnProperty(prefix + 'Emp')) {
			var row = tableBody.insertRow();

			// 셀 생성 및 데이터 삽입
			var cellTeam = row.insertCell();
			cellTeam.textContent = data[prefix + 'TEAM'] || '';
			var cellGrade = row.insertCell();
			cellGrade.textContent = data[prefix + 'GRADE'] || '';
			var cellNumber = row.insertCell();
			cellNumber.textContent = data[prefix + 'Emp'] || '';
			var cellName = row.insertCell();
			cellName.textContent = data[prefix + 'NAME'] || '';
		}
	});
}

function updateSelectOptions(data) {
	var selectElement = document.getElementById("exampleSelect1");

	// 기존 옵션 제거
	selectElement.innerHTML = "";

	// 데이터를 이용하여 새로운 옵션 추가
	for (var key in data) {
		if (data.hasOwnProperty(key)) {
			var option = document.createElement("option");
			option.text = data[key].name;
			selectElement.add(option);
		}
	}
}

function collectAndSendSelectedData() {
	var selectedOption = document.getElementById("exampleSelect1").value; // 선택된 옵션 가져오기
	var selectedData = globalJsonData[selectedOption]; // 전역 변수에서 해당 데이터 가져오기
	var dataToSend = JSON.stringify(selectedData);
	console.log(dataToSend);
	// postMessage 방식 사용
	window.opener.postMessage(dataToSend, '*');

	window.opener.updateRefTable(dataToSend);

	window.close();
}

function openAddRef() {
	// 새 창의 크기
	const width = 750;
	const height = 450;

	// 화면 중앙에 위치시키기 위한 left와 top 값 계산
	const left = window.screen.width / 2 - width / 2;
	const top = window.screen.height / 2 - height / 2;

	console.log(button.id);

	let newJSPURL = "../WorkBoard/AddRef.jsp";

	window.open(newJSPURL, "_blank", `width=${width},height=${height},top=${top},left=${left}`);
}

