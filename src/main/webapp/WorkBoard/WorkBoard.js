let buttonNumber = 0;

document.addEventListener("DOMContentLoaded", function() {

	var table = document.querySelector('.table');

	table.addEventListener('click', function(event) {
		var target = event.target;

		if (target.classList.contains('btn-success')) {
			console.log("승인버튼 클릭");
			var code = target.getAttribute('data-code');
			approval(code);
		} else if (target.classList.contains('btn-danger')) {
			var code = target.getAttribute('data-code');
			reject(code);
		}
	});
	let writeButton = document.getElementById("writeButton");
	let docs = document.getElementsByClassName("docs");

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

	Array.from(docs).forEach(function(doc) {
		doc.addEventListener("click", function() {
			let idxNum = this.getAttribute("id"); // 현재 요소의 id 속성 가져오기
			let xhr = new XMLHttpRequest();
			let htmlFilePath = "../Controller/DocDetail.do?idx=" + idxNum; // 쿼리 파라미터 추가
			//			let htmlFilePath = "../WorkBoard/DocDetail.jsp";

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					let detailElement = document.querySelector(".Detail");
					detailElement.innerHTML = xhr.responseText;
				}
			};
			xhr.open("GET", htmlFilePath, true);
			xhr.send();
		});
	});
});

function openNewJSP() {
	// 새 창의 크기
	const width = 750;
	const height = 450;

	// 화면 중앙에 위치시키기 위한 left와 top 값 계산
	const left = window.screen.width / 2 - width / 2;
	const top = window.screen.height / 2 - height / 2;

	// 새로 열 JSP 파일의 URL
	let newJSPURL = "../WorkBoard/References.jsp";

	// 새 창 열기
	window.open(newJSPURL, "_blank", `width=${width},height=${height},top=${top},left=${left}`);
}

function addEmp(button) {
	// 새 창의 크기
	const width = 750;
	const height = 450;

	// 화면 중앙에 위치시키기 위한 left와 top 값 계산
	const left = window.screen.width / 2 - width / 2;
	const top = window.screen.height / 2 - height / 2;

	console.log(button.id);

	let newJSPURL = "../WorkBoard/addEMP.jsp?buttonId=" + button.id;

	window.open(newJSPURL, "_blank", `width=${width},height=${height},top=${top},left=${left}`);
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
	if (rowCount < 5) {
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
}





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

	// JavaScript
	fetch('../Controller/ApprovalWrite.do', {
		method: 'POST',
		body: formData
	})
		.then(response => response.json())
		.then(result => {
			alert("글작성이 완료 되었습니다.");
			window.location.reload(); // 페이지 새로 고침
		})
		.catch(error => {
			console.error('Error:', error);
		});
}

function approval(code) {
	fetch('../Controller/DocApproval.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: 'code=' + code
	})
		.then(response => response.json())
		.then(data => {
			console.log(data);
			alert("승인 완료");
			window.location.reload(); // 페이지 새로 고침
		})
		.catch(error => {
			console.error('Error:', error);
		});
}


function reject(code) {
	fetch('../Controller/DocReject.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: 'code=' + code
	})
		.then(response => response.json())
		.then(data => {
			console.log(data);
			alert("거절 완료");
			window.location.reload(); // 페이지 새로 고침
		})
		.catch(error => {
			console.error('Error:', error);
		});
}
function dateChanged() {
	var dateValue = document.getElementById('datePicker').value;
	var newUrl = '../Controller/selectedDateOnWorkBoard.do?date=' + encodeURIComponent(dateValue);
	window.location.href = newUrl;  // 현재 페이지를 새 URL로 리다이렉트
}



// 게시판 정보를 업데이트하는 함수
function updateTableWithData(data) {
	const tableBody = document.getElementById("boarlist").getElementsByTagName("tbody")[0];
	tableBody.innerHTML = ''; // 기존 테이블 내용 제거

	// JSON 데이터에서 정보를 추출하고 게시판에 추가합니다.
	data.list.forEach((item, index) => {
		const row = tableBody.insertRow();

		// INDEX
		const cellIndex = row.insertCell(0);
		cellIndex.textContent = index + 1;
		cellIndex.style.textAlign = "center";

		// TITLE
		const cellTitle = row.insertCell(1);
		const titleLink = document.createElement("a");
		titleLink.className = "docs";
		titleLink.id = item.idx;
		titleLink.textContent = item.approval_doc_title;
		cellTitle.appendChild(titleLink);
		cellTitle.style.textAlign = "center";

		// TEAM
		const cellTeam = row.insertCell(2);
		cellTeam.textContent = item.team;
		cellTeam.style.textAlign = "center";

		// EMP
		const cellEmp = row.insertCell(3);
		cellEmp.textContent = item.emp_num;
		cellEmp.style.textAlign = "center";

		// DATE
		const cellDate = row.insertCell(4);
		cellDate.textContent = item.approval_doc_date;
		cellDate.style.textAlign = "center";

		// 파일 다운로드 링크
		const cellFile = row.insertCell(5);
		cellFile.style.textAlign = "center";
		if (item.approval_doc_ofile) {
			const downloadLink = document.createElement("a");
			downloadLink.href = ""; // 여기에 다운로드 링크 주소를 넣으세요
			downloadLink.textContent = "[다운로드]";
			cellFile.appendChild(item.approval_doc_ofile);
			cellFile.appendChild(downloadLink);
		}

		// STATUS
		const cellStatus = row.insertCell(6);
		cellStatus.textContent = item.doc_status;
		cellStatus.style.textAlign = "cetner";
	});

	// 페이지 정보를 출력하거나 필요한 다른 작업을 수행합니다.
	console.log("Total Count: " + data.map.totalCount);
	console.log("Paging HTML: " + data.map.pagingImg);

	// Attach a click event listener to the table container
	document.querySelector('.table').addEventListener('click', function(event) {
		var target = event.target;

		// Check if a title was clicked
		if (target.classList.contains('docs')) {
			var idxNum = target.getAttribute("id"); // Get the ID from the clicked title
			var xhr = new XMLHttpRequest();
			var htmlFilePath = "../Controller/DocDetail.do?idx=" + idxNum;

			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					var detailElement = document.querySelector(".Detail");
					detailElement.innerHTML = xhr.responseText;
				}
			};
			xhr.open("GET", htmlFilePath, true);
			xhr.send();
		}
	});

}


