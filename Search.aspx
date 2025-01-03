<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="BookAssignment.WebForm4" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" type="text/css" href="Search.css" />
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
    <title>Search Results</title>
</head>
<body>
    <form id="form1" runat="server">
        <Page:Header ID="pgHead" runat="server"/>

        <div class="search-header">
            <h3>Search Results for "<asp:Label ID="lblSearchQuery" runat="server"></asp:Label>"</h3>
            <div class="search-container">
                <asp:ImageButton ID="SearchButton" runat="server" ImageUrl="~/Images/search-icon.png" AlternateText="Search" CssClass="search-img" />
                <asp:TextBox runat="server" CssClass="search-txt" ID="txtSearchBox" Placeholder="Title, Author, Keyword"/>
            </div>
        </div>

        <div class="result-header">
            <span>Products (<asp:Label ID="lblTotalResults" runat="server"></asp:Label>)</span>
            <span>Showing <asp:Label ID="lblShownResults" runat="server"></asp:Label> results</span>
        </div>
        <hr />

        <div class="book-container">
            <asp:Repeater ID="rptBooks" runat="server">
                <ItemTemplate>
                    <div class="book-card">
                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Title") %>' />
                        <h4><%# Eval("Title") %></h4>
                        <p><%# Eval("Genre") %></p>
                        <p>$<%# Eval("Price", "{0:0.00}") %></p>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>


    </form>
</body>
</html>
