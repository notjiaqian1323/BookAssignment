<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="BookAssignment.WebForm3" %>
<%@ Register TagPrefix="Admin" TagName="Header" Src="~/Admin/AdminHeader.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <title>Admin Reporting</title>

    <!--External CSS-->
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>

    <!--Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />

    <!--Icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="grid-container">
            
            <Admin:Header ID="adminHeader" runat="server" />
            
            <div class="main-container">
                <div class="main-title">
                    <h2>DASHBOARD</h2>
                </div>

                <div class="main-cards">
                    <div class="card">
                        <div class="card-inner">
                            <h3>PRODUCTS</h3>
                            <span class="material-icons">inventory_2</span>
                        </div>
                        
                        <!--will change to asp label later-->
                        <!--<asp:Label ></asp:Label>-->
                        <h1>249</h1>
                    </div>

                    <div class="card">
                        <div class="card-inner">
                            <h3>CUSTOMERS</h3>
                            <span class="material-icons">groups</span>
                        </div>
                        
                        <!--will change to asp label later-->
                        <!--<asp:Label ></asp:Label>-->
                        <h1>219</h1>
                    </div>
                 </div>

                <div class="charts">
                    <div class="charts-card">
                        <h2 class="chart-title">Top 5 Products</h2>
                        <div id="bar-chart"></div>
                    </div>

                    <div class="charts-card">
                        <h2 class="chart-title">Purchases and Sales Orders</h2>
                        <div id="area-chart"></div>
                    </div>
                </div>

            </div>

<%--            <!--Search Bar-->
            <div class="search">
                <asp:ImageButton ID="SearchButton" runat="server" ImageUrl="~/Images/search-icon.png" AlternateText="Search" CssClass="search-icon" />
                <asp:TextBox runat="server" CssClass="search-box" ID="txtSearchBox" Placeholder="Title, Author, Keyword"/>
            </div>

            <!--Login-->
            <div class="login">
                <asp:ImageButton ID="ProfileButton" runat="server" ImageUrl="~/Images/profile-icon.png" AlternateText="Profile" CssClass="profile-icon" />
                <div class="profile-txt">
                    <asp:Label runat="server" CssClass="login-signup" ID="lblloginSignup" Text="Login / SignUp" />
                    <asp:Label runat="server" CssClass="my-Account" ID="lblMyAccount" Text="My Account"/>
                </div>
            </div>

            <!--Cart-->
            <div class="cart">
                <asp:ImageButton ID="CartButton" runat="server" ImageUrl="~/Images/shop-cart.png" AlternateText="Cart" CssClass="cart-icon" />
                <span class="cart-price">RM0.00</span>
                <span class="cart-qty"> (0)</span>
            </div>--%>

        </div>

        <!--Charts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/4.1.0/apexcharts.min.js"></script>

        <!--Javascript charts-->
        <script src="Admin.js"></script>

    </form>
</body>
</html>
