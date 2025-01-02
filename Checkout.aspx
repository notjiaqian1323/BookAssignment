<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineBookStore.Checkout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f4f4f4;
        }

        .container {
            width: 100%;
            max-width: 900px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
        }

        .checkout-layout {
            display: flex;
            gap: 30px;
        }

        .left-section {
            flex: 2;
        }

        .right-section {
            flex: 1;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            height: fit-content;
        }

        h1 {
            text-align: left;
            margin-bottom: 20px;
        }

        h3 {
            margin-top: 20px;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 8px 15px;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .complete-order-btn {
            width: 100%;
            margin-top: 20px;
        }

        /* 订单表格样式 */
        .order-grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .order-grid th {
            background-color: #fff;
            padding: 10px;
            text-align: left;
            font-weight: bold;
            border-bottom: 1px solid #ddd;
        }

        .order-grid td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .summary-section p {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            padding: 5px 0;
        }

        .total {
            font-weight: bold;
            font-size: 1.1em;
            border-top: 1px solid #ddd;
            padding-top: 10px;
            margin-top: 10px;
        }

        /* Coupon section styles */
        .coupon-section {
            margin: 15px 0;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .coupon-section input[type="text"] {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .coupon-section .btn {
            white-space: nowrap;
        }

        .payment-method {
            margin-top: 20px;
        }

        .payment-method input[type="text"],
        .payment-method input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .payment-options {
            margin-bottom: 15px;
        }

        .payment-options input[type="radio"] {
            margin-right: 5px;
        }

        .payment-options label {
            margin-right: 20px;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }

        .right-section h3 {
            margin-top: 0;
        }
    </style>
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