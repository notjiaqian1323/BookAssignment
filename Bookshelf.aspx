<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bookshelf.aspx.cs" Inherits="BookAssignment.WebForm2" %>
<%@ Register TagPrefix="Page" TagName="Header" Src="~/PageHeader.ascx" %>
<%@ Register TagPrefix="Page" TagName="Footer" Src="~/PageFooter.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Bookshelf.css" />
    <link rel="stylesheet" type="text/css" href="Style.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <!--Header-->
        <Page:Header ID="pgHead" runat="server"/>
        <div class="adsBoard">
            <div class="slides">
                <div class="slide">
                    <!--Slide 1-->
                    <img src="Images/bookbg1.png"/>
                </div>
                <div class="slide">
                    <!--Slide 2-->
                    <img src="Images/bookbg2.png"/>
                </div>
                <div class="slide">
                    <!--Slide 3-->
                    <img src="Images/bookbg3.png"/>
                </div>
            </div>

            <div class="buttons">
                <span class="prev">&#10094;</span>
                <span class="next">&#10095;</span>
            </div>

            <ul class="dots">
                <li class="active"></li>
                <li></li>
                <li></li>
            </ul>
        </div>

        <div class="bookshelf-header">
            <h3>My Books</h3>
            <img src="Images/right-arrow.png"/>
        </div>

        <div id="card-area">
            <div class="wrapper">
                <div class="box-area" id="booksContainer" runat="server"></div>
            </div>
        </div>

        <Page:Footer ID="pgFooter" runat="server"/>
    </form>
    <script src="Homepage.js"></script>
</body>
</html>
