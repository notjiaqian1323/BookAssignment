// Select all unread notifications and update the notification count
const unreadMessage = document.querySelectorAll(".unread");
const unread = document.getElementById("notifications");
const markAll = document.getElementById("mark_all");

// Update unread count initially
unread.innerText = unreadMessage.length;

// Mark individual notification as read
unreadMessage.forEach((message) => {
    message.addEventListener("click", () => {
        message.classList.remove("unread");
        const newUnreadMessages = document.querySelectorAll(".unread");
        unread.innerText = newUnreadMessages.length;
    });
});

// Mark all notifications as read
markAll.addEventListener("click", () => {
    unreadMessage.forEach((message) => {
        message.classList.remove("unread");
    });
    unread.innerText = "0";
});
