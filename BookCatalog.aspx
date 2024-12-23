<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookCatalog.aspx.cs" Inherits="OnlineBookstore.BookCatalog" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Book Catalog</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <style>
        h1 {
            text-align: center;
            color: #343a40;
            margin: 20px 0;
        }
        .genre-selector {
            text-align: center;
            margin: 20px 0;
        }
        .genre-selector label {
            font-size: 16px;
            margin-right: 10px;
        }
        .genre-selector select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            background-color: #ffffff;
        }
        .book-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .book-card {
            background-color: #ffffff;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
        }
        .book-card img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .book-card h3 {
            font-size: 18px;
            color: #343a40;
            margin: 10px 0;
        }
        .book-card p {
            font-size: 14px;
            color: #6c757d;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <Page:Header ID="pgHeader" runat="server" />
        <h1>Book Catalog</h1>
        <div class="genre-selector">
            <label for="ddlGenres">Select Genre:</label>
            <asp:DropDownList ID="ddlGenres" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlGenres_SelectedIndexChanged">
                <asp:ListItem Text="Select Genre" Value="" />
                <asp:ListItem Text="Fantasy" Value="Fantasy" />
                <asp:ListItem Text="Mystery" Value="Mystery" />
                <asp:ListItem Text="Romance" Value="Romance" />
                <asp:ListItem Text="Science Fiction" Value="Science Fiction" />
                <asp:ListItem Text="Comedy" Value="Comedy" />
            </asp:DropDownList>
        </div>
        <div id="bookContainer" class="book-container" runat="server"></div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Font-Bold="true" />
    </form>
    <script>
        function AddToCart(bookId) {
            $.ajax({
                type: "POST",
                url: "BookCatalog.aspx/AddToCart",
                data: JSON.stringify({ bookId: bookId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    alert("Product added to cart successfully!");
                },
                error: function (xhr, status, error) {
                    alert("Error adding product to cart: " + error);
                }
            });
        }
    </script>
</body>
</html>
