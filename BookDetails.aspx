<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookDetails.aspx.cs" Inherits="OnlineBookstore.BookDetails" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Book Details</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" type="text/css" href="BookDetails.css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
        <div class="book-details-container">

                        <asp:SiteMapDataSource 
            ID="SiteMapDataSource1" 
            runat="server" 
            ShowStartingNode="false" 
            SiteMapProvider="XmlSiteMapProvider" />




            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Font-Bold="true" />


                    <div class="book-details">

                        
                        <div class="breadcrumb-container">
                            <asp:SiteMapPath ID="siteMapPath" runat="server" DataSourceID="SiteMapDataSource1" PathSeparator=">">
                                <CurrentNodeStyle CssClass="breadcrumb-current" />
                                <NodeStyle CssClass="breadcrumb-node" />
                                <RootNodeStyle CssClass="breadcrumb-root" />
                            </asp:SiteMapPath>
                        </div>

                        <div class="book-detail" runat="server" id="bookDetailsDiv">
                            <!-- Book details will be dynamically rendered -->
                        </div>
                        
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
