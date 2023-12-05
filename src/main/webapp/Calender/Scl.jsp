<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Table with Button Cells</title>
    <style>
        table {
            border-collapse: collapse;
        }

        button {
            width: 100%;
            height: 100%;
            padding: 0;
            border: none;
            background: none;
            cursor: pointer;
        }

        td {
            padding: 0;
        }
    </style>
</head>
<body>

<table>
    <thead>
        <tr>
            <th>Date</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 1; i <= 5; i++) {
        %>
            <tr>
                <td><button onclick="alert('Clicked on <%=i%>');"><%=i%></button></td>
                <td><button onclick="alert('Action <%=i%>');">Action <%=i%></button></td>
            </tr>
        <%
            }
        %>
    </tbody>
</table>

</body>
</html>