<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaymentSuccessful.aspx.cs" Inherits="OnlineBookStore.PaymentSuccessful" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Successful</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        :root {
            --primary-color: #34c759;
            --primary-hover: #30b850;
            --secondary-color: #007aff;
            --secondary-hover: #0056b3;
            --text-color: #2c3e50;
            --light-gray: #f8f9fa;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            background-color: var(--light-gray);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .success-container {
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-align: center;
            max-width: 500px;
            width: 90%;
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .success-icon {
            width: 90px;
            height: 90px;
            background: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            position: relative;
            animation: scaleIn 0.5s ease-out 0.2s both;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0.5);
            }
            to {
                transform: scale(1);
            }
        }

        .success-icon i {
            color: white;
            font-size: 40px;
            animation: checkmark 0.4s ease-out 0.7s both;
        }

        @keyframes checkmark {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        h1 {
            color: var(--text-color);
            font-size: 28px;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .success-message {
            color: #666;
            font-size: 16px;
            margin-bottom: 2rem;
            line-height: 1.5;
        }

        .buttons-container {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background-color: var(--secondary-hover);
            transform: translateY(-2px);
        }

        .order-info {
            background: var(--light-gray);
            padding: 1.5rem;
            border-radius: 12px;
            margin: 2rem 0;
            text-align: left;
        }

        .order-info p {
            margin: 0.5rem 0;
            color: var(--text-color);
        }

        .order-number {
            font-family: monospace;
            font-size: 1.1em;
            color: var(--secondary-color);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="success-container">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h1>Payment Successful!</h1>
            <p class="success-message">Thank you for your purchase. Your order has been confirmed.</p>
            
            <div class="order-info">
                <p><strong>Order Number:</strong> <span class="order-number">#<%: Session["OrderId"] %></span></p>
                <p><strong>Date:</strong> <%: DateTime.Now.ToString("dd MMM yyyy, HH:mm") %></p>
            </div>

            <div class="buttons-container">
                <asp:Button ID="btnBackToHome" runat="server" 
                    Text="Back to Home" 
                    CssClass="btn btn-secondary" 
                    OnClick="btnBackToHome_Click" />
                
                <asp:Button ID="btnOrderHistory" runat="server" 
                    Text="View Orders" 
                    CssClass="btn btn-primary" 
                    OnClick="btnOrderHistory_Click" />
            </div>
        </div>
    </form>
</body>
</html>