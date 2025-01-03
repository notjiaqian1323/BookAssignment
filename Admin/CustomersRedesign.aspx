<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomersRedesign.aspx.cs" Inherits="BookAssignment.Admin.CustomersRedesign" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!--External CSS-->
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>
    <link rel="stylesheet" type="text/css" href="Reporting.css"/>
    <link rel="stylesheet" type="text/css" href="Customers.css"/>

    <!--Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />

    <!--Icons-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
    <title>Customers Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <Admin:Nav ID="admSide" runat="server" />

        <section class="home-section">
           <div class="home-content">
               <i class='bx bx-menu' ></i>
               <span class="text">Customers</span>
           </div>
            <div class="main-container">
                <div class="edit-users">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>

                    <asp:ListView ID="lvUsers" runat="server" DataKeyNames="Id" OnItemEditing="lvUsers_ItemEditing"
                        OnItemUpdating="lvUsers_ItemUpdating" OnItemDeleting="lvUsers_ItemDeleting" OnItemCanceling="lvUsers_ItemCanceling">
        
                        <LayoutTemplate>
                            <div class="user-list">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                            </div>
                        </LayoutTemplate>

                        <ItemTemplate>
                            <div class="user-item">
                                <div class="user-info">
                                    <span class="user-id"><%# Eval("Id") %></span>
                                    <span class="user-name"><%# Eval("Name") %></span>
                                    <span class="user-email"><%# Eval("Email") %></span>
                                    <span class="user-role"><%# Eval("Role") %></span>
                                    <button type="button" class="btn-details" onclick="viewCustomerDetails('<%# Eval("Id") %>')">View Details</button>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
       </section>

        <script>
            function viewCustomerDetails(userId) {
                window.location.href = `UserDetails.aspx?UserId=${userId}`;
            }
        </script>
        <script src="ProductRedesign.js"></script>
    </form>
</body>
</html>
