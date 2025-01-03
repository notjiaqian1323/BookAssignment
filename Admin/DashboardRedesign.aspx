<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardRedesign.aspx.cs" Inherits="BookAssignment.Admin.DashboardRedesign" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Reporting</title>

    <!--External CSS-->
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>

    <!--Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />

    <!--Icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>

</head>
<body>
    <form id="form1" runat="server">
        <Admin:Nav ID="admSide" runat="server" />

         <section class="home-section">
            <div class="home-content">
                <i class='bx bx-menu' ></i>
                <span class="text">Dashboard</span>
            </div>
             <div class="main-container">
                  <div class="main-cards">
                        <div class="card">
                            <div class="card-inner">
                                <h3>PRODUCTS</h3>
                                <span class="material-icons">inventory_2</span>
                            </div>
            
                            <!--will change to asp label later-->
                            <!--<asp:Label ></asp:Label>-->
                            <h1>249</h1>
                        </div>

                        <div class="card">
                            <div class="card-inner">
                                <h3>CUSTOMERS</h3>
                                <span class="material-icons">groups</span>
                            </div>
            
                            <!--will change to asp label later-->
                            <!--<asp:Label ></asp:Label>-->
                            <h1>219</h1>
                        </div>
                     </div>

                    <div class="charts">
                        <div class="charts-card">
                            <h2 class="chart-title">Top 5 genres</h2>
                            <div id="bar-chart"></div>
                        </div>

                        <div class="charts-card">
                            <h2 class="chart-title">New Users</h2>
                            <div></div>
                        </div>
                    </div>
            </div>  
        </section>

        <!--Charts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/4.1.0/apexcharts.min.js"></script>

        <!--Javascript charts-->
        <script src="Admin.js"></script>

    </form>
</body>
</html>
