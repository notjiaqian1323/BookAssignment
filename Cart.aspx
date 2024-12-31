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
            transition: background-color 0.3s;
        }
        .checkout-btn:hover {
            background-color: #218838;
        }
        .checkout-btn:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .selection-reminder {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
            font-style: italic;
        }
        .cart-summary-item {
            display: block;
            margin: 5px 0;
        }
        .delete-btn {
            padding: 5px 10px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
      <script type="text/javascript">
        function updateCheckoutButton() {
            var hasChecked = false;
            var checkboxes = document.querySelectorAll('[id*=chkSelect]');
            
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    hasChecked = true;
                    break;
                }
            }

            var checkoutBtn = document.getElementById('<%= btnCheckout.ClientID %>');
            if (checkoutBtn) {
                checkoutBtn.disabled = !hasChecked;
            }
        }
        window.onload = function() {
            updateCheckoutButton();
        };
      </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cart-container">
            <div class="cart-header">
                <a href="HomePage.aspx">← Continue Shopping</a>
            </div>
            <h1>Shopping Cart</h1>
            
            <asp:GridView ID="gvCart" runat="server" CssClass="cart-grid" 
                AutoGenerateColumns="False" 
                OnRowCommand="gvCart_RowCommand"
                OnRowDataBound="gvCart_RowDataBound">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelect" runat="server" AutoPostBack="true" 
                                OnCheckedChanged="chkSelect_CheckedChanged" onclick="updateCheckoutButton()" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Image ID="imgBook" runat="server" 
                                ImageUrl='<%# Eval("ImageUrl") %>' 
                                CssClass="book-image" 
                                AlternateText="Book Image" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblPrice" runat="server" Text='<%# "RM " + Eval("Price") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" 
                                Text="Delete" 
                                CommandName="DeleteItem"
                                CommandArgument='<%# Eval("CartID") %>'
                                CssClass="delete-btn" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="cart-summary">
                <br />
                <p>Subtotal: RM <asp:Label ID="lblSubtotal" runat="server" Text="0"></asp:Label></p>
                <p>Shipping: RM <asp:Label ID="lblShipping" runat="server" Text="10"></asp:Label></p>
                <p>Total (Tax Included): RM <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></p>
                <asp:Button ID="btnCheckout" runat="server" Text="Checkout" 
                    CssClass="checkout-btn" OnClick="btnCheckout_Click" />
            </div>
        </div>
    </form>
</body>
</html>