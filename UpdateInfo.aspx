<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateInfo.aspx.cs" Inherits="OnlineBookStore.UpdateInfo" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<%@ Register TagPrefix="Page" TagName="Footer" Src="~/PageFooter.ascx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Update Profile Information</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" href="UpdateInfo.css" />
</head>
<body>

    <form id="form1" runat="server">
        <Page:Header ID="pgHead" runat="server"/>

        <div class="profile">
            <h1>Update Profile Information</h1>

            <div class="profile-picture">
                <asp:Label ID="lblProfilePicMessage" runat="server" CssClass="message"></asp:Label>
                <img id="imgProfile" runat="server" src="Profilepic/defaultpic.png" alt="Profile Picture" />
            </div>

            <!-- Profile Picture Change Section -->
            <asp:FileUpload ID="fuProfilePic" runat="server" />
            <asp:Button ID="btnChangeProfilePic" runat="server" Text="Change Photo" CssClass="button" OnClick="btnChangeProfilePic_Click" />

            <br/><br/><asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label><br/><br/>
            <label for="txtName">Name:</label>
            <asp:TextBox ID="txtName" runat="server" />

            <label for="txtEmail">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" />

            <label>Gender:</label>
            <div class="radio-container">
                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <br/>
            <asp:Button ID="btnUpdateInfo" runat="server" Text="Update Info" CssClass="button" OnClick="btnUpdateInfo_Click" />
        </div>

        <Page:Footer ID="pgFooter" runat="server"/> 
    </form>
</body>
</html>
