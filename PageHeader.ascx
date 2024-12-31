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
                <span id="CartPrice" runat="server" class="cart-price">RM0.00</span>
                <span id="CartQty" runat="server" class="cart-qty">(0)</span>
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
                    <li><a href="UpdateInfo.aspx">Edit Profile</a></li>
                    <li><a href="OrderHistory.aspx">Orders</a></li>
                    <li><a href="ChangePassword.aspx">Account Security</a></li>
                    <li><a href="Bookshelf.aspx">My Books</a></li>
                </ul>
            </ul>
        </div>

<script>
    // Function to refresh the cart labels dynamically
    async function refreshCart() {
        try {
            const response = await fetch('PageHeader.ascx/GetCartSummary', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            const data = await response.json();

            if (data.error) {
                console.error('Cart Update Error:', data.error);
                return;
            }

            document.getElementById('<%= CartPrice.ClientID %>').innerText = `RM${data.totalPrice}`;
            document.getElementById('<%= CartQty.ClientID %>').innerText = `(${data.itemCount})`;
        } catch (error) {
            console.error('Error fetching cart summary:', error);
        }
    }

    // Function to add product to the cart
    async function addToCart(bookId) {
        try {
            const response = await fetch('YourWebService.asmx/AddToCart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            const data = await response.json();

            if (data.success) {
                console.log('Product added to cart successfully!');
                await refreshCart(); // Update cart dynamically after adding
            } else {
                console.error('Error adding to cart:', data.message);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }
</script>




