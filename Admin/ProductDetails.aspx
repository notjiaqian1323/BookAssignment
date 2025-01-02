<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="BookAssignment.Admin.ProductDetails" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!--External CSS-->
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>
    <link rel="stylesheet" type="text/css" href="ProductDetails.css" />

    <!--Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />

    <!--Icons-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
    <title>Product Details</title>
</head>
<body>
    <form id="form1" runat="server">
        <Admin:Nav ID="admSide" runat="server" />

         <section class="home-section">
            <div class="home-content">
                <i class='bx bx-menu' ></i>
                <span class="text">Product Details</span>
            </div>
             <div class="main-container">
                <div class="product-details">
                    <img id="imgBook" runat="server" class="product-image" />
                    <div class="book-details">
                        <h2 id="lblTitle" runat="server"></h2>
                        <p id="lblDescription" runat="server"></p>
                        <p><strong>Genre:</strong> <span id="lblGenre" runat="server"></span></p>
                        <p><strong>Author:</strong> <span id="lblAuthor" runat="server"></span></p>
                        <p><strong>Price:</strong> <span id="lblPrice" runat="server"></span></p>
                    </div>
                </div>
              <div class="order-details">
                    <h3>Recently Ordered By:</h3>
                    <asp:Repeater ID="rptOrderDetails" runat="server">
                        <HeaderTemplate>
                            <div class="order-header">
                                <span>User ID</span>
                                <span>User Name</span>
                                <span>Payment Method</span>
                                <span>Order Date</span>
                                <span>Order ID</span>
                            </div>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="order-item">
                                <span><%# Eval("UserID") %></span>
                                <span><%# Eval("UserName") %></span>
                                <span><%# Eval("PaymentMethod") %></span>
                                <span><%# Convert.ToDateTime(Eval("OrderDate")).ToString("dd/MM/yyyy HH:mm") %></span>
                                <span><%# Eval("OrderID") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>


                    <!-- Empty Orders Message -->
                    <asp:Panel ID="pnlNoOrders" runat="server" Visible="false">
                        <div class="order-empty">No one has purchased this product yet.</div>
                    </asp:Panel>
                </div>
             </div>
        </section>
    </form>
    <script src="ProductRedesign.js"></script>
</body>
</html>
