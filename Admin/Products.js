document.querySelectorAll(".btn-details").forEach(button => {
    button.addEventListener("click", function () {
        const title = this.getAttribute("data-title");
        const description = this.getAttribute("data-description");
        const genre = this.getAttribute("data-genre");
        const price = this.getAttribute("data-price");
        const author = this.getAttribute("data-author");
        const imageUrl = this.getAttribute("data-image");

        document.getElementById("bookDetailsContent").innerHTML = `
            <div class="book-popup-content">
                <img src="${imageUrl}" alt="${title}" class="book-popup-image"/>
                <h3>${title}</h3>
                <p><strong>Author:</strong> ${author}</p>
                <p><strong>Genre:</strong> ${genre}</p>
                <p><strong>Description:</strong> ${description}</p>
                <p><strong>Price:</strong> RM ${parseFloat(price).toFixed(2)}</p>
            </div>
        `;

        document.getElementById("bookDetailsPopup").style.display = "block";
        document.body.classList.add("active-popup");
    });
});

// Close Popup
function closePopup() {
    document.getElementById("bookDetailsPopup").style.display = "none";
    document.body.classList.remove("active-popup");
}
