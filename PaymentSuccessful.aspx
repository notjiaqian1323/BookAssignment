<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaymentSuccessful.aspx.cs" Inherits="OnlineBookStore.PaymentSuccessful" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Successful</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 100px;
        }

        .checkmark {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #4CAF50;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 60px;
        }

        h1 {
            color: #333;
        }

        .btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="checkmark">✔</div>
            <h1>Payment Successful!</h1>
            <p>Thank you for your purchase.</p>
            <asp:Button ID="btnBackToHome" runat="server" Text="Back to Home" CssClass="btn" OnClick="btnBackToHome_Click" />
            <asp:Button ID="btnOrderHistory" runat="server" Text="Go to Order History" CssClass="btn" OnClick="btnOrderHistory_Click" />
        </div>
    </form>
</body>
</html>
