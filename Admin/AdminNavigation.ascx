<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminNavigation.ascx.cs" Inherits="BookAssignment.Admin.AdminNavigation" %>



<div class="sidebar">
    <div class="logo-details">
        <div class="img-container">
            <img src="../Wallpapers/bookstorelogo.jpg"/>
        </div>
        <span class="logo-name">Mopular</span>
    </div>
    <ul class="nav-links">
        <li>
            <a href="Dashboard.aspx">
                <i class='bx bx-grid-alt'></i>
                <span class="link_name">Dashboard</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="#">Dashboard</a></li>
            </ul>
        </li>
        <li>
            <div class="iocn-link">
                <a href="#">
                    <i class='bx bxs-user-account' ></i>
                    <span class="link_name">Customers</span>
                </a>
                <i class='bx bxs-chevron-down arrow'></i>
            </div>
            <ul class="sub-menu">
                <li><a class="link_name" href="#">Customers</a></li>
                <li><a href="Customers.aspx">View Customers</a></li>
                <li><a href="UserDetails.aspx">Customer Details</a></li>
            </ul>
        </li>
        <li>
            <div class="iocn-link">
                <a href="#">
                    <i class='bx bxs-book' ></i>
                    <span class="link_name">Products</span>
                </a>
                <i class='bx bxs-chevron-down arrow'></i>
            </div>
            <ul class="sub-menu">
                <li><a class="link_name" href="#">Products</a></li>
                <li><a href="ProductsRedesign.aspx">View Products</a></li>
                <li><a href="ProductDetails.aspx">Product Details</a></li>
                <li><a href="AddProduct.aspx">Add Products</a></li>
            </ul>
        </li>
        <li>
            <a href="Reports.aspx">
                <i class='bx bxs-user-account' ></i>
                <span class="link_name">Notifications</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="#">Notifications</a></li>
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
        <i class='bx bx-log-out' ></i>
    </div>
    </li>
    </ul>
</div>

