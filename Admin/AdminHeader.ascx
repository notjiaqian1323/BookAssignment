<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminHeader.ascx.cs" Inherits="BookAssignment.Admin.WebUserControl1" %>

<div class="top">
    <div class="menu-icon" onclick="openSidebar()">
        <span class="material-icons">menu</span>
    </div>
    <div class="top-left">
        <span class="material-icons">search</span>
    </div>
    <div class="top-right">
        <span class="material-icons">account_circle</span>
        <button class="log-out-admin"><a href="../SelectRole.aspx">Log Out</a></button>
    </div>
</div>

<aside id="sidebar">
    <div class="sidebar-title">
        <div class="sidebar-brand">
            Bookstore
        </div>
        <span class="material-icons" onclick="closeSidebar()">close</span>
    </div>

    <ul class="sidebar-list">
        <li class="sidebar-list-item">
            <span class="material-icons">dashboard</span> <a href="Dashboard.aspx">Dashboard</a>
        </li>
        <li class="sidebar-list-item">
            <span class="material-icons">inventory_2</span> <a href="Customers.aspx">Customers</a>
        </li>
        <li class="sidebar-list-item">
            <span class="material-icons">group</span> <a href="Products.aspx">Products</a>
        </li>
        <li class="sidebar-list-item">
            <span class="material-icons">poll</span> <a href="Reports.aspx">Reports</a>
        </li>                    
    </ul>
</aside>
