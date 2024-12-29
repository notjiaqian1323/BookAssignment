<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerLogin.aspx.cs" Inherits="OnlineBookStore.CustomerLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login</title>
    <link rel="stylesheet" href="CustomerLogin.css" />
</head>
<body>
    <section>
        <div class="form-box">
            <div class="form-value">
                <form id="form1" runat="server">
                    <!-- Logo Section -->
                    <div class="logo-container">
                        <img src="Wallpapers/bookstorelogo.jpg" alt="Bookstore Logo">
                    </div>
                    <!-- Title -->
                    <h2>Customer Login</h2>
                    <!-- Message Label -->
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
                    
                    <!-- Email Input -->
                    <div class="inputbox">
                        <ion-icon name="mail-outline"></ion-icon>
                        <asp:TextBox ID="txtCustomerEmail" runat="server" TextMode="Email" required="true"></asp:TextBox>
                        <label>Email</label>
                    </div>
                    
                    <!-- Password Input -->
                    <div class="inputbox">
                        <ion-icon name="lock-closed-outline"></ion-icon>
                        <asp:TextBox ID="txtCustomerPassword" runat="server" TextMode="Password" required="true"></asp:TextBox>
                        <label>Password</label>
                    </div>
                    
                    <!-- Login Button -->
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn" Text="Log in" OnClick="LoginButton_Click" />
                    
                    <!-- Register Link -->
                    <div class="register">
                        <p>Don't have an account? <a href="Register.aspx">Register Here!</a></p>
                    </div>
                </form>
            </div>
        </div>
    </section>
</body>
</html>
