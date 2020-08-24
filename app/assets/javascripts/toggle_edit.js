function toggleEdit(type, id) {
  const section = document.getElementById(`${type}-${id}`);
  section.querySelector(".edit-form").classList.toggle("hide");
  section.querySelector(".toggle-button").classList.toggle("hide");
}
