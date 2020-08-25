function onShowPageLoad() {
  const { appointments, vs_hive, vs_comb } = gon;
  appointments.reverse();

  // Color the section of the ID card green or red according to performance
  colorMetrics(vs_hive, vs_comb);

  // Info needed for graph
  const nectarDataForGraph = [];
  const pollenGlobsDataForGraph = [];
  
  // Info needed for % Accepted column
  const percentData = [];

  for (const appt of appointments) {
    const { date, pollen_globs, nectar, advisement } = appt;

    // Info needed for graph
    const unixDate = new Date(date).getTime();
    nectarDataForGraph.push([unixDate, nectar]);
    pollenGlobsDataForGraph.push([unixDate, parseFloat(pollen_globs)]);
    // parseFloat() rather than Number() to get NaN values from null rather than 0.
    // Highchart treats NaN same as null, as missing values

    // Info needed for % Accepted column
    percentData.push([nectar, advisement]);
  }

  drawGraph(nectarDataForGraph, pollenGlobsDataForGraph);
  const percentAcceptedValues = calculatePercentAccepted(percentData).reverse();
  populateTable(percentAcceptedValues);
}