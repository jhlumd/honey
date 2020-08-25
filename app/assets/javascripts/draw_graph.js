function drawGraph() {
  const { appointments } = gon;
  appointments.reverse();

  const dates = [];
  const nectars = [];
  const pollenGlobs = [];

  for (const appt of appointments) {
    const { date, nectar, pollen_globs } = appt;
    const jDate = new Date(date);
    dates.push(jDate.toDateString());
    nectars.push(nectar);
    pollenGlobs.push(parseFloat(pollen_globs));
    // parseFloat() rather than Number() to get NaN values from null rather than 0.
    // Highchart treats NaN same as null, as missing values
  }

  Highcharts.chart("graph-container", {
    chart: {
      zoomType: "xy",
    },

    title: {
      text: undefined,
    },

    xAxis: [
      {
        categories: dates,
        crosshair: true,
      },
    ],

    yAxis: [
      {
        // Nectar yAxis
        title: {
          text: "Nectar",
          style: {
            color: Highcharts.getOptions().colors[0],
          },
        },
        labels: {
          format: "{value} units",
          style: {
            color: Highcharts.getOptions().colors[0],
          },
        },
        opposite: true,
      },
      {
        // PollenGlobs yAxis
        labels: {
          format: "{value} p/g",
          style: {
            color: Highcharts.getOptions().colors[1],
          },
        },
        title: {
          text: "PollenGlobs",
          style: {
            color: Highcharts.getOptions().colors[1],
          },
        },
      },
    ],

    tooltip: {
      shared: true,
    },

    plotOptions: {
      series: {
        connectNulls: true,
      },
      column: {
        borderRadius: 5,
      },
    },

    legend: {
      layout: "vertical",
      align: "center",
      // x: 120,
      verticalAlign: "top",
      // y: 100,
      // floating: true,
      backgroundColor:
        Highcharts.defaultOptions.legend.backgroundColor ||
        "rgba(255,255,255,0.25)",
    },

    series: [
      {
        name: "Nectar Allowance",
        type: "column",
        yAxis: 1,
        data: nectars,
        tooltip: {
          valueSuffix: " units",
        },
      },
      {
        name: "PollenGlobs Collected",
        type: "spline",
        data: pollenGlobs,
        tooltip: {
          valueSuffix: " p/g",
        },
      },
    ],

    exporting: {
      buttons: {
        contextButton: {
          menuItems: [
            "printChart",
            "separator",
            "downloadPNG",
            "downloadJPEG",
            "downloadPDF",
            "downloadSVG",
            "separator",
            "downloadCSV",
            "downloadXLS",
            // "viewData",
            // "openInCloud",
          ],
        },
      },
    },
  });
}