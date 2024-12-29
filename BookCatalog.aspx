<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookCatalog.aspx.cs" Inherits="OnlineBookstore.BookCatalog" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Book Catalog</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" href="BookCatalog.css" />

    <script type="text/javascript">
        function addToCart(bookId) {
            PageMethods.AddToCart(bookId, function (response) {
                alert(response);
            }, function (error) {
                alert('Error: ' + error.get_message());
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <Page:Header ID="pgHeader" runat="server" />
        <h1>Book Catalog</h1>
        <script type="text/javascript">
            function addToCart(bookId) {
                PageMethods.AddToCart(bookId,
                    function (response) {
                        alert(response);
                    },
                    function (error) {
                        console.error('An error occurred while adding the book to the shopping cart:', error);
                        alert('An unexpected error occurred. Please try again later.');
                    }
                );
            }
        </script>
        <div class="genre-selector">
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
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    </form>
</body>
</html>
