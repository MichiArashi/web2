// Get context path for API calls
var contextPath = '${pageContext.request.contextPath}';
if (!contextPath || contextPath === '') {
    contextPath = '';
}

// ============ ВАЛИДАЦИЯ ДЛЯ ГРАФИКА (ОТДЕЛЬНАЯ) ============
function validateGraphClick(x, y, r) {
    // Валидация R (должен быть выбран)
    if (!r || isNaN(r)) {
        return { valid: false, message: 'Please select R parameter first.' };
    }

    // Валидация X (любое значение в пределах разумного диапазона графика)
    if (x === null || x === undefined || isNaN(x)) {
        return { valid: false, message: 'Invalid X coordinate from graph' };
    }

    // Валидация Y (любое значение в пределах разумного диапазона графика)
    if (y === null || y === undefined || isNaN(y)) {
        return { valid: false, message: 'Invalid Y coordinate from graph' };
    }

    // Проверка на разумные пределы (не далеко за границами графика)
    const maxRange = Math.max(6, Math.abs(r) + 1);
    if (Math.abs(x) > maxRange * 2 || Math.abs(y) > maxRange * 2) {
        return { valid: false, message: 'Point is too far outside the graph area' };
    }

    return { valid: true, message: '' };
}
// ============ КОНЕЦ ВАЛИДАЦИИ ДЛЯ ГРАФИКА ============

// ============ ВАЛИДАЦИЯ ДЛЯ ФОРМЫ (ОТДЕЛЬНАЯ) ============
function validateForm() {
    const xChecked = document.querySelectorAll('input[name="x"]:checked').length > 0;
    const yValue = document.getElementById('y').value;
    const yValid = !isNaN(yValue) && yValue.trim() !== '' && isFinite(yValue) && Number(yValue) >= -3 && Number(yValue) <= 3;
    const rSelected = document.getElementById('r').value !== '';

    document.getElementById('y').setCustomValidity(yValid || yValue.trim() == '' ? "" : 'Please enter Y between -3 and 3');
    document.querySelector('input[type="submit"]').disabled = !(xChecked && yValid && rSelected);

    return xChecked && yValid && rSelected;
}
// ============ КОНЕЦ ВАЛИДАЦИИ ДЛЯ ФОРМЫ ============

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
        java.util.List<com.example.Point> history = com.example.History.readHistory(session);
        if (history != null && !history.isEmpty()) {
            for (com.example.Point result : history) {
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

// Функция для отправки точки с графика (независимая от формы)
function submitGraphPoint(x, y, r) {
    // Создаем временную форму для отправки точки с графика
    const tempForm = document.createElement('form');
    tempForm.method = 'GET';
    tempForm.action = contextPath + '/controller';
    tempForm.style.display = 'none';

    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'check';
    tempForm.appendChild(actionInput);

    const sourceInput = document.createElement('input');
    sourceInput.type = 'hidden';
    sourceInput.name = 'source';
    sourceInput.value = 'graph';
    tempForm.appendChild(sourceInput);

    const xInput = document.createElement('input');
    xInput.type = 'hidden';
    xInput.name = 'x';
    xInput.value = x;
    tempForm.appendChild(xInput);

    const yInput = document.createElement('input');
    yInput.type = 'hidden';
    yInput.name = 'y';
    yInput.value = y;
    tempForm.appendChild(yInput);

    const rInput = document.createElement('input');
    rInput.type = 'hidden';
    rInput.name = 'r';
    rInput.value = r;
    tempForm.appendChild(rInput);

    document.body.appendChild(tempForm);
    tempForm.submit();
}

// Обработчик отправки основной формы
document.getElementById('myForm').addEventListener('submit', function (event) {
    event.preventDefault();

    const form = event.target;
    const formData = new FormData(form);

    let formX = formData.getAll('x');
    let formY = formData.get('y');
    let formR = formData.get('r');

    if (!formX || formX.length === 0 || !formY || !formR) {
        alert('Please fill in all fields');
        return;
    }

    // Добавляем source=form (уже есть в hidden поле)
    form.submit();
});

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
                const selectedR = rSelect ? rSelect.value : null;

                // ============ ВАЛИДАЦИЯ ДЛЯ ГРАФИКА ============
                const graphValidation = validateGraphClick(coords.x, coords.y, selectedR);
                if (!graphValidation.valid) {
                    alert(graphValidation.message);
                    return;
                }
                // ============ КОНЕЦ ВАЛИДАЦИИ ДЛЯ ГРАФИКА ============

                // Отправляем точку с графика (не зависит от валидации формы)
                submitGraphPoint(coords.x, coords.y, selectedR);
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