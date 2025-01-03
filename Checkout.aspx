<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineBookStore.Checkout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout Page</title>
    <link rel="stylesheet" type="text/css" href="Checkout.css" />
    <script type="text/javascript">
        function showPaymentFields(type) {
            var creditFields = document.getElementById('creditCardFields');
            var debitFields = document.getElementById('debitCardFields');

            if (type === 'credit') {
                creditFields.style.display = 'block';
                debitFields.style.display = 'none';
            } else {
                creditFields.style.display = 'none';
                debitFields.style.display = 'block';
            }
        }

        window.onload = function () {
            var rdoCredit = document.getElementById('<%= rdoCredit.ClientID %>');
            var rdoDebit = document.getElementById('<%= rdoDebit.ClientID %>');

            rdoCredit.addEventListener('change', function () {
                if (this.checked) showPaymentFields('credit');
            });

            rdoDebit.addEventListener('change', function () {
                if (this.checked) showPaymentFields('debit');
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="checkout-layout">
                <!-- Left Section -->
                <div class="left-section">
                    <h3>Your Order</h3>
                    <div class="order-summary">
                        <asp:GridView ID="gvOrderSummary" runat="server" AutoGenerateColumns="false" 
                            CssClass="order-grid" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderText="Product Name">
                                    <ItemTemplate>
                                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' 
                            Width="80" Height="80" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Title" HeaderText="Title" />
                                <asp:BoundField DataField="Price" HeaderText="Price" 
                            DataFormatString="RM {0:F2}" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <!-- Payment Method Section -->
                    <div class="payment-method">
                        <h3>Payment Method</h3>
                        <div class="payment-options">
                            <asp:RadioButton ID="rdoCredit" runat="server" GroupName="PaymentType" 
                                Text="Credit Card" />
                            <asp:RadioButton ID="rdoDebit" runat="server" GroupName="PaymentType" 
                                Text="Paypal" />
                        </div>

                        <!-- Credit Card Fields -->
                        <div id="creditCardFields" style="display: none;">
                            <asp:TextBox ID="txtCreditCardName" runat="server" 
                                placeholder="Name on Card" autocomplete="off"></asp:TextBox>
                            <asp:TextBox ID="txtCreditCardNumber" runat="server" 
                                placeholder="Credit Card Number" autocomplete="off"></asp:TextBox>
                            <asp:TextBox ID="txtExpiry" runat="server" 
                                placeholder="MM/YY" autocomplete="off"></asp:TextBox>
                            <asp:TextBox ID="txtCVC" runat="server" 
                                placeholder="CVV" autocomplete="off"></asp:TextBox>
                        </div>

                        <!-- Debit Card Fields -->
                        <div id="debitCardFields" style="display: none;">
                            <asp:TextBox ID="txtDebitUsername" runat="server" 
                                placeholder="Username" autocomplete="off"></asp:TextBox>
                            <asp:TextBox ID="txtDebitPassword" runat="server" 
                                TextMode="Password" placeholder="Password" autocomplete="off"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- Right Section -->
                <div class="right-section">
                    <h3>Your Order</h3>
                    <div class="summary-section">
                        <p>Subtotal Product<span><asp:Label ID="lblSubtotals" runat="server" 
                            Text="RM 0.00"></asp:Label></span></p>
                        <div class="coupon-section">
                            <asp:TextBox ID="txtCouponCode" runat="server" 
                                placeholder="Coupon Code"></asp:TextBox>
                            <asp:Button ID="btnApplyCoupon" runat="server" Text="Apply" 
                                CssClass="btn" OnClick="btnApplyCoupon_Click" />
                        </div>
                        <p>Coupon Code: <asp:Label ID="lblCouponCodes" runat="server" 
                            Text="None"></asp:Label></p>
                        <p class="total">Total (RM)<span><asp:Label ID="lblTotals" runat="server" 
                            Text="0.00"></asp:Label></span></p>
                    </div>

                    <asp:Button ID="btnCompleteOrder" runat="server" Text="Complete Order" 
                        CssClass="btn complete-order-btn" OnClick="btnCompleteOrder_Click" />
                </div>
            </div>

            <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message"></asp:Label>
        </div>
    </form>
</body>
</html>