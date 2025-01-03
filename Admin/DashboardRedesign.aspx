<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardRedesign.aspx.cs" Inherits="BookAssignment.Admin.DashboardRedesign" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Reporting</title>

    <!--External CSS-->
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>
    <link rel="stylesheet" type="text/css" href="Dashboard.css"/>

    <!--Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />

    <!--Icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>

</head>
<body>
    <form id="form1" runat="server">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const imgBox = document.getElementById("imgBox");
                        const imageUrl = "../" + imgBox.getAttribute("data-bg-url");

                        if (imageUrl) {
                            imgBox.style.setProperty('--dynamic-bg', `url('${imageUrl}')`);
                        }
                    });
                </script>

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
                                <div id="imgBox" class="img-box" runat="server"></div>
                                <div class="top-selling">
                                    <strong id="topSellingTitle" runat="server"></strong> is the most top-selling book of the week!
                                </div>
                                <span class="material-icons">groups</span>
                            </div>
                            <!--will change to asp label later-->
                            <!--<asp:Label ></asp:Label>-->
                        </div>
                     </div>

                    <div class="charts">
                        <div class="charts-card">
                            <h2 class="chart-title">Top 5 genres</h2>
                            <div id="bar-chart"></div>
                        </div>

                        <div class="charts-card">
                            <h2 class="chart-title">New Users</h2>
                            <div class="users-list">
                                <asp:Repeater ID="rptNewUsers" runat="server">
                                    <ItemTemplate>
                                        <div class="user-row">
                                            <img src='<%# Eval("ProfilePicture") %>' alt="Profile Picture" class="user-avatar" />
                                            <div class="users-info">
                                                <p class="users-name"><%# Eval("Name") %></p>
                                                <p class="user-date">Created at: <%# Convert.ToDateTime(Eval("CreatedOn")).ToString("dd/MM/yyyy HH:mm") %></p>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
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
