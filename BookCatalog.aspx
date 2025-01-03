<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookCatalog.aspx.cs" Inherits="OnlineBookstore.BookCatalog" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<%@ Register TagPrefix="Page" TagName="Footer" Src="~/PageFooter.ascx" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Book Catalog</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" href="BookCatalog.css" />
    <script src="https://kit.fontawesome.com/637a048940.js" crossorigin="anonymous"></script>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
</head>
<body>
    <form id="form1" runat="server">
        <Page:Header ID="pgHeader" runat="server" />
        <h1>Book Catalog</h1>
        <script type="text/javascript">
            // Function to show toast notifications
            function showToast(message, type = 'success') {
                const toastContainer = document.getElementById('toast-container');
                const toast = document.createElement('div');
                toast.className = `toast ${type}`;
                toast.innerHTML = `${message}`;

                toastContainer.appendChild(toast);

                // Remove toast after timeout
                setTimeout(() => {
                    toast.remove();
                }, 5000); // Toast will disappear after 5 seconds
            }


            function addToCart(bookId) {
                PageMethods.AddToCart(bookId,
                    function (response) {
                        if (response.includes("REFRESH")) {
                            showToast('<i class="fa-solid fa-circle-check"></i>  Product added to cart successfully!', 'success');
                            setTimeout(() => {
                                window.location.reload();
                            }, 1000); // Allow time for toast display
                        } else if (response.includes("already")) {
                            showToast(response, 'error');
                        } else if (response.includes("log in")) {
                            showToast(response, 'error');
                        } else {
                            showToast(response, 'success');
                        }
                    },
                    function (error) {
                        console.error('An error occurred while adding the book to the shopping cart:', error);
                        showToast('<i class="fa-solid fa-circle-exclamation"></i>  An unexpected error occurred. Please try again later.', 'error');
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
                <asp:DropDownList ID="ddlTitleFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTitleFilter_SelectedIndexChanged">
                    <asp:ListItem Text="Sort by Title" Value="" />
                    <asp:ListItem Text="A to Z" Value="AtoZ" />
                </asp:DropDownList>
                <asp:DropDownList ID="ddlPriceFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPriceFilter_SelectedIndexChanged">
                    <asp:ListItem Text="Sort by Price" Value="" />
                    <asp:ListItem Text="Low to High" Value="LowToHigh" />
                    <asp:ListItem Text="High to Low" Value="HighToLow" />
                </asp:DropDownList>
          
           
            </div>
            <div class="price-sort"> </div>
            <div class="title-sort"> </div>
        
        <div id="bookContainer" class="book-container" runat="server"></div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Font-Bold="true" />
        <div id="toast-container"></div>

        <Page:Footer ID="pgFooter" runat="server"/> 
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    </form>
</body>
</html>
