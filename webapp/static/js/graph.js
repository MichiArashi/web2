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