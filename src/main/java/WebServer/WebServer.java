package WebServer;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.HandshakeResponse;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.ServerEndpointConfig;

@ServerEndpoint(value = "/websocket", configurator = WebServer.HttpSessionConfigurator.class)
public class WebServer {

	private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());
	private static final Map<Session, Integer> sessionGradeMap = Collections.synchronizedMap(new HashMap<>());
	private static final Map<Session, String> sessionIDMap = Collections.synchronizedMap(new HashMap<>());

	@OnOpen
	public void onOpen(Session session, EndpointConfig config) {
		sessions.add(session);

		// 현재 세션의 사용자 ID 가져오기
		HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
		String myValue = (String) httpSession.getAttribute("userId");
		int grade = (int) httpSession.getAttribute("userGrade");

		sessionGradeMap.put(session, grade);
		sessionIDMap.put(session, myValue);

		System.out.println(myValue + "//" + grade);
		System.out.println("WebSocket 연결됨");

		printAllSessionGrades();
	}

	@OnClose
	public void onClose(Session session) {
		sessions.remove(session);

		System.out.println("WebSocket 연결 종료됨");
	}

	@OnError
	public void onError(Throwable error) {
		System.err.println("WebSocket 오류 발생: " + error.getMessage());
	}

	public static void sendReservationNotification(String message) {
		for (Session session : sessions) {
			if (session.isOpen() && sessionGradeMap.containsKey(session) && sessionGradeMap.get(session) <= 3) {
				try {
					session.getBasicRemote().sendText(message);
				} catch (IOException e) {
					System.err.println("WebSocket 알림 전송 오류: " + e.getMessage());
				}
			}
		}
	}

	public static class HttpSessionConfigurator extends ServerEndpointConfig.Configurator {
		@Override
		public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
			// WebSocket 핸드쉐이크 과정에서 HttpSession 얻어오기
			HttpSession httpSession = (HttpSession) request.getHttpSession();
			config.getUserProperties().put(HttpSession.class.getName(), httpSession);
		}
	}

	@SuppressWarnings("unused")
	private void printAllSessionGrades() {
		synchronized (sessionIDMap) {
			for (Map.Entry<Session, Integer> entry : sessionGradeMap.entrySet()) {
				Session session = entry.getKey();
				Integer id = entry.getValue();
				System.out.println("Session ID: " + session.getId() + " | ID: " + id);
			}
		}
		synchronized (sessionGradeMap) {
			for (Map.Entry<Session, Integer> entry : sessionGradeMap.entrySet()) {
				Session session = entry.getKey();
				Integer grade = entry.getValue();
				System.out.println("Session ID: " + session.getId() + " | Grade: " + grade);
			}
		}

	}

}
