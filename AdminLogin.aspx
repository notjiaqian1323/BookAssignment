<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="OnlineBookStore.AdminLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .login-container {
            display: flex;
            height: 100vh;
        }
        .left-section {
            flex: 1;
            background: url('admin-image.jpg') no-repeat center center;
            background-size: cover;
        }
        .right-section {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background-color: #f4f4f9;
        }
        .form-container {
            width: 100%;
            max-width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .form-container h3 {
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #555;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="left-section">
                <img src="path-to-your-image.jpg" alt="Login Illustration" class="login-image" />
            </div>

            <div class="right-section">
                <div class="form-container">
                    <h3>Admin Login</h3>
                    <asp:Label ID="lblMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
                    <div class="form-group">
                        <label for="txtAdminEmail">Email Address</label>
                        <asp:TextBox ID="txtAdminEmail" runat="server" Placeholder="Enter email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtAdminPassword">Password</label>
                        <asp:TextBox ID="txtAdminPassword" runat="server" TextMode="Password" Placeholder="Enter password"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn" Text="Login" OnClick="LoginButton_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
