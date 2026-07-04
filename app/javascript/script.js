import $ from "jquery";

document.addEventListener("turbo:load", () => {
  console.log("turbo.load");

  const button = document.getElementById("back-to-top");

  if (!button) return;

  window.addEventListener("scroll", () => {
    if (window.scrollY > 300) {
      button.classList.add("show");
    } else {
      button.classList.remove("show");
    }
  });

  button.addEventListener("click", (e) => {
    e.preventDefault();

    window.scrollTo({
      top: 0,
      behavior: "smooth"
    });
  });
});