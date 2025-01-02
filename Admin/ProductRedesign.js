let arrow = document.querySelectorAll(".arrow");
console.log(arrow);
for (var i = 0; i < arrow.length; i++) {
    arrow[i].addEventListener("click", (e) => {
        let arrowParent = e.target.parentElement.parentElement;
        console.log(arrowParent);
        arrowParent.classList.toggle("showMenu");
    })
}

let sidebar = document.querySelector(".sidebar");
let sidebarbtn = document.querySelector(".bx-menu");
console.log(sidebarbtn);
sidebarbtn.addEventListener("click", () => {
    sidebar.classList.toggle("close");
});