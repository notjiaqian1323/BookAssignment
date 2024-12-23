<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineBookstore.Cart" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping Cart</title>
    <style>
        .cart-container {
            width: 80%;
            margin: 0 auto;
            font-family: Arial, sans-serif;
        }
        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .cart-header a {
            text-decoration: none;
            font-size: 18px;
            color: #007bff;
        }
        .cart-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border: none;
        }
        .cart-grid th {
            display: none; 
        }
        .cart-grid td {
            border: none;
            padding: 10px;
            text-align: left;
        }
        .cart-grid img {
            width: 100px;
            height: auto;
        }
        .cart-summary {
            margin-top: 20px;
            text-align: right;
        }
        .cart-summary input[type="text"] {
            width: 150px;
            margin-right: 10px;
        }
        .checkout-btn {
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .checkout-btn:hover {
            background-color: #218838;
        }
        .cart-summary-item {
            display: block;
            margin: 5px 0;
        }
        .coupon-message {
            color: red; 
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cart-container">
            <div class="cart-header">
                <a href="HomePage.aspx">← Continue Shopping</a>
            </div>
            <h1>Shopping Cart</h1>
          <asp:GridView ID="gvCart" runat="server" CssClass="cart-grid" AutoGenerateColumns="False" OnRowDataBound="gvCart_RowDataBound">
            <Columns>

            
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelect" runat="server" AutoPostBack="true" OnCheckedChanged="chkSelect_CheckedChanged" />
                    </ItemTemplate>
                </asp:TemplateField>

       
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="imgBook" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' CssClass="book-image" AlternateText="Book Image" />
                    </ItemTemplate>
                </asp:TemplateField>

        
                <asp:TemplateField>
                    <ItemTemplate>
                        <%# Eval("Title") %>
                    </ItemTemplate>
                </asp:TemplateField>

            
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="lblPrice" runat="server" Text='<%# "RM " + Eval("Price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>




            <div class="cart-summary">
               
                <br />
                <p>Subtotal: RM <asp:Label ID="lblSubtotal" runat="server" Text="0"></asp:Label></p>
                <p>Shipping: RM <asp:Label ID="lblShipping" runat="server" Text="10"></asp:Label></p>

                <p>
                    Total (Tax Included): RM <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                </p>
                <asp:Button ID="btnCheckout" runat="server" Text="Checkout" CssClass="checkout-btn" OnClick="btnCheckout_Click" />
            </div>
        </div>
    </form>
</body>
</html>

