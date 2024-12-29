<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineBookStore.Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="Register.css" />
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
                    <h2>Register</h2>
                    <!-- Message Label -->
                    <asp:Label ID="lblError" runat="server" CssClass="alert" Visible="false"></asp:Label>
                    
                    <!-- Full Name Input -->
                    <div class="inputbox">
                        <ion-icon name="person-outline"></ion-icon>
                        <asp:TextBox ID="txtName" runat="server" required="true"></asp:TextBox>
                        <label>Full Name</label>
                    </div>
                    
                    <!-- Email Input -->
                    <div class="inputbox">
                        <ion-icon name="mail-outline"></ion-icon>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" required="true"></asp:TextBox>
                        <label>Email</label>
                    </div>
                    
                    <!-- Password Input -->
                    <div class="inputbox">
                        <ion-icon name="lock-closed-outline"></ion-icon>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" required="true"></asp:TextBox>
                        <label>Password</label>
                    </div>
                    
                    <!-- Confirm Password Input -->
                    <div class="inputbox">
                        <ion-icon name="lock-closed-outline"></ion-icon>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" required="true"></asp:TextBox>
                        <label>Confirm Password</label>
                    </div>
                    
                    <!-- Register Button -->
                    <asp:Button ID="btnRegister" runat="server" CssClass="btn" Text="Register" OnClick="RegisterButton_Click" />
                    
                    <!-- Login Link -->
                    <div class="register">
                        <p>Already have an account? <a href="CustomerLogin.aspx">Login Here!</a></p>
                    </div>
                </form>
            </div>
        </div>
    </section>
</body>
</html>
