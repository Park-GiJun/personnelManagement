let buttonNumber = 0;

document.addEventListener("DOMContentLoaded", function() {
	let writeButton = document.getElementById("writeButton");

	writeButton.addEventListener("click", function() {
		let detailElement = document.querySelector(".Detail");
		let xhr = new XMLHttpRequest();
		let htmlFilePath = "../WorkBoard/WorkBoardWrite.jsp";

		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				detailElement.innerHTML = xhr.responseText;
			}
		};
		xhr.open("GET", htmlFilePath, true);
		xhr.send();
	});
});

function openNewJSP() {
	// 여기에 새로 열 JSP 파일의 URL을 넣어주세요
	let newJSPURL = "../WorkBoard/References.jsp";
	window.open(newJSPURL, "_blank", "width=750,height=450");
}

function addEmp(button) {
	console.log(button.id);
	let newJSPURL = "../WorkBoard/addEMP.jsp?buttonId=" + button.id;
	window.open(newJSPURL, "_blank", "width=750,height=450");
}


// RefTable 업데이트 함수
function updateRefTable(dataJ) {
	var data = JSON.parse(dataJ);

	console.log(data);

	var tableBody = document.querySelector("#RefTable");
	tableBody.innerHTML = ''; // 기존 테이블 내용 제거

	var rowCount = 0; // 행 개수 카운트

	['first', 'second', 'third', 'fourth', 'fifth'].forEach(function(prefix) {
		if (data.hasOwnProperty(prefix + 'Emp')) {

			rowCount++; // 행이 존재하면 카운트 증가

			var row = tableBody.insertRow();
			console.log(rowCount);

			// 셀 생성 및 데이터 삽입
			var cellTeam = row.insertCell();
			cellTeam.textContent = data[prefix + 'TEAM'] || '';
			var cellGrade = row.insertCell();
			cellGrade.textContent = data[prefix + 'GRADE'] || '';
			var cellNumber = row.insertCell();
			cellNumber.textContent = data[prefix + 'Emp'] || '';
			var cellName = row.insertCell();
			cellName.textContent = data[prefix + 'NAME'] || '';
			var cellStatus = row.insertCell();
			cellStatus.innerHTML = '<span class="badge bg-secondary id="wait">대기</span>';
			var cellAction = row.insertCell();
			cellAction.innerHTML = '<button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">제거</button>';
		}
	});

	// 행이 5개 미만일 때만 "추가" 버튼 행 추가
	if (rowCount < 6) {
		var addRow = tableBody.insertRow();
		var addCell = addRow.insertCell();
		addCell.colSpan = 6;
		addCell.style.textAlign = "center";
		addRow.classList.add("addButtonRow");
		var buttonId = "addButton" + buttonNumber; // 고유한 버튼 ID 생성
		addCell.innerHTML = '<button type="button" class="btn btn-success btn-sm" onclick="addEmp(this)" id="' + buttonId + '">추가</button>';

		buttonNumber++; // 다음 버튼을 위해 번호 증가
	}
}

function addTableEmp(data, status) {
	console.log(data);

	var tableBody = document.querySelector("#RefTable");
	var rowCount = tableBody.rows.length;

	rowCount++; // 행이 존재하면 카운트 증가

	var row = tableBody.insertRow();
	console.log(rowCount);

	// 셀 생성 및 데이터 삽입
	var cellTeam = row.insertCell();
	cellTeam.textContent = data['team'] || '';
	var cellGrade = row.insertCell();
	cellGrade.textContent = data['emp_grade'] || '';
	var cellNumber = row.insertCell();
	cellNumber.textContent = data['empNum'] || '';
	var cellName = row.insertCell();
	cellName.textContent = data['name'] || '';
	var cellStatus = row.insertCell();
	if (status === '참조') {  // Make sure to use '===' for comparison
		cellStatus.innerHTML = '<span class="badge bg-info" id="cc">참조</span>';
	} else {
		cellStatus.innerHTML = '<span class="badge bg-secondary" id="wait">대기</span>';
	}
	var cellAction = row.insertCell();
	cellAction.innerHTML = '<button type="button" class="btn btn-danger btn-sm" onclick="removeRow(this)">제거</button>';
	
	rowCount = tableBody.rows.length;

	// 행이 5개 미만일 때만 "추가" 버튼 행 추가
	if (rowCount < 6) {
		var addRow = tableBody.insertRow();
		var addCell = addRow.insertCell();
		addRow.classList.add("addButtonRow");
		addCell.colSpan = 6;
		addCell.style.textAlign = "center";
		var buttonId = "addButton" + buttonNumber; // 고유한 버튼 ID 생성
		addCell.innerHTML = '<button type="button" class="btn btn-success btn-sm" onclick="addEmp(this)" id="' + buttonId + '">추가</button>';

		buttonNumber++; // 다음 버튼을 위해 번호 증가
	}
};





// 행 제거 함수
function removeRow(button) {
	var row = button.parentNode.parentNode;
	row.parentNode.removeChild(row);

	// 테이블의 현재 행 개수 확인
	var tableBody = document.querySelector("#RefTable");
	var rowCount = tableBody.rows.length;
	var addButtonExists = document.querySelector("#RefTable .addButtonRow") !== null;

	// 행이 4개 이하이고 "추가" 버튼 행이 없으면 "추가" 버튼 행 추가
	if (!addButtonExists && rowCount <= 4) {
		var addRow = tableBody.insertRow();
		var addCell = addRow.insertCell();
		addCell.colSpan = 6;
		addCell.style.textAlign = "center";
		var buttonId = "addButton" + buttonNumber; // 고유한 버튼 ID 생성
		addRow.classList.add("addButtonRow"); // 클래스를 추가하여 "추가" 버튼 행 식별
		addCell.innerHTML = '<button type="button" class="btn btn-success btn-sm" onclick="addEmp(this)" id="' + buttonId + '">추가</button>';

		buttonNumber++; // 다음 버튼을 위해 번호 증가
	}
}

function removeAddButton() {
	const addButtonRow = document.getElementById("addButtonRow");
	if (addButtonRow) {
		addButtonRow.parentNode.removeChild(addButtonRow);
	}
}

function removeRowById(buttonId) {
	let button = document.getElementById(buttonId);
	if (button) {
		let row = button.closest("tr"); // 버튼이 테이블 행 안에 있다고 가정
		if (row) {
			row.parentNode.removeChild(row);
		}
	}
}



function submitForm() {

	var tableBody = document.querySelector("#RefTable");
	var rowCount = tableBody.rows.length;

	console.log("rowCount : " + rowCount);


	console.log("폼 제출 실행");
	console.log(document.getElementById('Writetitle').value + " " + document.getElementById('Writecontent').value);


	var formData = new FormData();
	formData.append('title', document.getElementById('Writetitle').value);
	formData.append('content', document.getElementById('Writecontent').value);
	formData.append('file', document.getElementById('WriteformFile').files[0]);

	// 테이블 데이터 수집
	var table = document.getElementById('RefTable');
	var rows = table.rows;
	if (rowCount > 0 && rows[rowCount - 1].className.includes("addButtonRow")) {
		rowCount--;
	}

	for (var i = 0; i < rowCount; i++) {
		var cells = rows[i].cells;
		console.log(i + " " + cells[2].textContent);
		formData.append('emp' + i, cells[2].textContent);
		formData.append('state' + i, cells[4].textContent);

	}
	
	formData.append('rowCount', rowCount);
	console.log(formData);

	fetch('../Controller/ApprovalWrite.do', {
		method: 'POST',
		body: formData
	})
		.then(response => response.json())
		.then(result => {
			console.log('Success:', result);
		})
		.catch(error => {
			console.error('Error:', error);
		});
}



