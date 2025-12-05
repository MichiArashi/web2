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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="https://cdn.plot.ly/plotly-3.1.0.min.js" charset="utf-8"></script>
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
                            <input type="hidden" name="source" value="form">

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

    <script src="${pageContext.request.contextPath}/static/js/graph.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</body>

</html>