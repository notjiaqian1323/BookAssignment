<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineBookstore.Cart" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="Cart.css" />
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

          function selectAll(selectAllCheckbox) {
              var checkboxes = document.querySelectorAll('[id*=chkSelect]');
              for (var i = 0; i < checkboxes.length; i++) {
                  checkboxes[i].checked = selectAllCheckbox.checked;
              }
              updateCheckoutButton();
          }

          window.onload = function () {
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
            
            <div class="select-all-container" runat="server" id="selectAllContainer" visible="false">
                <asp:CheckBox ID="chkSelectAll" runat="server" Text="Select All" 
                    AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
            </div>

            <asp:GridView ID="gvCart" runat="server" CssClass="cart-grid" 
                AutoGenerateColumns="False" 
                OnRowCommand="gvCart_RowCommand"
                OnRowDataBound="gvCart_RowDataBound">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnBookId" runat="server" Value='<%# Eval("BookId") %>' />
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

            
            <div class="empty-cart" runat="server" id="emptyCartPanel" visible="false">
                <div class="empty-cart-content">
                    <i class="fas fa-shopping-cart" style="font-size: 80px; color: #bdc3c7; margin-bottom: 30px;"></i>
                    <h2>Your cart is empty</h2>
                    <p>Looks like you haven't added anything to your cart yet</p>
                    <a href="BookCatalog.aspx" class="continue-shopping-btn">Continue Shopping</a>
                </div>
            </div>

            <div class="cart-summary">
                <br />
                <p>Subtotal: RM <asp:Label ID="lblSubtotal" runat="server" Text="0"></asp:Label></p>
                <p>Total (Tax Included): RM <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></p>
                <asp:Button ID="btnCheckout" runat="server" Text="Checkout" 
                    CssClass="checkout-btn" OnClick="btnCheckout_Click" />
            </div>
        </div>
    </form>
</body>
</html>