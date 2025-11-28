package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Set character encoding
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");

            // Extract and validate parameters - теперь X может быть массивом
            String[] xParams = request.getParameterValues("x");
            String yParam = request.getParameter("y");
            String rParam = request.getParameter("r");

            if (xParams == null || xParams.length == 0 || yParam == null || rParam == null) {
                sendErrorPage(response, "Missing required parameters: at least one x, y, r", request.getContextPath());
                return;
            }

            double r, y;
            try {
                r = Double.parseDouble(rParam);
                y = Double.parseDouble(yParam);
            } catch (NumberFormatException e) {
                sendErrorPage(response, "Invalid parameter format: parameters must be numbers", request.getContextPath());
                return;
            }

            // Validate parameter ranges
            if (r <= 0 || r > 3) {
                sendErrorPage(response, "Invalid R value: must be between 1 and 3", request.getContextPath());
                return;
            }

            // Validate Y range (-3 to 3)
            if (y < -3 || y > 3) {
                sendErrorPage(response, "Invalid Y value: must be between -3 and 3", request.getContextPath());
                return;
            }

            // Validate each X value and process all points
            List<Point> results = new ArrayList<>();
            double[] allowedX = {-5, -4, -3, -2, -1, 0, 1, 2, 3};

            for (String xParam : xParams) {
                try {
                    double x = Double.parseDouble(xParam);

                    // Validate X values
                    boolean validX = false;
                    for (double allowed : allowedX) {
                        if (Math.abs(x - allowed) < 0.0001) {
                            validX = true;
                            break;
                        }
                    }
                    if (!validX) {
                        sendErrorPage(response, "Invalid X value: " + x + ". Must be one of -5, -4, -3, -2, -1, 0, 1, 2, 3", request.getContextPath());
                        return;
                    }

                    // Measure execution time for each point
                    long before = System.nanoTime();
                    Instant currentInstant = Instant.now();

                    // Check point using updated PointChecker
                    Point result = Checker.handlePointCheck(x, y, r);

                    // Set timestamp and execution time
                    result.setTime(currentInstant.toString());
                    long after = System.nanoTime();
                    result.setTook((after - before) / 1000000 + "ms");

                    // Add to results list
                    results.add(result);

                    // Save to history
                    HttpSession session = request.getSession(true);
                    History.writeHistory(session, result);

                } catch (NumberFormatException e) {
                    sendErrorPage(response, "Invalid X parameter format: " + xParam, request.getContextPath());
                    return;
                }
            }

            // Generate and send HTML response with all results
            sendResultPage(response, results, y, r, request.getContextPath());

        } catch (Exception e) {
            sendErrorPage(response, "Internal server error: " + e.getMessage(), request.getContextPath());
            e.printStackTrace();
        }
    }

    private void sendErrorPage(HttpServletResponse response, String error, String contextPath) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset=\"UTF-8\">");
        out.println("<title>Error</title>");
        out.println("<style>");
        out.println("body { font-family: 'Roboto', sans-serif; margin: 0; background-image: url('" + contextPath + "/static/backgrounds/background.png'); background-size: cover; background-position: center; background-repeat: no-repeat; background-attachment: fixed; color: #ffffff; padding: 20px; }");
        out.println(".error-container { max-width: 600px; margin: 50px auto; padding: 30px; background: rgba(0, 20, 30, 0.85); border: 2px solid rgba(255, 0, 100, 0.6); border-radius: 12px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); backdrop-filter: blur(12px); text-align: center; }");
        out.println("h1 { color: #ff0066; font-family: 'Dela Gothic One', monospace; margin-bottom: 20px; }");
        out.println("a { display: inline-block; margin-top: 20px; padding: 12px 24px; background: linear-gradient(135deg, rgba(0, 255, 255, 0.3), rgba(0, 150, 200, 0.3)); color: white; text-decoration: none; border-radius: 6px; border: 2px solid rgba(0, 255, 255, 0.6); font-family: 'Dela Gothic One', monospace; transition: all 0.3s; }");
        out.println("a:hover { background: linear-gradient(135deg, rgba(0, 255, 255, 0.5), rgba(0, 150, 200, 0.5)); box-shadow: 0 0 20px rgba(0, 255, 255, 0.4); transform: translateY(-2px); }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class=\"error-container\">");
        out.println("<h1>Error</h1>");
        out.println("<p>" + escapeHtml(error) + "</p>");
        out.println("<a href=\"" + contextPath + "/index.jsp\">Return to Home</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    private void sendResultPage(HttpServletResponse response, List<Point> results, double y, double r, String contextPath) throws IOException {
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset=\"UTF-8\">");
        out.println("<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">");
        out.println("<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>");
        out.println("<link href=\"https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap\" rel=\"stylesheet\">");
        out.println("<style>");
        out.println("body { font-family: 'Roboto', sans-serif; margin: 0; background-image: url('" + contextPath + "/static/backgrounds/background.png'); background-size: cover; background-position: center; background-repeat: no-repeat; background-attachment: fixed; color: #ffffff; padding: 20px; }");
        out.println("h1 { font-family: 'Dela Gothic One', monospace; font-style: normal; font-weight: 400; text-align: center; color: #00ffff; text-shadow: 0 0 10px rgba(0, 255, 255, 0.7); }");
        out.println("h1::before, h1::after { content: \"⦿\"; }");
        out.println(".header { width: stretch; border-radius: 15px; margin: 10px; margin-bottom: 30px; padding: 15px; background: rgba(0, 30, 40, 0.8); border: 2px solid rgba(0, 255, 255, 0.4); box-shadow: 0 0 30px rgba(0, 255, 255, 0.2); backdrop-filter: blur(10px); text-align: center; }");
        out.println(".card { background: rgba(0, 20, 30, 0.85); border: 1px solid rgba(0, 255, 255, 0.3); border-radius: 12px; padding: 25px; margin: 20px auto; max-width: 800px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); backdrop-filter: blur(12px); }");
        out.println(".card-success { background: rgba(0, 60, 40, 0.8); border: 1px solid rgba(0, 255, 150, 0.4); box-shadow: 0 0 20px rgba(0, 255, 150, 0.2); }");
        out.println(".card-failure { background: rgba(60, 0, 20, 0.8); border: 1px solid rgba(255, 0, 100, 0.4); box-shadow: 0 0 20px rgba(255, 0, 100, 0.2); }");
        out.println("table { width: 100%; border-collapse: collapse; margin: 20px 0; }");
        out.println("table th, table td { padding: 15px; text-align: left; border-bottom: 1px solid rgba(0, 255, 255, 0.2); }");
        out.println("table th { background: rgba(0, 255, 255, 0.1); font-weight: bold; color: #00ffff; }");
        out.println(".result-display { text-align: center; font-size: 28px; font-weight: bold; margin: 25px 0; padding: 20px; border-radius: 10px; background: rgba(0, 0, 0, 0.3); }");
        out.println(".result-success { color: #00ff88; text-shadow: 0 0 10px rgba(0, 255, 136, 0.5); }");
        out.println(".result-failure { color: #ff0066; text-shadow: 0 0 10px rgba(255, 0, 102, 0.5); }");
        out.println(".link-button { display: inline-block; padding: 15px 30px; margin: 20px auto; text-align: center; text-decoration: none; font-family: 'Dela Gothic One', monospace; font-size: large; border-radius: 8px; background: linear-gradient(135deg, rgba(0, 255, 255, 0.3), rgba(0, 150, 200, 0.3)); border: 2px solid rgba(0, 255, 255, 0.6); color: #ffffff; text-shadow: 0 0 5px rgba(0, 255, 255, 0.7); transition: all 0.3s; }");
        out.println(".link-button:hover { background: linear-gradient(135deg, rgba(0, 255, 255, 0.5), rgba(0, 150, 200, 0.5)); box-shadow: 0 0 20px rgba(0, 255, 255, 0.4); transform: translateY(-2px); }");
        out.println(".link-container { text-align: center; margin-top: 30px; }");
        out.println("</style>");
        out.println("<title>Area Check Results</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class=\"header\">");
        out.println("<h1>Ожеховский Александр Сергеевич P3231 466944</h1>");
        out.println("</div>");

        // Display parameters
        out.println("<div class=\"card\">");
        out.println("<h2 style=\"color: #00ffff; text-align: center;\">Received Parameters</h2>");
        out.println("<table>");
        out.println("<tr><th>Parameter</th><th>Value</th></tr>");

        // Display all X values
        StringBuilder xValues = new StringBuilder();
        for (Point result : results) {
            if (xValues.length() > 0) {
                xValues.append(", ");
            }
            xValues.append(result.getX());
        }
        out.println("<tr><td>X</td><td>" + xValues.toString() + "</td></tr>");
        out.println("<tr><td>Y</td><td>" + y + "</td></tr>");
        out.println("<tr><td>R</td><td>" + r + "</td></tr>");
        out.println("</table>");
        out.println("</div>");

        // Display results for each point
        for (Point result : results) {
            boolean success = result.isSuccess();
            String cardClass = success ? "card-success" : "card-failure";
            String resultClass = success ? "result-success" : "result-failure";
            String resultText = success ? "✅ Point is within the area" : "❌ Point is outside the area";
            String resultStatus = success ? "Success" : "Failure";
            String time = result.getTime() != null ? escapeHtml(result.getTime()) : "N/A";
            String took = result.getTook() != null ? escapeHtml(result.getTook()) : "N/A";

            out.println("<div class=\"card " + cardClass + "\">");
            out.println("<h2 style=\"color: #00ffff; text-align: center;\">Check Result for X=" + result.getX() + "</h2>");
            out.println("<div class=\"result-display " + resultClass + "\">" + escapeHtml(resultText) + "</div>");
            out.println("<table>");
            out.println("<tr><th>Property</th><th>Value</th></tr>");
            out.println("<tr><td>Result</td><td>" + escapeHtml(resultStatus) + "</td></tr>");
            out.println("<tr><td>Coordinates</td><td>(" + result.getX() + ", " + y + ")</td></tr>");
            out.println("<tr><td>Radius</td><td>" + r + "</td></tr>");
            out.println("<tr><td>Timestamp</td><td>" + time + "</td></tr>");
            out.println("<tr><td>Execution Time</td><td>" + took + "</td></tr>");
            out.println("</table>");
            out.println("</div>");
        }

        out.println("<div class=\"link-container\">");
        out.println("<a href=\"" + contextPath + "/index.jsp\" class=\"link-button\">Return to Main Page</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

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
}