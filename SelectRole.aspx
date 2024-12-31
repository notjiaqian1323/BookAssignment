<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectRole.aspx.cs" Inherits="OnlineBookStore.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Select Role</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f9;
            background-image: url('Wallpapers/background0.gif'); /* Set background image */
            background-size: cover; /* Ensure the image covers the entire viewport */
            background-position: center; /* Center the background image */
        }
        .container {
            text-align: center;
            background-color: rgba(255, 255, 255, 0.7); /* Optional: semi-transparent background for readability */
            padding: 20px;
            border-radius: 10px;
        }
        button {
            background-color: #ff8c00; /* Orange color */
            color: white;
            border: none;
            padding: 15px 30px;
            margin: 10px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }
        button:hover {
            background-color: #e07b00; /* Darker orange on hover */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Select Your Role</h1>
            <button type="button" onclick="location.href='AdminLogin.aspx'">Admin</button>
            <button type="button" onclick="location.href='CustomerLogin.aspx'">Customer</button>
        </div>
    </form>
</body>
</html>
