<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="OnlineBookstore.BookDetails" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Book Details</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" href="BookDetails.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="book-details-container">
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Font-Bold="true" />
            <div class="book-details" runat="server" id="bookDetailsDiv">
                <!-- Book details will be dynamically rendered -->
            </div>
        </div>
    </form>
</body>
</html>
