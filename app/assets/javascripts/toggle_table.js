function toggleTable() {
  const button = document.querySelector(".table-toggle-button");
  const trs = document.getElementsByTagName("tr");

  button.textContent =
    button.textContent === "Regular View Mode"
      ? "Enhanced View Mode"
      : "Regular View Mode";

  for (const row of trs) {
    row.children[0].classList.toggle("hide-column");
    row.children[1].classList.toggle("hide-column");
    row.children[6].classList.toggle("hide-column");
    row.children[7].classList.toggle("hide-column");
  }
}