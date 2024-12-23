<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfileManagement.aspx.cs" Inherits="BookAssignment.WebForm5" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<%@ Register TagPrefix="Page" TagName="Footer" Src="~/PageFooter.ascx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Profile Management</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" type="text/css" href="Profile.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server"  ShowStartingNode="false" />
            <Page:Header ID="pgHeader" runat="server" />

            <div class="breadcrumb-container">
                <asp:SiteMapPath ID="siteMapPath" runat="server" DataSourceID="siteMapDataSource" PathSeparator=">">
                    <CurrentNodeStyle CssClass="breadcrumb-current" />
                    <NodeStyle CssClass="breadcrumb-node" />
                    <RootNodeStyle CssClass="breadcrumb-root" />
                </asp:SiteMapPath>
            </div>


            <h1>Profile Management</h1>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
            <h3>Update Profile Information</h3>

            <asp:Label ID="lblName" runat="server" Text="Name:"></asp:Label>
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox><br />

            <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox><br />

            <asp:Button ID="btnUpdateInfo" runat="server" Text="Update Info" OnClick="btnUpdateInfo_Click" /><br />

            <h3>Change Password</h3>

            <asp:Label ID="lblPasswordMessage" runat="server" ForeColor="Red"></asp:Label><br />
            <asp:Label ID="lblCurrentPassword" runat="server" Text="Current Password:"></asp:Label>
            <asp:TextBox ID="txtCurrentPassword" TextMode="Password" runat="server"></asp:TextBox><br />

            <asp:Label ID="lblNewPassword" runat="server" Text="New Password:"></asp:Label>
            <asp:TextBox ID="txtNewPassword" TextMode="Password" runat="server"></asp:TextBox><br />

            <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password:"></asp:Label>
            <asp:TextBox ID="txtConfirmPassword" TextMode="Password" runat="server"></asp:TextBox><br />

            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" OnClick="btnChangePassword_Click" />

            <Page:Footer ID="pgFooter" runat="server"/> 
        </div>
    </form>
</body>
</html>
