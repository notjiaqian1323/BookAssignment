document.querySelectorAll(".btn-details").forEach(button => {
    button.addEventListener("click", function () {
        const userId = this.getAttribute("data-id");

        fetch(`Customers.aspx?userId=${userId}`)
            .then(response => response.json())
            .then(data => {
                document.getElementById("userDetailsContent").innerHTML = `
                    <p><strong>ID:</strong> ${data.Id}</p>
                    <p><strong>Name:</strong> ${data.Name}</p>
                    <p><strong>Email:</strong> ${data.Email}</p>
                    <p><strong>Role:</strong> ${data.Role}</p>
                    <p><strong>Gender:</strong> ${data.Gender}</p>
                `;
                document.body.classList.add("active-popup");
            })
            .catch(error => {
                console.error('Error fetching user details:', error);
            });
    });
});
