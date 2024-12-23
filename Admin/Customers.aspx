﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="BookAssignment.Admin.WebForm2" %>
<%@ Register TagPrefix="Admin" TagName="Header" Src="~/Admin/AdminHeader.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customers</title>
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
                    <h2>CUSTOMERS</h2>
                </div>
                <div class="edit-users">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>

                    <asp:ListView ID="lvUsers" runat="server" DataKeyNames="Id" OnItemEditing="lvUsers_ItemEditing"
                        OnItemUpdating="lvUsers_ItemUpdating" OnItemDeleting="lvUsers_ItemDeleting" OnItemCanceling="lvUsers_ItemCanceling">
        
                        <LayoutTemplate>
                            <div class="user-list">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                            </div>
                        </LayoutTemplate>

                        <ItemTemplate>
                            <div class="user-item">
                                <div class="user-info">
                                    <span class="user-id"><%# Eval("Id") %></span>
                                    <span class="user-name"><%# Eval("Name") %></span>
                                    <span class="user-email"><%# Eval("Email") %></span>
                                    <span class="user-role"><%# Eval("Role") %></span>
                                </div>
                                <div class="user-actions">
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-edit" Text="Edit" />
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-delete" Text="Delete" />
                                </div>
                            </div>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <div class="user-item">
                                <div class="user-info">
                                    <span class="user-id"><%# Eval("Id") %></span>
                                    <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' CssClass="edit-name" />
                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="edit-email" />
                                    <asp:TextBox ID="txtRoles" runat="server" Text='<%# Bind("Role") %>' CssClass="edit-roles" />
                                </div>
                                <div class="user-actions">
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn-update" Text="Update" />
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn-cancel" Text="Cancel" />
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
        <!--Charts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/4.1.0/apexcharts.min.js"></script>

        <!--Javascript charts-->
        <script src="Admin.js"></script>
    </form>
</body>
</html>