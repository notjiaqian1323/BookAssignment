<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineBookStore.Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .register-container {
            display: flex;
            height: 100vh;
        }
        .left-section {
            flex: 1;
            background: url('register-image.jpg') no-repeat center center;
            background-size: cover;
            background-color: grey;
        }
        .right-section {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            background-color: #f9f9f9;
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
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #218838;
        }
        .login-link {
            text-align: center;
            margin-top: 10px;
        }
        .login-link a {
            text-decoration: none;
            color: #007bff;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <div class="left-section"></div>
            <div class="right-section">
                <div class="form-container">
                    <h3>Register</h3>
                    <asp:Label ID="lblError" runat="server" CssClass="error-message"></asp:Label>
                    <div class="form-group">
                        <label for="txtName">Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" Placeholder="Enter full name"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtEmail">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Enter email"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Enter password"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtConfirmPassword">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Placeholder="Confirm password"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnRegister" runat="server" CssClass="btn" Text="Register" OnClick="RegisterButton_Click" />
                    <p class="login-link">
                        Already have an account? <a href="CustomerLogin.aspx">Login here</a>
                    </p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
