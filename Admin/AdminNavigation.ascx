<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminNavigation.ascx.cs" Inherits="BookAssignment.Admin.AdminNavigation" %>



<div class="sidebar">
    <div class="logo-details">
        <div class="img-container">
            <img src="../Wallpapers/bookstorelogo.jpg"/>
        </div>
        <span class="logo-name">Mopulah</span>
    </div>
    <ul class="nav-links">
        <li>
            <a href="DashboardRedesign.aspx">
                <i class='bx bx-grid-alt'></i>
                <span class="link_name">Dashboard</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="DashboardRedesign.aspx">Dashboard</a></li>
            </ul>
        </li>
        <li>
            <a href="CustomersRedesign.aspx">
                <i class='bx bxs-user-account' ></i>
                <span class="link_name">Customers</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="CustomersRedesign.aspx">Customers</a></li>
            </ul>
        </li>
        <li>
            <div class="iocn-link">
                <a href="ProductsRedesign.aspx">
                    <i class='bx bxs-book' ></i>
                    <span class="link_name">Products</span>
                </a>
                <i class='bx bxs-chevron-down arrow'></i>
            </div>
            <ul class="sub-menu">
                <li><a class="link_name" href="#">Products</a></li>
                <li><a href="ProductsRedesign.aspx">View Products</a></li>
                <li><a href="ProductDetails.aspx">Product Details</a></li>
            </ul>
        </li>
        <li>
            <a href="Reports.aspx">
                <i class='bx bxs-user-account' ></i>
                <span class="link_name">Notifications</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="Reports.aspx">Notifications</a></li>
            </ul>
        </li>
    <li>
    <div class="profile-details">
        <div class="profile-content">
            <img src="../Images/profile-img.png"/>
        </div>
        
        <div class="name-job">
            <div class="profile_name">User 001</div>
            <div class="job">Admin</div>
        </div>
        <a href="../SelectRole.aspx"><i class='bx bx-log-out' ></i></a>
    </div>
    </li>
    </ul>
</div>

