<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="OnlineBookStore.ChangePassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Change Password</title>
    <link rel="stylesheet" href="ChangePassword.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Change Password</h1>
            <asp:Label ID="lblPasswordMessage" runat="server" ForeColor="Green"></asp:Label><br />
            
            <asp:Label ID="lblCurrentPassword" runat="server" Text="Current Password:"></asp:Label>
            <asp:TextBox ID="txtCurrentPassword" TextMode="Password" runat="server"></asp:TextBox><br />

            <asp:Label ID="lblNewPassword" runat="server" Text="New Password:"></asp:Label>
            <asp:TextBox ID="txtNewPassword" TextMode="Password" runat="server"></asp:TextBox><br />

            <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password:"></asp:Label>
            <asp:TextBox ID="txtConfirmPassword" TextMode="Password" runat="server"></asp:TextBox><br />

            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" OnClick="btnChangePassword_Click" />
        </div>
    </form>
</body>
</html>
