package Controller;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import Reference.ReferenceDAO;

@WebServlet("/Controller/addRef.do")
public class AddRefController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
	    StringBuilder sb = new StringBuilder();
	    BufferedReader reader = request.getReader();
	    String line;
	    while ((line = reader.readLine()) != null) {
	        sb.append(line);
	    }

	    String jsonString = sb.toString();
	    try {
	        JSONObject jsonObject = new JSONObject(jsonString);
	        String inputSmall = jsonObject.getString("inputSmall");
	        JSONArray jsonArray = jsonObject.getJSONArray("selectedEmpNums");

	        System.out.println("inputSmall: " + inputSmall);
	        for (int i = 0; i < jsonArray.length(); i++) {
	            System.out.println("selectedEmpNum: " + jsonArray.getString(i));
	        }
	        
	        ReferenceDAO dao = new ReferenceDAO();
	        dao.addRef(jsonArray, inputSmall);
	        
	        dao.close();

	    } catch (JSONException e) {
	        e.printStackTrace();
	    }
	}
}