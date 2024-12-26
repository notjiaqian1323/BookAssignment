<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageHeader.ascx.cs" Inherits="BookAssignment.WebUserControl1" %>

        <!--Header-->
        <div class="top">

            <span class="toptitle"><a href="HomePage.aspx">BookStore</a></span>

            <!--Search Bar-->
            <div class="search">
                <asp:ImageButton ID="SearchButton" runat="server" ImageUrl="~/Images/search-icon.png" AlternateText="Search" CssClass="search-icon" OnClick="SearchButton_Click" />
                <asp:TextBox runat="server" CssClass="search-box" ID="txtSearchBox" Placeholder="Title, Author, Keyword"/>
            </div>

            <!--Login-->
            <div class="login">
                <asp:ImageButton ID="ProfileButton" runat="server" ImageUrl="~/Images/profile-icon.png" AlternateText="Profile" CssClass="profile-icon" OnClick="ProfileButton_Click" />
                <div class="profile-txt">
                    <asp:Label runat="server" CssClass="login-signup" ID="lblloginSignup" Text="Login / SignUp" />
                    <asp:Label runat="server" CssClass="my-Account" ID="lblMyAccount" Text="My Account"/>
                </div>
            </div>

            <!--Cart-->
            <div class="cart">
                <asp:ImageButton ID="CartButton" runat="server" ImageUrl="~/Images/shop-cart.png" AlternateText="Cart" CssClass="cart-icon" OnClick="CartButton_Click" />
                <span class="cart-price">RM0.00</span>
                <span class="cart-qty"> (0)</span>
            </div>

        </div>
        
        <!--Nav links-->
        <div class="nav-bar">
            <ul class="nav-item">
                <span><a href="BookCatalog.aspx">Bestsellers</a></span>
                <img src="Images/nav-down.png" class="nav-down" />
            </ul>
            <ul class="nav-item">
                <span><a href="BookCatalog.aspx">Fiction</a></span>
                <img src="Images/nav-down.png" class="nav-down" />
            </ul>
            <ul class="nav-item">
                <span><a href="BookCatalog.aspx">Non-Fiction</a></span>
                <img src="Images/nav-down.png" class="nav-down" />
            </ul>
            <ul class="nav-item dropdown">
                <span>My Account</span>
                <img src="Images/nav-down.png" class="nav-down" />
                <ul class="dropdown-menu">
                    <li><a href="ProfileManagement.aspx">Edit Profile</a></li>
                    <li><a href="ProfileManagement.aspx">Orders</a></li>
                    <li><a href="ProfileManagement.aspx">Account Security</a></li>
                    <li><a href="Bookshelf.aspx">My Books</a></li>
                </ul>
            </ul>
        </div>


