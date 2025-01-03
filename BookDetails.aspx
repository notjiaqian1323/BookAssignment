<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="OnlineBookstore.BookDetails" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Book Details</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <style>
        form#form1{
            background-color:transparent;
        }
        body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.book-details-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: auto;
}

.book-details {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    background-color: #ffffff;
    padding: 20px;
    border: 1px solid #ced4da;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    max-width: 800px;
    gap: 20px;
}

.book-image {
    flex: 1;
    max-width: 250px;
    text-align: center;
}

    .book-image img {
        max-width: 100%;
        height: auto;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

.book-info {
    flex: 2;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
}

    .book-info h2 {
        font-size: 24px;
        color: #343a40;
        margin-bottom: 15px;
    }

    .book-info p {
        font-size: 16px;
        color: #6c757d;
        line-height: 1.6;
        margin-bottom: 10px;
    }

    .book-info .price {
        font-size: 20px;
        font-weight: bold;
        color: #007bff;
        margin-top: 10px;
    }

.btn {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    text-align: center;
    cursor: pointer;
    font-size: 16px;
    border-radius: 4px;
}

    .btn:hover {
        background-color: #0056b3;
    }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
        <div class="book-details-container">
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Font-Bold="true" />
            <div class="book-details" runat="server" id="bookDetailsDiv">
                <!-- Book details will be dynamically rendered -->
            </div>
        </div>
    </form>
    <script type="text/javascript">
        function addToCart(bookId) {
            PageMethods.AddToCart(bookId,
                function (response) {
                    alert(response);
                },
                function (error) {
                    console.error('Error:', error);
                    alert('An unexpected error occurred. Please try again later.');
                }
            );
        }
    </script>
</body>
</html>
