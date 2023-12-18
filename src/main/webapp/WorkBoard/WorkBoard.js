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





