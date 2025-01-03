<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="OnlineBookStore.ChangePassword" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<%@ Register TagPrefix="Page" TagName="Footer" Src="~/PageFooter.ascx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Change Password</title>
    <link rel="stylesheet" href="ChangePassword.css" />
    <link rel="stylesheet" type="text/css" href="Style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <Page:Header ID="pgHead" runat="server"/>

                    <asp:SiteMapDataSource 
            ID="SiteMapDataSource1" 
            runat="server" 
            ShowStartingNode="false" 
            SiteMapProvider="XmlSiteMapProvider" />

                    <div class="breadcrumb-container">
                        <asp:SiteMapPath ID="siteMapPath" runat="server" DataSourceID="SiteMapDataSource1" PathSeparator=">">
                            <CurrentNodeStyle CssClass="breadcrumb-current" />
                            <NodeStyle CssClass="breadcrumb-node" />
                            <RootNodeStyle CssClass="breadcrumb-root" />
                        </asp:SiteMapPath>
                    </div>

        <div class="password-container">
                    <div class="password">
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
        </div>

        <Page:Footer ID="pgFooter" runat="server"/> 
    </form>
</body>
</html>
