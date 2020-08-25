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

  const nectarColor = Highcharts.getOptions().colors[6];
  const pgColor = Highcharts.getOptions().colors[1];
  // 0: blue      
  // 1: black     
  // 2: green     
  // 3: orange    column
  // 6: yellow    column
  // 9: honeydew  column
  // 4: purple    line
  // 5: pink      line
  // 7: green     line
  // 8: red       line

  Highcharts.chart("graph-container", {
    chart: {
      zoomType: "x",
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
        // PollenGlobs yAxis
        labels: {
          format: "{value} p/g",
          style: {
            color: pgColor,
          },
        },
        title: {
          text: "PollenGlobs",
          style: {
            color: pgColor,
          },
        },
        opposite: true,
      },
      {
        // Nectar yAxis
        title: {
          text: "Nectar",
          style: {
            color: nectarColor,
          },
        },
        labels: {
          format: "{value} units",
          style: {
            color: nectarColor,
          },
        },
      },
    ],

    tooltip: {
      shared: true,
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
        borderRadius: 5,
        color: nectarColor,
      },
      {
        name: "PollenGlobs Collected",
        type: "spline",
        data: pollenGlobs,
        tooltip: {
          valueSuffix: " p/g",
        },
        connectNulls: true,
        color: pgColor,
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