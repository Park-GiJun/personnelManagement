let clickedDate;

let section;

function generateCalendar() {
	const today = new Date();
	const currentMonth = today.getMonth();
	const currentYear = today.getFullYear();

	// 다음 달의 첫째 날짜를 가져옵니다.
	const nextMonthFirstDay = new Date(currentYear, currentMonth + 1, 1).getDate();

	const firstDayOfMonth = new Date(currentYear, currentMonth, 1).getDay();
	const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();

	// 다음 달의 날짜를 표시하기 시작할 카운터입니다.
	let nextMonthDayCounter = 1;

	const displayMonth = document.getElementById('displayMonth');
	const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	displayMonth.textContent = monthNames[currentMonth];

	const calendarBody = document.getElementById('calendar').getElementsByTagName('tbody')[0];
	calendarBody.innerHTML = '';

	let date = 1;
	for (let i = 0; i < 6; i++) {
		let row = document.createElement('tr');

		for (let j = 0; j < 7; j++) {
			let cell = document.createElement('td');
			cell.classList.add('top-right');

			if (i === 0 && j < firstDayOfMonth) {
				// 첫째 주에서 1일 이전의 칸을 공란으로 설정합니다.
				cell.appendChild(document.createTextNode(''));
			} else if (date > daysInMonth) {
				// 이번 달의 날짜가 끝나면 다음 달의 날짜로 채웁니다 (또는 공란으로 남겨둘 수 있습니다).
				cell.classList.add('next-month');  // 다음 달 날짜임을 표시하는 클래스를 추가할 수 있습니다.
				let cellText = document.createTextNode(nextMonthDayCounter);  // 다음 달 날짜
				cell.appendChild(cellText);
				nextMonthDayCounter++;
			} else {
				// 이번 달의 날짜를 설정합니다.
				let cellText = document.createTextNode(date);
				cell.appendChild(cellText);

				if (date === today.getDate() && currentMonth === today.getMonth()) {
					cell.classList.add('today');
				}
				(function(currentDate) {
					cell.addEventListener('click', function() {
						clickedDate = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(currentDate).padStart(2, '0')}`;
						console.log(clickedDate);
						var headerDate = document.getElementById('headerDate');
						headerDate.textContent = clickedDate;

						// 사이드바를 열기
						var sidebar = document.getElementById('sidebar');
						sidebar.style.width = '250px';  // 사이드바 너비를 설정하여 사이드바를 열습니다.
					});
				})(date);
				date++;
			}
			row.appendChild(cell);
		}
		calendarBody.appendChild(row);
	}
}

function generateSelect() {
	const today = new Date();
	const currentYear = today.getFullYear();
	const currentMonth = today.getMonth() + 1; // JavaScript에서 월은 0부터 시작하므로 1을 더합니다.
	const selectMonth = document.getElementById('selectMonth');
	const selectYear = document.getElementById('selectYear');

	selectYear.innerHTML = '';
	selectMonth.innerHTML = '';

	// 연도 선택
	for (let i = 0; i < 10; i++) {
		let yearOption = document.createElement('option');
		yearOption.value = currentYear - 5 + i;
		yearOption.textContent = currentYear - 5 + i;

		// 현재 연도가 선택되도록 설정
		if (currentYear === currentYear - 5 + i) {
			yearOption.selected = true;
		}

		selectYear.appendChild(yearOption);
	}

	// 월 선택
	for (let i = 1; i <= 12; i++) {
		let monthOption = document.createElement('option');
		monthOption.value = i;
		monthOption.textContent = i < 10 ? '0' + i : i;

		// 현재 월이 선택되도록 설정
		if (currentMonth === i) {
			monthOption.selected = true;
		}

		selectMonth.appendChild(monthOption);
	}
}

document.addEventListener('DOMContentLoaded', (event) => {
	var sidebarToggle = document.getElementById('sidebarToggle');
	sidebarToggle.addEventListener('click', function() {
		var sidebar = document.getElementById('sidebar');
		if (sidebar.style.width === '250px') {
			sidebar.style.width = '0';
		} else {
			sidebar.style.width = '250px';
		}
	});
});

function addDiary() {
    var inputText = prompt(clickedDate + "의 일정을 입력해주세요.");

    if (inputText) {

        var sidebar = document.getElementById('sidebar');

        var entryContainer = document.createElement('div');
        entryContainer.classList.add('diary-entry-container');
        
        var newCheckBox = document.createElement('input');
        newCheckBox.type = 'checkbox';
        newCheckBox.classList.add('form-check-input');
        
        var newEntry = document.createElement('h5');
        newEntry.textContent = inputText;
        newEntry.classList.add('text-success', 'diary-text');

        // Flexbox를 사용하여 체크박스와 텍스트를 가로로 배치합니다.
        entryContainer.style.display = 'flex';
        entryContainer.style.alignItems = 'center';  // 위아래로 중앙 정렬
        entryContainer.style.gap = '10px';  // 요소 사이의 간격 설정

        entryContainer.appendChild(newCheckBox);
        entryContainer.appendChild(newEntry);
        sidebar.appendChild(entryContainer);
    }
}


function deleteDiary() {
	// 사이드바 내의 모든 일정 컨테이너를 가져옵니다.
	var entries = document.getElementsByClassName('diary-entry-container');

	// 일정 컨테이너 목록을 역순으로 순회합니다.
	// 역순으로 순회하는 이유는 삭제 과정 중에 컬렉션의 인덱스가 변경되기 때문입니다.
	for (let i = entries.length - 1; i >= 0; i--) {
		let entry = entries[i];
		let checkBox = entry.querySelector('input[type="checkbox"]');

		// 체크박스가 선택되어 있다면 해당 일정 항목을 삭제합니다.
		if (checkBox && checkBox.checked) {
			sidebar.removeChild(entry);
		}
	}
}

function company() {
	section = 'company';
	console.log(section);

}

function team() {
	section = 'team';
	console.log(section);
}

function personal() {
	section = 'personal';
	console.log(section);
}

function vacation() {
	section = 'vacation';
	console.log(section);
}

window.onload = function() {
	generateCalendar();
	generateSelect();

	const today = new Date();
	const currentMonth = today.getMonth();
	const currentYear = today.getFullYear();
	const currentDate = today.getDate();  // 현재 날짜를 가져옵니다.

	// 기본적으로 오늘 날짜를 'clickedDate'에 설정합니다.
	let clickedDate = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}-${String(currentDate).padStart(2, '0')}`;

	console.log("기본 설정된 오늘 날짜: ", clickedDate);
};

