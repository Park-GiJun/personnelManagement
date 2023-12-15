var host = window.location.hostname; // 호스트명
var port = window.location.port; // 포트번호

console.log("Host: " + host);
console.log("Port: " + port);
var socket = new WebSocket("ws://" + host + ":" + port
	+ "/PersonnelManagement/websocket");

socket.onopen = function(event) {
	console.log("WebSocket 연결됨");
};

socket.onclose = function(event) {
	console.log("WebSocket 연결 종료됨");
};

socket.onerror = function(error) {
	console.error("WebSocket 에러 발생: ", error);
};

socket.onmessage = function(event) {
	// 서버로부터 메시지 수신 시 알림창 띄우기
	var message = event.data;
	showAlert(message);
};

// showAlert 함수 정의
function showAlert(message) {
	window.alert(message);
}