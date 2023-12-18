let selectedempNum = "0";
let selectedArr = [];

function getQueryParam(param) {
    var searchParams = new URLSearchParams(window.location.search);
    return searchParams.get(param);
}

let buttonId = getQueryParam("buttonId");

window.onload = function() {
	console.log(buttonId);
	fetch('../Controller/PersonList.do', {
		method: 'POST'
	})
		.then(response => response.json())
		.then(data => {
			const treeHtml = createTreeHtml(data);
			console.log(data);
			document.getElementById('organizationTree').innerHTML = treeHtml;
			$('#organizationTree').jstree().on("changed.jstree", function(e, data) {
				const nodeId = data.selected[0];
				const selectedNode = document.querySelector(`[id="${nodeId}"]`);
				if (selectedNode) {
					const departName = selectedNode.getAttribute('data-depart');
					const name = selectedNode.getAttribute('data-name');
					const empNum = selectedNode.getAttribute('data-empnum');
					const empGrade = selectedNode.getAttribute('data-empgrade');
					selectedempNum = empNum;
					console.log(`EmpNum: ${empNum}`);
					console.log(`selectedempNum: ${selectedempNum}`);
				}
			});
		})
		.catch(error => {
			console.error('Error:', error);
		});
	const selectElement = document.getElementById('badge-select');
	if (selectElement) {
		const badges = [
			{ value: '대기', label: '<span class="badge bg-secondary">대기</span>' },
			{ value: '참조', label: '<span class="badge bg-info">참조</span>' },
		];

		// Choices 인스턴스를 전역 변수에 할당
		choices = new Choices(selectElement, {
			searchEnabled: false,
			itemSelectText: ''
		});

		badges.forEach(badge => {
			choices.setChoices([{ value: badge.value, label: badge.label, selected: false }], 'value', 'label', false);
		});
	}

	document.getElementById('choiceBtn').addEventListener('click', addTable);
};

// 선택된 옵션 값을 가져오는 함수
function getSelectedOptionValue() {
	if (choices) {
		return choices.getValue(true);
	}
	return null; // choices 객체가 정의되지 않은 경우 null 반환
}


function createTreeHtml(data) {
	let html = '<ul>';
	data.forEach(depart => {
		html += `<li data-depart="${depart.cDepartname}">${depart.cDepartname}<ul>`;
		depart.departs.forEach(team => {
			html += `<li>${team.cTeamname}<ul>`;
			for (const [name, person] of Object.entries(team.teams)) {
				html += `<li data-depart="${depart.cDepartname}" data-name="${name}" data-empnum="${person.empNum}" data-empgrade="${person.emp_grade}">${name} - ${person.empNum}, ${person.emp_grade}</li>`;
			}
			html += '</ul></li>';
		});
		html += '</ul></li>';
	});
	html += '</ul>';
	return html;
}

function addTable() {
	const selectedValue = getSelectedOptionValue();
	console.log('선택된 옵션 값:', selectedValue);
	const data = {
		selectedEmpNums: selectedempNum
	};

	fetch('../Controller/addEMP.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify(data),
	})
		.then(response => response.json())
		.then(data => {
			console.log('서버 응답:', data);
			alert("신청이 완료 되었습니다.");
			window.opener.addTableEmp(data, selectedValue);
			window.opener.removeRowById(buttonId);
			window.close();
		});
}



