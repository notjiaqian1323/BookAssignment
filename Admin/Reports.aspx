<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="BookAssignment.Admin.WebForm3" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!--External CSS-->
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>

    <!--Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />

    <!--Icons-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
    <title>Reports</title>
</head>
<body>
    <form id="form1" runat="server">
        <Admin:Nav ID="admSide" runat="server" />

         <section class="home-section">
            <div class="home-content">
                <i class='bx bx-menu' ></i>
                <span class="text">Reports</span>
            </div>
             <div class="main-container">
                
             </div>
        </section>
    </form>
    <script src="ProductRedesign.js"></script>
</body>
</html>
