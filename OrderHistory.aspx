<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="OnlineBookStore.OrderHistory" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order History</title>
     <link rel="stylesheet" type="text/css" href="OrderHistory.css" />
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="order-history-container">
            <div class="order-history-title">
                Order History
            </div>
            
            <asp:Panel ID="pnlNoOrders" runat="server" CssClass="no-orders" Visible="false">
                <i class="fas fa-receipt icon" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                <p>No orders found.</p>
            </asp:Panel>

            <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                <ItemTemplate>
                    <div class="order-card">
                        <div class="order-header">
                            <i class="fas fa-book icon"></i>
                            <span class="order-number">Order #<%# Eval("OrderID") %></span>
                        </div>
                        <div class="order-details">
                            <div class="book-title"><%# Eval("BookTitles") %></div>
                            <div class="order-meta">
                                <div class="meta-item">
                                    <i class="fas fa-calendar icon"></i>
                                    <span><%# Convert.ToDateTime(Eval("OrderDate")).ToString("dd/MM/yyyy HH:mm") %></span>
                                </div>
                                <div class="meta-item">
                                    <i class="fas fa-credit-card icon"></i>
                                    <span><%# Eval("PaymentMethod") %></span>
                                </div>
                            </div>
                        </div>
                        <div class="order-actions">
                            <span class="price"><%# $"RM {Convert.ToDecimal(Eval("TotalPrice")):F2}" %></span>
                            <asp:LinkButton ID="btnGenerateInvoice" runat="server" 
                                CssClass="generate-invoice-btn"
                                CommandName="GenerateInvoice"
                                CommandArgument='<%# Eval("OrderID") %>'>
                                <i class="fas fa-download"></i>
                                Invoice
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>