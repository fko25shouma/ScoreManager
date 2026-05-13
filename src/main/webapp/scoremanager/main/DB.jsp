<%@ page import="dao.TableDao,java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
TableDao dao = new TableDao();

List<String> tables = null;
List<Map<String, Object>> data = null;
String table = request.getParameter("table");

try {
    tables = dao.getTables();

    if (table != null) {
        data = dao.getData(table);
    }

} catch (Exception e) {
%>
    <p style="color:red;">エラー発生</p>
    <pre>
<%
    e.printStackTrace(new java.io.PrintWriter(out));
%>
    </pre>
<%
}
%>

<h2>DB接続＆テーブル確認</h2>

<h3>テーブル一覧</h3>
<ul>
<% if (tables != null) { %>
    <% for (String t : tables) { %>
        <li><a href="?table=<%= t %>"><%= t %></a></li>
    <% } %>
<% } else { %>
    <li>テーブル取得失敗</li>
<% } %>
</ul>

<% if (data != null && !data.isEmpty()) { %>
8
<h3><%= table %></h3>

<table border="1">
<tr>
<%
for (String col : data.get(0).keySet()) {
%>
    <th><%= col %></th>
<%
}
%>
</tr>

<%
for (Map<String, Object> row : data) {
%>
<tr>
<%
    for (Object v : row.values()) {
%>
    <td><%= v %></td>
<%
    }
%>
</tr>
<%
}
%>
</table>

<% } %>