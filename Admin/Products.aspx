<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="BookAssignment.Admin.WebForm1" %>
<%@ Register TagPrefix="Admin" TagName="Header" Src="~/Admin/AdminHeader.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Products</title>
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>
    <link rel="stylesheet" type="text/css" href="Products.css"/>
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
                    <h2>PRODUCTS</h2>
                    <div class="right">
                        <img id = "add-icon" src="../Images/more.png"/>
                        <span>Add More Products</span>
                    </div>
                </div>
                <div class="data-container">

                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

                    <asp:ListView ID="lvBooks" runat="server" DataKeyNames="BookID" OnItemCanceling="lvBooks_ItemCanceling" OnItemDeleting="lvBooks_ItemDeleting" OnItemEditing="lvBooks_ItemEditing" OnItemUpdating="lvBooks_ItemUpdating">
                        <ItemTemplate>
                            <div class="container">
                                <!-- Book Image -->
                                <div class="image-container">
                                    <asp:Image ID="imgBook" runat="server" ImageUrl='<%# "~/" + Eval("ImageUrl") %>' CssClass="book-image" />
                                </div>
        
                                <!-- Book Details (Title and Price) -->
                                <div class="details">
                                    <asp:Label ID="lblBookName" runat="server" Text='<%# Eval("Title") %>' CssClass="book-title"></asp:Label>
                                    <asp:Label ID="lblBookDesc" runat="server" Text='<%# Eval("Description") %>' CssClass="book-desc"></asp:Label>
                                    <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price", "{0:C}") %>' CssClass="book-price"></asp:Label>
                                    <button type="button" class="btn-details" data-id='<%# Eval("Title") %>' data-description='<%# Eval("Description") %>' 
                                        data-genre='<%# Eval("Genre") %>' data-price='<%# Eval("Price") %>'>View Details</button>
                                </div>

                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="edit-button" />
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="delete-button" />
                                </div>
                            </div>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <div class="container">
                                <!-- Image Upload -->
                                <div class="image-container">
                                    <asp:FileUpload ID="fuImagePath" runat="server" CssClass="file-upload" />
                                    <asp:HiddenField ID="hfImagePath" runat="server" Value='<%# Bind("ImageUrl") %>' />
                                </div>

                                <!-- Book Details (Title and Price) -->
                                <div class="details">
                                    <asp:TextBox ID="txtBookName" runat="server" Text='<%# Bind("Title") %>' CssClass="edit-textbox book-title-input"></asp:TextBox>
                                    <asp:TextBox ID="txtBookDesc" runat="server" Text='<%# Bind("Description") %>' CssClass="edit-textbox book-desc-input"></asp:TextBox>
                                    <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' CssClass="edit-textbox book-price-input"></asp:TextBox>
                                </div>

                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="update-button" />
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="cancel-button" />
                                </div>
                            </div>
                        </EditItemTemplate>

                    </asp:ListView>
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

        <div class="popup">
                    <button class="close-btn">&times;</button>
                    <h2>User Details</h2>
                    <div id="userDetailsContent">
                        <!-- User details will be injected dynamically -->
                    </div>
        </div>
        
        <!--Charts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/4.1.0/apexcharts.min.js"></script>

        <!--Javascript charts-->
        <script src="Admin.js"></script>
    </form>
</body>
</html>
