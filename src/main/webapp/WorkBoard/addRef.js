let selectedempNum = "0";
let selectedArr = [];

window.onload = function() {
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
	document.getElementById('addButton').addEventListener('click', addPerson);
	document.getElementById('deleteButton').addEventListener('click', deleteSelectedPerson);

};

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

function addPerson() {
	if (selectedempNum !== "0") {
		console.log(selectedempNum);
		const select = document.getElementById('exampleSelect2');
		const option = new Option(` ${selectedempNum}`, selectedempNum);
		select.add(option);
		selectedArr.push(selectedempNum);
		console.log(selectedArr);
	}
}

function deleteSelectedPerson() {
	const select = document.getElementById('exampleSelect2');
	for (let i = select.options.length - 1; i >= 0; i--) {
		if (select.options[i].selected) {
			select.remove(i);
			selectedArr.pop(selectedArr);
			console.log(selectedArr);
		}
	}
}

function submitRef() {
	const inputSmallValue = document.getElementById('inputSmall').value;
	console.log(inputSmallValue);
	const data = {
		inputSmall: inputSmallValue,
		selectedEmpNums: selectedArr
	};

	fetch('../Controller/addRef.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify(data),
	})
		.then(() => {
			console.log('서버 응답:');
			alert("신청이 완료 되었습니다.");
			window.close();
		})
		.catch(error => {
			console.error('에러:', error);
		});
}




