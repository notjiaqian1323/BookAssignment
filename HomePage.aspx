<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="BookAssignment.WebForm1" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<%@ Register TagPrefix="Page" TagName="Footer" Src="~/PageFooter.ascx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />

</head>
<body>
    <form id="form1" runat="server">
        <Page:Header ID="pgHead" runat="server"/>

        <!--Ads board-->
        <div class="adsBoard">
            <div class="slides">
                <div class="slide">
                    <!--Slide 1-->
                    <img src="Images/bookbg1.png"/>
                </div>
                <div class="slide">
                    <!--Slide 2-->
                    <img src="Images/bookbg2.png"/>
                </div>
                <div class="slide">
                    <!--Slide 3-->
                    <img src="Images/bookbg3.png"/>
                </div>
            </div>

            <div class="buttons">
                <span class="prev">&#10094;</span>
                <span class="next">&#10095;</span>
            </div>

            <ul class="dots">
                <li class="active"></li>
                <li></li>
                <li></li>
            </ul>

        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringA %>" SelectCommand="SELECT * FROM [Books]"></asp:SqlDataSource>

        <!--Fiction Section-->
        <div class="fiction-section section">
            <span class="sect-title">Fiction</span>
            <span class="sect-desc">Latest Bestsellers</span>
            <div class="books">
                <asp:Repeater ID="rptBookFiction" runat="server">
                    <ItemTemplate>
                        <div class="book">
                            <img src='<%# Eval("ImageUrl") %>' />
                            <span class="book-title"><%# Eval("Title") %></span>
                            <span class="price-lbl">RM<%# Eval("Price", "{0:0.00}") %></span></div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!--Non-Fiction Section-->
        <div class="nfiction-section section">
            <span class="sect-title">Non Fiction</span>
            <span class="sect-desc">Latest Bestsellers</span>
            <div class="books">
                <asp:Repeater ID="rptBooknFiction" runat="server">
                    <ItemTemplate>
                        <div class="book">
                            <img src='<%# Eval("ImageUrl") %>' />
                            <span class="book-title"><%# Eval("Title") %></span>
                            <span class="price-lbl">RM<%# Eval("Price", "{0:0.00}") %></span></div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!--Promotion Section-->
        <div class="promo-section section">
            <span class="sect-title">Promo for All!</span>
            <span class="sect-desc">(20% OFF for Members Only) *Sign up for FREE today!</span>
            <div class="books">
                <asp:Repeater ID="rptBookPromo" runat="server">
                    <ItemTemplate>
                        <div class="book">
                            <img src='<%# Eval("ImageUrl") %>' />
                            <span class="book-title"><%# Eval("Title") %></span>
                            <span class="price-lbl">RM<%# Eval("Price", "{0:0.00}") %></span></div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <Page:Footer ID="pgFooter" runat="server"/> 

    </form>
    <script src="Homepage.js"></script>
</body>
</html>
