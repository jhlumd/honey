function colorMetrics(vsHive, vsComb) {
  const hiveCell = document.querySelector(".vs-hive");
  const combCell = document.querySelector(".vs-comb");

  if (vsHive < 0) {
    hiveCell.classList.add("good-perf");
  } else {
    hiveCell.classList.add("bad-perf");
  }

  if (vsComb < 0) {
    combCell.classList.add("good-perf");
  } else {
    combCell.classList.add("bad-perf");
  }
}