<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerLogin.aspx.cs" Inherits="OnlineBookStore.CustomerLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
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
            background: url('customer-image.jpg') no-repeat center center;
            background-size: cover;
        }
        .right-section {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background-color: lightcyan;
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
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #0056b3;
        }
        .register-link {
            text-align: center;
            margin-top: 10px;
        }
        .register-link a {
            text-decoration: none;
            color: #007BFF;
        }
        .alert {
            font-size: 14px;
            margin-bottom: 15px;
        }
        .alert-danger {
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="left-section"></div>
            <div class="right-section">
                <div class="form-container">
                    <h3>Customer Login</h3>
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
                    <div class="form-group">
                        <label for="txtCustomerEmail">Email Address</label>
                        <asp:TextBox ID="txtCustomerEmail" runat="server" Placeholder="Enter email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtCustomerPassword">Password</label>
                        <asp:TextBox ID="txtCustomerPassword" runat="server" TextMode="Password" Placeholder="Enter password"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn" Text="Login" OnClick="LoginButton_Click" />
                                        <p class="login-link">
                        Already have an account? <a href="Register.aspx">Register here</a>
                    </p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
