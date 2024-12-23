<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineBookStore.Checkout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            justify-content: space-between;
        }

        .form-section {
            width: 55%;
        }

        .order-summary {
            width: 40%;
            border: none;
            padding: 15px;
            background-color: #f9f9f9;
        }

        h3 {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"], select, .form-section input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            text-align: center;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            border: none;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Checkout Page</h1>

        <div class="container">
            <!-- Shipping Address Section -->
            <div class="form-section">
                <h3>Billing Address</h3>

                <label for="txtFullName">Full Name:</label>
                <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>

                <label for="txtStreetAddress">Street Address:</label>
                <asp:TextBox ID="txtStreetAddress" runat="server"></asp:TextBox>

                <label for="txtApartment">Apartment/Suite:</label>
                <asp:TextBox ID="txtApartment" runat="server"></asp:TextBox>

                <label for="ddlState">State:</label>
                <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                    <asp:ListItem Text="-- Select State --" Value=""></asp:ListItem>
                    <asp:ListItem Text="Selangor" Value="Selangor"></asp:ListItem>
                    <asp:ListItem Text="Johor" Value="Johor"></asp:ListItem>
                    <asp:ListItem Text="Kedah" Value="Kedah"></asp:ListItem>
                    <asp:ListItem Text="Kelantan" Value="Kelantan"></asp:ListItem>
                    <asp:ListItem Text="Negeri Sembilan" Value="Negeri Sembilan"></asp:ListItem>
                    <asp:ListItem Text="Pahang" Value="Pahang"></asp:ListItem>
                    <asp:ListItem Text="Perak" Value="Perak"></asp:ListItem>
                    <asp:ListItem Text="Perlis" Value="Perlis"></asp:ListItem>
                    <asp:ListItem Text="Pulau Pinang" Value="Pulau Pinang"></asp:ListItem>
                    <asp:ListItem Text="Sabah" Value="Sabah"></asp:ListItem>
                    <asp:ListItem Text="Sarawak" Value="Sarawak"></asp:ListItem>
                    <asp:ListItem Text="Terengganu" Value="Terengganu"></asp:ListItem>
                    <asp:ListItem Text="Melaka" Value="Melaka"></asp:ListItem>
                    <asp:ListItem Text="Kuala Lumpur" Value="Kuala Lumpur"></asp:ListItem>
                    <asp:ListItem Text="Labuan" Value="Labuan"></asp:ListItem>
                    <asp:ListItem Text="Putrajaya" Value="Putrajaya"></asp:ListItem>

                </asp:DropDownList>

                <label for="ddlCity">City:</label>
                <asp:DropDownList ID="ddlCity" runat="server" Enabled="False">
                    <asp:ListItem Text="-- Select City --" Value=""></asp:ListItem>
                </asp:DropDownList>

                <label for="txtZipCode">Zip Code:</label>
                <asp:TextBox ID="txtZipCode" runat="server"></asp:TextBox>

                <label for="txtPhone">Phone:</label>
                <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>

                <label for="txtEmail">Email Address:</label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            </div>

            <!-- Order Summary Section -->
            <div class="order-summary">
                <h3>Your Order</h3>
                <asp:GridView ID="gvOrderSummary" runat="server" AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Width="100" Height="100" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:F2}" />
                    </Columns>
                </asp:GridView>

                <label for="txtCouponCode">Have a coupon code?</label>
                <asp:TextBox ID="txtCouponCode" runat="server"></asp:TextBox>
                <asp:Button ID="btnApplyCoupon" runat="server" Text="Apply" CssClass="btn" />

                <h3>Payment Method</h3>
                <asp:TextBox ID="txtCreditCardNumber" runat="server" Placeholder="Credit Card Number"></asp:TextBox><br />
                <asp:TextBox ID="txtExpiry" runat="server" Placeholder="MM/YY"></asp:TextBox><br />
                <asp:TextBox ID="txtCVC" runat="server" Placeholder="CVC/CVV"></asp:TextBox><br />

                <p>Coupon Applied: <asp:Label ID="lblCouponCodes" runat="server" Text="None"></asp:Label></p>
                <p>Subtotal: <asp:Label ID="lblSubtotals" runat="server" Text="0.00"></asp:Label></p>
                <p>Total: <asp:Label ID="lblTotals" runat="server" Text="0.00"></asp:Label></p>

                <asp:Button ID="btnCompleteOrder" runat="server" Text="Complete Order" CssClass="btn" OnClick="btnCompleteOrder_Click" />

        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>

    </form>
</body>
</html>
