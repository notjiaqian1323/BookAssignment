<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Flipper.aspx.cs" Inherits="BookAssignment.WebForm8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Flip.css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <div class="book-header">
            <div class="left">
                <img src="Images/menu-icon.png" id="menu-icon"/>
            </div>
            <div class="mid">
                <img src="Images/zoom-out.png" id="zoom-out" />
                <img src="Images/zoom-in.png" id="zoom-in" />
                <asp:TextBox ID="txtPage" runat="server" CssClass="pg-txt" Width="37px">1</asp:TextBox>
                <span> of 12</span>
                <button><img src="Images/search-icon.png"/></button>
            </div>
            <div class="right">
                <img src="Images/light-mode.png"/>
                <img src="Images/dark-mode.png"/>
            </div>
        </div>

        <div class="book-sidebar-chpt">

        </div>

        <div class="flipbook">
            <div class="hard"><asp:Label ID="lblTitle" runat="server"></asp:Label> <small>~ HankTheTank</small></div>
            <div class="hard"></div>
            <div>
                <small>Lets look at some Amazing Pokemon</small>
                <small>Gotta catch'em all</small>
            </div>
            
            <asp:PlaceHolder ID="pagePlaceholder" runat="server"></asp:PlaceHolder>

            <div class="hard"></div>
            <div class="hard">Thank you <small>~ HankTheTank</small></div>
        </div>

        <div class="book-controls">

        </div>
    </form>
    <script src="jquery.js"></script>
    <script src="turn.js"></script>
    <script>
        $(".flipbook").turn();
    </script>
</body>
</html>
