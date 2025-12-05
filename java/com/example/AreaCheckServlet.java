package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
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

            // Extract and validate parameters
            String[] xParams = request.getParameterValues("x");
            String yParam = request.getParameter("y");
            String rParam = request.getParameter("r");
            String source = request.getParameter("source");

            if (xParams == null || xParams.length == 0 || yParam == null || rParam == null) {
                request.setAttribute("errorMessage", "Missing required parameters: at least one x, y, r");
                request.setAttribute("showError", true);
                request.getRequestDispatcher("/result.jsp").forward(request, response);
                return;
            }

            double r, y;
            try {
                r = Double.parseDouble(rParam);
                y = Double.parseDouble(yParam);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid parameter format: parameters must be numbers");
                request.setAttribute("showError", true);
                request.getRequestDispatcher("/result.jsp").forward(request, response);
                return;
            }

            // Validate R parameter range
            if (r <= 0 || r > 3) {
                request.setAttribute("errorMessage", "Invalid R value: must be between 1 and 3");
                request.setAttribute("showError", true);
                request.getRequestDispatcher("/result.jsp").forward(request, response);
                return;
            }

            // Validate Y range depending on source
            if (source == null || "form".equals(source)) {
                if (y < -3 || y > 3) {
                    request.setAttribute("errorMessage", "Invalid Y value: must be between -3 and 3");
                    request.setAttribute("showError", true);
                    request.getRequestDispatcher("/result.jsp").forward(request, response);
                    return;
                }
            } else if ("graph".equals(source)) {
                if (y < -10 || y > 10) {
                    request.setAttribute("errorMessage", "Invalid Y value from graph: must be between -10 and 10");
                    request.setAttribute("showError", true);
                    request.getRequestDispatcher("/result.jsp").forward(request, response);
                    return;
                }
            }

            // Validate each X value and process all points
            List<Point> results = new ArrayList<>();
            double[] allowedX = {-5, -4, -3, -2, -1, 0, 1, 2, 3};

            for (String xParam : xParams) {
                try {
                    double x = Double.parseDouble(xParam);

                    // Validate X values based on source
                    if (source == null || "form".equals(source)) {
                        boolean validX = false;
                        for (double allowed : allowedX) {
                            if (Math.abs(x - allowed) < 0.0001) {
                                validX = true;
                                break;
                            }
                        }
                        if (!validX) {
                            request.setAttribute("errorMessage", "Invalid X value: " + String.format("%.2f", x) + ". Must be one of -5, -4, -3, -2, -1, 0, 1, 2, 3");
                            request.setAttribute("showError", true);
                            request.getRequestDispatcher("/result.jsp").forward(request, response);
                            return;
                        }
                    } else if ("graph".equals(source)) {
                        if (x < -10 || x > 10) {
                            request.setAttribute("errorMessage", "Invalid X value from graph: must be between -10 and 10");
                            request.setAttribute("showError", true);
                            request.getRequestDispatcher("/result.jsp").forward(request, response);
                            return;
                        }
                    }

                    // Measure execution time
                    long startTime = System.nanoTime();
                    Instant currentInstant = Instant.now();

                    // Check point
                    Point result = Checker.handlePointCheck(x, y, r);

                    // Set timestamp and execution time
                    result.setTime(currentInstant.toString());
                    long endTime = System.nanoTime();
                    long executionTime = endTime - startTime;

                    // Format execution time
                    String timeString;
                    if (executionTime < 1000) {
                        timeString = executionTime + " ns";
                    } else if (executionTime < 1_000_000) {
                        timeString = String.format("%.2f µs", executionTime / 1000.0);
                    } else if (executionTime < 1_000_000_000) {
                        timeString = String.format("%.2f ms", executionTime / 1_000_000.0);
                    } else {
                        timeString = String.format("%.2f s", executionTime / 1_000_000_000.0);
                    }
                    result.setTook(timeString);

                    // Add to results list
                    results.add(result);

                    // Save to history
                    HttpSession session = request.getSession(true);
                    History.writeHistory(session, result);

                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid X parameter format: " + xParam);
                    request.setAttribute("showError", true);
                    request.getRequestDispatcher("/result.jsp").forward(request, response);
                    return;
                }
            }

            // Set success attributes for JSP
            request.setAttribute("results", results);
            request.setAttribute("y", y);
            request.setAttribute("r", r);
            request.setAttribute("showResults", true);

            // Forward to result JSP
            request.getRequestDispatcher("/result.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Internal server error: " + e.getMessage());
            request.setAttribute("showError", true);
            request.getRequestDispatcher("/result.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}