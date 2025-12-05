<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.PointResult" %>
<%@ page import="java.util.List" %>
<%
    // Получаем данные из запроса
    String errorMessage = (String) request.getAttribute("errorMessage");
    Boolean showError = (Boolean) request.getAttribute("showError");
    Boolean showResults = (Boolean) request.getAttribute("showResults");
    List<PointResult> results = (List<PointResult>) request.getAttribute("results");
    Double y = (Double) request.getAttribute("y");
    Double r = (Double) request.getAttribute("r");

    String contextPath = request.getContextPath();

    // Устанавливаем значения по умолчанию
    if (showError == null) showError = false;
    if (showResults == null) showResults = false;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', sans-serif; margin: 0; background-image: url('<%= contextPath %>/static/backgrounds/background.png'); background-size: cover; background-position: center; background-repeat: no-repeat; background-attachment: fixed; color: #ffffff; padding: 20px; }
        h1 { font-family: 'Dela Gothic One', monospace; font-style: normal; font-weight: 400; text-align: center; color: #00ffff; text-shadow: 0 0 10px rgba(0, 255, 255, 0.7); }
        h1::before, h1::after { content: "⦿"; }
        .header { width: stretch; border-radius: 15px; margin: 10px; margin-bottom: 30px; padding: 15px; background: rgba(0, 30, 40, 0.8); border: 2px solid rgba(0, 255, 255, 0.4); box-shadow: 0 0 30px rgba(0, 255, 255, 0.2); backdrop-filter: blur(10px); text-align: center; }
        .card { background: rgba(0, 20, 30, 0.85); border: 1px solid rgba(0, 255, 255, 0.3); border-radius: 12px; padding: 25px; margin: 20px auto; max-width: 800px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); backdrop-filter: blur(12px); }
        .card-success { background: rgba(0, 60, 40, 0.8); border: 1px solid rgba(0, 255, 150, 0.4); box-shadow: 0 0 20px rgba(0, 255, 150, 0.2); }
        .card-failure { background: rgba(60, 0, 20, 0.8); border: 1px solid rgba(255, 0, 100, 0.4); box-shadow: 0 0 20px rgba(255, 0, 100, 0.2); }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        table th, table td { padding: 15px; text-align: left; border-bottom: 1px solid rgba(0, 255, 255, 0.2); }
        table th { background: rgba(0, 255, 255, 0.1); font-weight: bold; color: #00ffff; }
        .result-display { text-align: center; font-size: 28px; font-weight: bold; margin: 25px 0; padding: 20px; border-radius: 10px; background: rgba(0, 0, 0, 0.3); }
        .result-success { color: #00ff88; text-shadow: 0 0 10px rgba(0, 255, 136, 0.5); }
        .result-failure { color: #ff0066; text-shadow: 0 0 10px rgba(255, 0, 102, 0.5); }
        .link-button { display: inline-block; padding: 15px 30px; margin: 20px auto; text-align: center; text-decoration: none; font-family: 'Dela Gothic One', monospace; font-size: large; border-radius: 8px; background: linear-gradient(135deg, rgba(0, 255, 255, 0.3), rgba(0, 150, 200, 0.3)); border: 2px solid rgba(0, 255, 255, 0.6); color: #ffffff; text-shadow: 0 0 5px rgba(0, 255, 255, 0.7); transition: all 0.3s; }
        .link-button:hover { background: linear-gradient(135deg, rgba(0, 255, 255, 0.5), rgba(0, 150, 200, 0.5)); box-shadow: 0 0 20px rgba(0, 255, 255, 0.4); transform: translateY(-2px); }
        .link-container { text-align: center; margin-top: 30px; }
        .error-container { max-width: 600px; margin: 50px auto; padding: 30px; background: rgba(0, 20, 30, 0.85); border: 2px solid rgba(255, 0, 100, 0.6); border-radius: 12px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); backdrop-filter: blur(12px); text-align: center; }
        .error-container h1 { color: #ff0066; font-family: 'Dela Gothic One', monospace; margin-bottom: 20px; }
        .error-container a { display: inline-block; margin-top: 20px; padding: 12px 24px; background: linear-gradient(135deg, rgba(0, 255, 255, 0.3), rgba(0, 150, 200, 0.3)); color: white; text-decoration: none; border-radius: 6px; border: 2px solid rgba(0, 255, 255, 0.6); font-family: 'Dela Gothic One', monospace; transition: all 0.3s; }
        .error-container a:hover { background: linear-gradient(135deg, rgba(0, 255, 255, 0.5), rgba(0, 150, 200, 0.5)); box-shadow: 0 0 20px rgba(0, 255, 255, 0.4); transform: translateY(-2px); }
    </style>
    <title><%= showError ? "Error" : "Area Check Results" %></title>
</head>
<body>
    <div class="header">
        <h1>Ожеховский Александр Сергеевич P3231 466944</h1>
    </div>

    <% if (showError && errorMessage != null) { %>
        <!-- Отображение ошибки -->
        <div class="error-container">
            <h1>Error</h1>
            <p><%= escapeHtml(errorMessage) %></p>
            <a href="<%= contextPath %>/index.jsp">Return to Home</a>
        </div>
    <% } else if (showResults && results != null && !results.isEmpty()) { %>
        <!-- Отображение успешных результатов -->
        <div class="card">
            <h2 style="color: #00ffff; text-align: center;">Received Parameters</h2>
            <table>
                <tr><th>Parameter</th><th>Value</th></tr>

                <!-- Display all X values -->
                <tr><td>X</td><td>
                    <%
                        StringBuilder xValues = new StringBuilder();
                        for (PointResult result : results) {
                            if (xValues.length() > 0) {
                                xValues.append(", ");
                            }
                            xValues.append(String.format("%.3f", result.getX()));
                        }
                        out.print(xValues.toString());
                    %>
                </td></tr>
                <tr><td>Y</td><td><%= String.format("%.3f", y) %></td></tr>
                <tr><td>R</td><td><%= String.format("%.3f", r) %></td></tr>
            </table>
        </div>

        <!-- Display results for each point -->
        <% for (PointResult result : results) {
            boolean success = result.isSuccess();
            String cardClass = success ? "card-success" : "card-failure";
            String resultClass = success ? "result-success" : "result-failure";
            String resultText = success ? "✅ Point is within the area" : "❌ Point is outside the area";
            String resultStatus = success ? "Success" : "Failure";
            String time = result.getTime() != null ? escapeHtml(result.getTime()) : "N/A";
            String took = result.getTook() != null ? escapeHtml(result.getTook()) : "N/A";
        %>
            <div class="card <%= cardClass %>">
                <h2 style="color: #00ffff; text-align: center;">Check Result for X=<%= String.format("%.3f", result.getX()) %></h2>
                <div class="result-display <%= resultClass %>"><%= escapeHtml(resultText) %></div>
                <table>
                    <tr><th>Property</th><th>Value</th></tr>
                    <tr><td>Result</td><td><%= escapeHtml(resultStatus) %></td></tr>
                    <tr><td>Coordinates</td><td>(<%= String.format("%.3f", result.getX()) %>, <%= String.format("%.3f", y) %>)</td></tr>
                    <tr><td>Radius</td><td><%= String.format("%.3f", r) %></td></tr>
                    <tr><td>Timestamp</td><td><%= time %></td></tr>
                    <tr><td>Execution Time</td><td><%= took %></td></tr>
                </table>
            </div>
        <% } %>

        <div class="link-container">
            <a href="<%= contextPath %>/index.jsp" class="link-button">Return to Main Page</a>
        </div>
    <% } else { %>
        <!-- Если что-то пошло не так (ни ошибка, ни результаты) -->
        <div class="error-container">
            <h1>Error</h1>
            <p>No data to display. Something went wrong.</p>
            <a href="<%= contextPath %>/index.jsp">Return to Home</a>
        </div>
    <% } %>
</body>
</html>

<%!
    private String escapeHtml(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>