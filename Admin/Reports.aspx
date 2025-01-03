<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="BookAssignment.Admin.WebForm3" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!--External CSS-->
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>
    <link rel="stylesheet" type="text/css" href="Reports.css"/>

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
            <div class="content">
                 <div class="container">
                    <header>
                        <div class="notif_box">
                            <h2 class="title">
                                Notifications
                            </h2>
                            <span id="notifications"></span>
                        </div>
                        <p id="mark_all">Mark all as read</p>
                    </header>
                     <main>
                         <asp:Literal ID="notifContainer" runat="server"></asp:Literal>
<%--                         <div class="notif_card unread">
                             <img src="../ProfilePic/defaultpic.png"/>
                             <div class="description">
                                 <p class="user_activity">
                                     <strong>User 1</strong> made an order of <b>Demeter</b>
                                 </p>
                                 <p class="time">1m ago</p>
                             </div>
                         </div>
                         <div class="notif_card unread">
                             <img src="../ProfilePic/defaultpic.png"/>
                             <div class="description">
                                 <p class="user_activity">
                                     <strong>User 2</strong> made an order of <b>Born a Crime</b>
                                 </p>
                                 <p class="time">1m ago</p>
                             </div>
                         </div>
                         <div class="notif_card unread">
                             <img src="../ProfilePic/defaultpic.png"/>
                             <div class="description">
                                 <p class="user_activity">
                                     <strong>User 3</strong> made an order of <b>One and Only</b>
                                 </p>
                                 <p class="time">1m ago</p>
                             </div>
                         </div>
                         <div class="notif_card">
                             <div class="message_card">
                                 <img src="../ProfilePic/defaultpic.png"/>
                                 <div class="description">
                                     <p class="user_activity">
                                         <strong>User 4</strong> sent you a feedback:
                                     </p>
                                     <div class="message">
                                         <p>Hello, very good service! Hope to shop more often at your bookstore!</p>
                                     </div>
                                     <p class="time">5 days ago</p>
                                 </div>
                             </div>
                         </div>

                         <div class="notif_card">
                             <img src="../ProfilePic/defaultpic.png"/>
                             <div class="description">
                                 <p class="user_activity">
                                     <strong>User 5</strong> made an order of <b>One and Only</b>
                                 </p>
                                 <p class="time">6 days ago</p>
                             </div>
                         </div>
                         <div class="notif_card">
                             <img src="../ProfilePic/defaultpic.png"/>
                             <div class="description">
                                 <p class="user_activity">
                                     <strong>User 6</strong> made an order of <b>Raven Strategy</b>
                                 </p>
                                 <p class="time">1 week ago</p>
                             </div>
                         </div>
                         <div class="notif_card">
                             <img src="../ProfilePic/defaultpic.png"/>
                             <div class="description">
                                 <p class="user_activity">
                                     <strong>User 7</strong> made an order of <b>Born a Crime</b>
                                 </p>
                                 <p class="time">2 weeks ago</p>
                             </div>
                         </div>--%>
                     </main>
                 </div>
            </div>
        </section>
    </form>
    <script src="ProductRedesign.js"></script>
    <script src="Reports.js"></script>
</body>
</html>
