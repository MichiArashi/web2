<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link
        href="data:image/x-icon;base64,AAABAAEAEBAQAAEABAAoAQAAFgAAACgAAAAQAAAAIAAAAAEABAAAAAAAgAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAP///AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP///wD///8A////AP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA"
        rel="icon" type="image/x-icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">

    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0&icon_names=delete" />

    <style>
        table {
            width: 100%;
            max-height: 100vh;
            height: 100%;
            table-layout: fixed;
        }

        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            background-image: url('static/backgrounds/background.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #ffffff;
        }

        h1 {
            font-family: Dela Gothic One, monospace;
            font-style: normal;
            font-weight: 400;
            text-align: center;
            color: #00ffff;
            text-shadow: 0 0 10px rgba(0, 255, 255, 0.7);
        }

        h1::before,
        h1::after {
            content: "⦿";
        }

        input[type="checkbox"] {
            transform: scale(1.2);
            margin: 0 5px;
        }

        input[type="text"] {
            width: 100%;
            box-sizing: border-box;
            padding: 8px;
            border: 2px solid rgba(0, 255, 255, 0.5);
            background-color: rgba(0, 20, 30, 0.8);
            color: #ffffff;
            border-radius: 6px;
            height: 40px;
            font-size: 16px;
            transition: all 0.3s;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #00ffff;
            box-shadow: 0 0 15px rgba(0, 255, 255, 0.5);
        }

        input[type="text"]:invalid {
            background: rgba(139, 0, 0, 0.3);
            border-color: rgba(255, 0, 0, 0.5);
        }

        select {
            width: 100%;
            box-sizing: border-box;
            padding: 8px;
            border: 2px solid rgba(0, 255, 255, 0.5);
            background-color: rgba(0, 20, 30, 0.8);
            color: #ffffff;
            border-radius: 6px;
            height: 40px;
            font-size: 16px;
            transition: all 0.3s;
        }

        select:focus {
            outline: none;
            border-color: #00ffff;
            box-shadow: 0 0 15px rgba(0, 255, 255, 0.5);
        }

        input[type="submit"] {
            width: 100%;
            box-sizing: border-box;
            cursor: pointer;
            height: 60px;
            font-family: Dela Gothic One;
            font-style: normal;
            font-weight: 400;
            font-size: large;
            text-align: center;
            transition: all 0.3s;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(0, 255, 255, 0.3), rgba(0, 150, 200, 0.3));
            border: 2px solid rgba(0, 255, 255, 0.6);
            color: #ffffff;
            text-shadow: 0 0 5px rgba(0, 255, 255, 0.7);
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, rgba(0, 255, 255, 0.5), rgba(0, 150, 200, 0.5));
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.4);
            transform: translateY(-2px);
        }

        input[type="submit"]:active {
            transform: translateY(0);
        }

        input[type="submit"]:disabled {
            background: rgba(50, 50, 50, 0.3);
            border: 2px solid rgba(100, 100, 100, 0.5);
            color: rgba(150, 150, 150, 0.7);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        button {
            width: 100%;
            box-sizing: border-box;
            cursor: pointer;
            height: 60px;
            font-family: Dela Gothic One;
            font-style: normal;
            font-weight: 400;
            font-size: large;
            text-align: center;
            transition: all 0.3s;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(255, 0, 100, 0.3), rgba(200, 0, 50, 0.3));
            border: 2px solid rgba(255, 0, 100, 0.6);
            color: #ffffff;
        }

        button:hover {
            background: linear-gradient(135deg, rgba(255, 0, 100, 0.5), rgba(200, 0, 50, 0.5));
            box-shadow: 0 0 20px rgba(255, 0, 100, 0.4);
            transform: translateY(-2px);
        }

        td>label {
            display: block;
            text-align: center;
            color: #00ffff;
            font-weight: bold;
        }

        td>span {
            display: block;
            text-align: center;
            color: #ffffff;
        }

        .checkbox-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0;
        }

        .checkbox-item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .checkbox-item label {
            margin-top: 5px;
            font-size: 12px;
            color: #88ffff;
        }

        input {
            padding: 3% !important;
        }

        .header {
            width: stretch;
            border-radius: 15px;
            margin: 10px;
            padding: 10px;
            background: rgba(0, 30, 40, 0.8);
            border: 2px solid rgba(0, 255, 255, 0.4);
            box-shadow: 0 0 30px rgba(0, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        .card {
            background: rgba(0, 20, 30, 0.85);
            border: 1px solid rgba(0, 255, 255, 0.3);
            border-radius: 12px;
            padding: 15px;
            margin-top: 10px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(12px);
        }

        .card-light {
            background: rgba(0, 30, 40, 0.7);
            border: 1px solid rgba(0, 255, 255, 0.2);
            border-radius: 10px;
            padding: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(8px);
        }

        .card-success {
            background: rgba(0, 60, 40, 0.8);
            border: 1px solid rgba(0, 255, 150, 0.4);
            border-radius: 10px;
            padding: 12px;
            box-shadow: 0 0 15px rgba(0, 255, 150, 0.2);
        }

        .card-failure {
            background: rgba(60, 0, 20, 0.8);
            border: 1px solid rgba(255, 0, 100, 0.4);
            border-radius: 10px;
            padding: 12px;
            box-shadow: 0 0 15px rgba(255, 0, 100, 0.2);
        }

        .plot {
            border-radius: 10px;
            overflow: hidden;
            border: 2px solid rgba(0, 255, 255, 0.3);
        }

        @keyframes glow {
            0% { box-shadow: 0 0 10px rgba(0, 255, 255, 0.3); }
            50% { box-shadow: 0 0 20px rgba(0, 255, 255, 0.6); }
            100% { box-shadow: 0 0 10px rgba(0, 255, 255, 0.3); }
        }

        .glowing {
            animation: glow 2s ease-in-out infinite;
        }
    </style>
    <title>Web Lab 1</title>
</head>

<body>
    <div class="header">
        <h1>Ожеховский Александр Сергеевич P3231 466944</h1>
    </div>
    <table>
        <tr>
            <td style="width: 65%; vertical-align: top;">
                <div class="card-light">
                    <div id="myPlot" class="plot"></div>
                </div>
            </td>
            <td>
                <div class="card" id="formCard">
                    <div class="card-light">
                        <form id="myForm" method="GET" action="${pageContext.request.contextPath}/controller">
                            <input type="hidden" name="action" value="check">

                            <table style="width: 100%;">
                                <tr>
                                    <td colspan="9">
                                        <label for="x">X coordinate:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9">
                                        <div class="checkbox-group">
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="-5" id="x1">
                                                <label for="x1">-5</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="-4" id="x2">
                                                <label for="x2">-4</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="-3" id="x3">
                                                <label for="x3">-3</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="-2" id="x4">
                                                <label for="x4">-2</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="-1" id="x5">
                                                <label for="x5">-1</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="0" id="x6">
                                                <label for="x6">0</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="1" id="x7">
                                                <label for="x7">1</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="2" id="x8">
                                                <label for="x8">2</label>
                                            </div>
                                            <div class="checkbox-item">
                                                <input type="checkbox" name="x" value="3" id="x9">
                                                <label for="x9">3</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9" style="padding: 15px 0 5px 0;">
                                        <label for="y">Y coordinate:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9">
                                        <input type="text" id="y" name="y" placeholder="Enter Y from -3 to 3"
                                               pattern="-?[0-9]*[.,]?[0-9]*"
                                               title="Please enter a number between -3 and 3">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9" style="padding: 15px 0 5px 0;">
                                        <label for="r">R parameter:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9">
                                        <select id="r" name="r">
                                            <option value="">Select R</option>
                                            <option value="1">1</option>
                                            <option value="1.5">1.5</option>
                                            <option value="2">2</option>
                                            <option value="2.5">2.5</option>
                                            <option value="3">3</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="padding-top: 20px;">
                                        <input type="submit" value="CHECK" disabled>
                                    </td>
                                    <td colspan="3" style="padding-top: 20px;">
                                        <button type="button" class="reset" title="Clear history">
                                            <span class="material-symbols-outlined" style="text-align: center; font-size: 100%;">
                                                delete
                                            </span>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </td>
        </tr>
    </table>

    <script src="https://cdn.plot.ly/plotly-3.1.0.min.js" charset="utf-8"></script>
    <script>
        // graph plot
        function getPath(r) {
            // Rectangle in Quadrant II:
            const rect_data = {
                x: [r, 0, 0, r, r],
                y: [0, 0, -r/2, -r/2, 0],
                fill: "toself",
                fillcolor: 'rgba(0, 255, 255, 0.3)',
                line: { color: 'rgba(0, 255, 255, 0.8)', width: 2 },
                type: 'scatter',
                name: 'rectangle'
            };

            // Triangle in Quadrant III:
            const triangle_data = {
                x: [0, -r/2, 0, 0],
                y: [0, 0, -r/2, 0],
                fill: "toself",
                fillcolor: 'rgba(0, 255, 255, 0.3)',
                line: { color: 'rgba(0, 255, 255, 0.8)', width: 2 },
                type: 'scatter',
                name: 'triangle'
            };

            // Quarter circle in Quadrant II:
            const theta = Array.from({ length: 100 }, (_, i) => Math.PI/2 + (Math.PI / 2) * (i / 99));
            const circle_x = theta.map(angle => r * Math.cos(angle));
            const circle_y = theta.map(angle => r * Math.sin(angle));
            const circle_data = {
                x: [0, ...circle_x, 0],
                y: [0, ...circle_y, 0],
                fill: "toself",
                fillcolor: 'rgba(0, 255, 255, 0.3)',
                line: { color: 'rgba(0, 255, 255, 0.8)', width: 2 },
                type: 'scatter',
                name: 'circle'
            };

            return [rect_data, triangle_data, circle_data];
        }

        // Store all history points for filtering by R
        var historyPoints = [];

        // Default layout for empty graph (just axes)
        const emptyLayout = {
            margin: { l: 50, r: 50, t: 50, b: 50 },
            showlegend: false,
            plot_bgcolor: 'rgba(0, 20, 30, 0.3)',
            paper_bgcolor: 'rgba(0, 10, 20, 0.5)',
            xaxis: {
                showline: true,
                linecolor: '#00ffff',
                linewidth: 2,
                mirror: true,
                range: [-6, 6],
                fixedrange: true,
                gridcolor: 'rgba(0, 255, 255, 0.2)',
                zerolinecolor: '#00ffff',
                tickfont: { color: '#ffffff' },
                title: { text: 'X', font: { color: '#00ffff' } }
            },
            yaxis: {
                showline: true,
                linecolor: '#00ffff',
                linewidth: 2,
                mirror: true,
                scaleanchor: 'x',
                scaleratio: 1,
                range: [-6, 6],
                fixedrange: true,
                gridcolor: 'rgba(0, 255, 255, 0.2)',
                zerolinecolor: '#00ffff',
                tickfont: { color: '#ffffff' },
                title: { text: 'Y', font: { color: '#00ffff' } }
            },
            shapes: [
                { type: 'line', x0: -6, y0: 0, x1: 6, y1: 0, line: { color: '#00ffff', width: 2 } },
                { type: 'line', x0: 0, y0: -6, x1: 0, y1: 6, line: { color: '#00ffff', width: 2 } }
            ]
        };

        var currentR = null;
        var plotReady = false;

        function pixelToPlotCoords(event, plotDiv) {
            const rect = plotDiv.getBoundingClientRect();
            const mouseX = event.clientX - rect.left;
            const mouseY = event.clientY - rect.top;

            const layout = plotDiv._fullLayout || plotDiv.layout;
            if (!layout) return null;

            const xAxis = layout.xaxis || {};
            const yAxis = layout.yaxis || {};
            const xRange = xAxis.range || [-6, 6];
            const yRange = yAxis.range || [-6, 6];

            let plotWidth, plotHeight, plotLeft, plotTop;

            if (layout._size) {
                plotLeft = layout._size.l || 0;
                plotTop = layout._size.t || 0;
                plotWidth = layout._size.w || (rect.width - plotLeft - (layout._size.r || 0));
                plotHeight = layout._size.h || (rect.height - plotTop - (layout._size.b || 0));
            } else {
                const margin = layout.margin || {};
                plotLeft = margin.l || 0;
                plotTop = margin.t || 0;
                plotWidth = rect.width - plotLeft - (margin.r || 0);
                plotHeight = rect.height - plotTop - (margin.b || 0);
            }

            const plotX = xRange[0] + (mouseX - plotLeft) / plotWidth * (xRange[1] - xRange[0]);
            const plotY = yRange[1] - (mouseY - plotTop) / plotHeight * (yRange[1] - yRange[0]);

            return { x: plotX, y: plotY };
        }

        function updateGraph(r) {
            currentR = r;
            const plotDiv = document.getElementById('myPlot');

            if (!plotDiv) return;

            const newData = getPath(r);
            const newLayout = {
                margin: { l: 50, r: 50, t: 50, b: 50 },
                showlegend: false,
                plot_bgcolor: 'rgba(0, 20, 30, 0.3)',
                paper_bgcolor: 'rgba(0, 10, 20, 0.5)',
                xaxis: {
                    showline: true,
                    linecolor: '#00ffff',
                    linewidth: 2,
                    mirror: true,
                    range: [-r - 1, r + 1],
                    fixedrange: true,
                    gridcolor: 'rgba(0, 255, 255, 0.2)',
                    zerolinecolor: '#00ffff',
                    tickfont: { color: '#ffffff' },
                    title: { text: 'X', font: { color: '#00ffff' } }
                },
                yaxis: {
                    showline: true,
                    linecolor: '#00ffff',
                    linewidth: 2,
                    mirror: true,
                    scaleanchor: 'x',
                    scaleratio: 1,
                    range: [-r - 1, r + 1],
                    fixedrange: true,
                    gridcolor: 'rgba(0, 255, 255, 0.2)',
                    zerolinecolor: '#00ffff',
                    tickfont: { color: '#ffffff' },
                    title: { text: 'Y', font: { color: '#00ffff' } }
                },
                shapes: [
                    { type: 'line', x0: -r - 1, y0: 0, x1: r + 1, y1: 0, line: { color: '#00ffff', width: 2 } },
                    { type: 'line', x0: 0, y0: -r - 1, x1: 0, y1: r + 1, line: { color: '#00ffff', width: 2 } }
                ]
            };

            Plotly.newPlot('myPlot', [...newData, ...historyPoints], newLayout, {
                scrollZoom: false,
                doubleClick: false,
                displayModeBar: false,
                responsive: true
            }).then(function() {
                plotReady = true;
            });
        }

        // Initialize with empty graph
        const plotDiv = document.getElementById('myPlot');
        if (plotDiv) {
            Plotly.newPlot('myPlot', [], emptyLayout, {
                scrollZoom: false,
                doubleClick: false,
                displayModeBar: false,
                responsive: true
            }).then(function() {
                plotReady = true;
            });
        }
    </script>

    <script>
        // Get context path for API calls
        var contextPath = '${pageContext.request.contextPath}';
        if (!contextPath || contextPath === '') {
            contextPath = '';
        }

        function clearPlotPoints() {
            const plotDiv = document.getElementById('myPlot');
            if (plotDiv.data && plotDiv.data.length > 3) {
                Plotly.deleteTraces('myPlot', Array.from({ length: plotDiv.data.length - 3 }, (_, i) => i + 3));
            }
        }

        function clearHistory() {
            const formCard = document.getElementById('formCard');
            while (formCard.children.length > 1) {
                formCard.removeChild(formCard.lastChild);
            }
            historyPoints = [];
            if (currentR !== null) {
                updateGraph(currentR);
            } else {
                Plotly.react('myPlot', [], emptyLayout, { scrollZoom: true, displayModeBar: false, responsive: true });
            }
        }

        function loadHistoryFromSession() {
            <%
                java.util.List<com.example.PointResult> history = com.example.HistoryService.readHistory(session);
                if (history != null && !history.isEmpty()) {
                    for (com.example.PointResult result : history) {
            %>
                        appendElement(<%= result.isSuccess() %>, <%= result.getR() %>, <%= result.getX() %>, <%= result.getY() %>, '<%= result.getTime() != null ? result.getTime().replace("'", "\\'") : "" %>', '<%= result.getTook() != null ? result.getTook().replace("'", "\\'") : "" %>', "formCard");
                        historyPoints.push({
                            x: [<%= result.getX() %>],
                            y: [<%= result.getY() %>],
                            mode: 'markers',
                            type: 'scatter',
                            marker: { color: <%= result.isSuccess() ? "'#00ff88'" : "'#ff0066'" %>, size: 12 },
                            name: 'point',
                            r: <%= result.getR() %>
                        });
            <%
                    }
                }
            %>
            function checkAndUpdateGraph() {
                if (plotReady) {
                    const rSelect = document.getElementById('r');
                    if (rSelect && rSelect.value) {
                        const rValue = parseFloat(rSelect.value);
                        updateGraph(rValue);
                    } else {
                        if (historyPoints.length > 0) {
                            Plotly.newPlot('myPlot', historyPoints, emptyLayout, {
                                scrollZoom: false,
                                doubleClick: false,
                                displayModeBar: false,
                                responsive: true
                            }).then(function() {
                                plotReady = true;
                            });
                        }
                    }
                } else {
                    setTimeout(checkAndUpdateGraph, 50);
                }
            }
            checkAndUpdateGraph();
        }

        function appendElement(success, radius, x, y, time, took, containerToAppend) {
            var container = document.getElementById(containerToAppend);
            var element = document.createElement('div');
            element.className = success ? 'card card-success' : 'card card-failure';
            var icon = success ? '✅' : '❌';
            element.innerHTML = '<h3>' + icon + ' R = ' + radius + '</h3><p>(' + x + ', ' + y + ') ' + time + ' took ' + took + '</p>';
            container.insertBefore(element, container.children[1] || null);
        }

        function validateForm() {
            const xChecked = document.querySelectorAll('input[name="x"]:checked').length > 0;
            const yValue = document.getElementById('y').value;
            const yValid = !isNaN(yValue) && yValue.trim() !== '' && isFinite(yValue) && Number(yValue) >= -3 && Number(yValue) <= 3;
            const rSelected = document.getElementById('r').value !== '';

            document.getElementById('y').setCustomValidity(yValid || yValue.trim() == '' ? "" : 'Please enter Y between -3 and 3');
            document.querySelector('input[type="submit"]').disabled = !(xChecked && yValid && rSelected);

            return xChecked && yValid && rSelected;
        }

        document.getElementById('myForm').addEventListener('change', function (event) {
            validateForm();

            // Update graph when R changes
            if (event.target.name === 'r' && event.target.value) {
                const rValue = parseFloat(event.target.value);
                updateGraph(rValue);
            }
        });

        document.getElementById('y').addEventListener('input', function() {
            validateForm();
        });

        window.addEventListener('DOMContentLoaded', function () {
            loadHistoryFromSession();

            function addClickHandler() {
                if (plotReady && plotDiv) {
                    plotDiv.addEventListener('click', function(event) {
                        const coords = pixelToPlotCoords(event, plotDiv);
                        if (!coords) return;

                        const rSelect = document.getElementById('r');
                        if (!rSelect || !rSelect.value) {
                            alert('Please select R parameter first.');
                            return;
                        }

                        const selectedR = rSelect.value;

                        // Auto-select the closest X checkbox (теперь можно выбирать несколько)
                        const xValues = [-5, -4, -3, -2, -1, 0, 1, 2, 3];
                        let closestX = xValues[0];
                        let minDiff = Math.abs(xValues[0] - coords.x);

                        for (let i = 1; i < xValues.length; i++) {
                            const diff = Math.abs(xValues[i] - coords.x);
                            if (diff < minDiff) {
                                minDiff = diff;
                                closestX = xValues[i];
                            }
                        }

                        // Check the closest X checkbox (не снимая другие выбранные)
                        const xCheckbox = document.querySelector(`input[name="x"][value="${closestX}"]`);
                        if (xCheckbox) {
                            xCheckbox.checked = true;
                        }

                        // Set Y value
                        document.getElementById('y').value = coords.y.toFixed(2);

                        // Validate and submit if valid
                        if (validateForm()) {
                            document.getElementById('myForm').submit();
                        }
                    });
                } else {
                    setTimeout(addClickHandler, 50);
                }
            }
            addClickHandler();

            // Reset button handler
            document.querySelector('button.reset').addEventListener('click', function () {


                            // Use URLSearchParams for proper form encoding
                            const params = new URLSearchParams();
                            params.append('action', 'reset');

                            fetch(contextPath + '/controller', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded'
                                },
                                body: params.toString()
                            })
                                .then(response => {
                                    console.log('Reset response status:', response.status);
                                    if (!response.ok) {
                                        return response.text().then(text => {
                                            throw new Error('Failed to reset history: ' + text);
                                        });
                                    }
                                    return response.json();
                                })
                                .then(data => {
                                    console.log('Reset successful:', data);
                                    // Clear the UI
                                    clearHistory();


                                    // Reload the page to ensure everything is in sync
                                    window.location.reload();
                                })
                                .catch(error => {
                                    console.error('Error resetting history:', error);
                                    alert('Error resetting history: ' + error.message);
                                });
                        });
        });
    </script>

</body>

</html>