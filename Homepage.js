//                         IMAGE SLIDER                         //

let list = document.querySelector(".adsBoard .slides");
let items = document.querySelectorAll(".adsBoard .slides .slide");
let dots = document.querySelectorAll(".adsBoard .dots li");
let prev = document.querySelector(".prev");
let next = document.querySelector(".next");

let active = 0;
let lengthItems = items.length - 1;

next.onclick = function () {
    if (active + 1 > lengthItems) {
        active = 0;
    } else {
        active = active + 1;
    }
    reloadSlider();
}

let refreshSlider = setInterval(() => { next.click() }, 3000);

function reloadSlider() {
    let checkLeft = items[active].offsetLeft;
    list.style.left = -checkLeft + 'px';

    let lastActiveDot = document.querySelector(".adsBoard .dots li.active");
    lastActiveDot.classList.remove("active");
    dots[active].classList.add("active");
    clearInterval(refreshSlider);
    refreshSlider = setInterval(() => { next.click() }, 3000);
}

dots.forEach((li, key) => {
    li.addEventListener('click', function () {
        active = key;
        reloadSlider();
    })
})




