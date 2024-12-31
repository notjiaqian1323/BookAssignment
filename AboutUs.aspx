<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="OnlineBookStore.AboutUs" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>About Us - Mopulah</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: darkcyan;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .logo-container {
            margin-bottom: 20px;
            animation: rotateLogo 10s linear infinite; /* Apply the rotation animation */
        }

        .logo-container img {
            max-width: 150px;
            height: 150px;
            border-radius: 50%; /* Makes the logo circular */
            object-fit: cover; /* Ensures the logo fits nicely in the circular frame */
        }

        /* Define the keyframes for rotating the logo */
        @keyframes rotateLogo {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        h1 {
            color: white;
            margin-bottom: 20px;
        }

        p {
            color: white;
            line-height: 1.8;

        }

        .footer {
            margin-top: 30px;
            font-size: 12px;
            color: lightgray;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="logo-container">
                <img src="Wallpapers/bookstorelogo.jpg" alt="Mopulah Logo" />
            </div>
            <h1 style="font-family:'Times New Roman';">Welcome to Mopulah</h1>
            <p style="font-family:'Berlin Sans FB';">
                At Mopulah, we believe in the transformative power of books. Our online bookstore is dedicated to 
                providing an extensive collection of titles that cater to all kinds of readers, from avid bibliophiles 
                to casual readers. Whether you're looking for the latest bestsellers, timeless classics, or niche genres, 
                Mopulah is your one-stop destination.
            </p>
            <p style="font-family:'Berlin Sans FB';">
                Founded with the mission to inspire and nurture a love for reading, Mopulah connects readers with stories 
                that ignite imagination, expand knowledge, and provide an escape from the everyday. Our curated selection 
                of books spans various genres including fiction, non-fiction, self-help, children's books, and more.
            </p>
            <p style="font-family:'Berlin Sans FB'">
                Thank you for choosing Mopulah as your trusted online bookstore. Together, let's turn every page into an 
                adventure!
            </p>
            <div class="footer">
                © 2024 Mopulah. All rights reserved.
            </div>
        </div>
    </form>
</body>
</html>
