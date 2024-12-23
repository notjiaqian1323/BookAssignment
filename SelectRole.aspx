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
        }
        .container {
            text-align: center;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 15px 30px;
            margin: 10px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }
        button:hover {
            background-color: #45a049;
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
