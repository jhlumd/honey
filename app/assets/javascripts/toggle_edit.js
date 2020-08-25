function toggleEdit(type, id) {
  const section = document.getElementById(`${type}-${id}`);
  const button = section.querySelector(".edit-toggle-button");

  section.querySelector(".edit-form").classList.toggle("hide");

  if (type === "appt") {
    button.textContent =
      button.textContent === "Cancel" ? "Edit Advisement" : "Cancel";
  } else if (type === "bee") {
    button.textContent =
      button.textContent === "Cancel" ? "Change comb" : "Cancel";
    section.querySelector(".comb-id").classList.toggle("hide");
  }
}