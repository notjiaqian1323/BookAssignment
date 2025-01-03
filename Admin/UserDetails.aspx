<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="BookAssignment.Admin.UserDetails" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>
    <link rel="stylesheet" type="text/css" href="UserDetails.css"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />
    <title>Customer Details</title>
</head>
<body>
    <form id="form1" runat="server">
         <Admin:Nav ID="admSide" runat="server" />
         <section class="home-section">
                <div class="home-content">
                    <i class='bx bx-menu' ></i>
                    <span class="text">Customer Details</span>
                </div>
                 <div class="main-container">
                    <div class="customer-details">
                        <div class="user-details">
                            <h2 id="lblName" runat="server"></h2>
                            <p><strong>Email:</strong> <span id="lblEmail" runat="server"></span></p>
                            <p><strong>Password:</strong> <span id="lblPassword" runat="server"></span></p>
                            <p><strong>Role:</strong> <span id="lblRole" runat="server"></span></p>
                            <p><strong>Gender:</strong> <span id="lblGender" runat="server"></span></p>
                        </div>
                    </div>
                  <div class="order-details">
                        <h3>Recently Purchased:</h3>
                        <asp:Repeater ID="rptOrderDetails" runat="server">
                            <HeaderTemplate>
                                <div class="order-header">
                                    <span>Order ID</span>
                                    <span>Book Name</span>
                                    <span>Payment Method</span>
                                    <span>Order Date</span>
                                </div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="order-item">
                                    <span><%# Eval("OrderID") %></span>
                                    <span><%# Eval("Title") %></span>
                                    <span><%# Eval("PaymentMethod") %></span>
                                    <span><%# Convert.ToDateTime(Eval("OrderDate")).ToString("dd/MM/yyyy HH:mm") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>


                        <!-- Empty Orders Message -->
                        <asp:Panel ID="pnlNoOrders" runat="server" Visible="false">
                            <div class="order-empty">This user have not bought any books yet.</div>
                        </asp:Panel>
                    </div>
                 </div>
        </section>
    </form>
    <script src="ProductRedesign.js"></script>
</body>
</html>
