<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="OnlineBookStore.OrderHistory" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order History</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        .order-history-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 1rem;
        }

        .order-history-title {
            text-align: center;
            margin-bottom: 1rem;
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
        }

        .order-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 0.75rem;
            transition: box-shadow 0.2s;
        }

        .order-card:hover {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .order-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .order-number {
            font-weight: 600;
            color: #2563eb;
        }

        .order-details {
            margin-bottom: 0.5rem;
        }

        .book-title {
            font-weight: 500;
            margin-bottom: 0.25rem;
            color: #333;
        }

        .order-meta {
            display: flex;
            gap: 1rem;
            color: #666;
            font-size: 0.875rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .order-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 0.75rem;
            padding-top: 0.75rem;
            border-top: 1px solid #f0f0f0;
        }

        .price {
            font-size: 1.125rem;
            font-weight: bold;
            color: #333;
        }

        .generate-invoice-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            background-color: #22c55e;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .generate-invoice-btn:hover {
            background-color: #16a34a;
        }

        .icon {
            font-size: 0.875rem;
        }

        .no-orders {
            text-align: center;
            padding: 2rem;
            color: #666;
            font-size: 1rem;
        }

        @media (max-width: 640px) {
            .order-meta {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .order-actions {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .price {
                margin-bottom: 0.5rem;
            }
        }
    </style>
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