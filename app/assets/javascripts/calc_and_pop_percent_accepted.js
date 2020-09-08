function calculatePercentAccepted(percentData) {
  let activeAdvisement;
  let numTotal = 0;
  let numAccepted = 0;
  const percentAcceptedValues = [];

  for (const pair of percentData) {
    const [nectarConsumed, newAdvisement] = pair;

    if (newAdvisement !== null) {
      activeAdvisement = newAdvisement;
      numTotal = 0;
      numAccepted = 0;
    }

    numTotal++;
    if (nectarConsumed === activeAdvisement) numAccepted++;

    percentAcceptedValues.push(Math.round((numAccepted / numTotal) * 100));
  }

  return percentAcceptedValues;
}

function populateTable(percentValues) {
  const cells = document.querySelectorAll(".percent-accepted");
  cells.forEach((cell, i) => (cell.textContent = `${percentValues[i]}%`));
}