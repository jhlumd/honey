function calculatePercentAccepted(percentData) {
  let activeAdvisement;
  let numAccepted = 0;
  let numTotal = 0;
  const percentAcceptedValues = [];

  for (const pair of percentData) {
    const [nectarConsumed, newAdvisement] = pair;

    if (newAdvisement !== null) {
      activeAdvisement = newAdvisement;
      numAccepted = 0;
      numTotal = 0;
    }

    if (nectarConsumed === activeAdvisement) {
      numAccepted++;
      numTotal++;
    } else {
      numTotal++;
    }

    percentAcceptedValues.push(Math.round((numAccepted / numTotal) * 100));
  }

  return percentAcceptedValues;
}

function populateTable(percentValues) {
  const cells = document.querySelectorAll(".percent-accepted");
  cells.forEach((cell, i) => (cell.textContent = `${percentValues[i]}%`));
}