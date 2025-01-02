<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductsRedesign.aspx.cs" Inherits="BookAssignment.Admin.ProductsRedesign" %>
<%@ Register TagPrefix="Admin" TagName="Nav" Src="~/Admin/AdminNavigation.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="ProductsRedesign.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=search" />
    <!--Icons-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <Admin:Nav ID="admSide" runat="server" />

        <section class="home-section">
            <div class="home-content">
                <i class='bx bx-menu' ></i>
                <span class="text">Drop Down Sidebar</span>
            </div>
             <div class="main-container">
     <div class="main-title">
         <h2>PRODUCTS</h2>
     </div>
     <div class="data-container">

         <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

         <asp:ListView ID="lvBooks" runat="server" DataKeyNames="BookID" OnItemCanceling="lvBooks_ItemCanceling" OnItemDeleting="lvBooks_ItemDeleting" OnItemEditing="lvBooks_ItemEditing" OnItemUpdating="lvBooks_ItemUpdating">
             <ItemTemplate>
                 <div class="container">
                     <!-- Book Image -->
                     <div class="image-container">
                         <asp:Image ID="imgBook" runat="server" ImageUrl='<%# "~/" + Eval("ImageUrl") %>' CssClass="book-image" />
                     </div>

                     <!-- Book Details (Title and Price) -->
                     <div class="details">
                         <asp:Label ID="lblBookName" runat="server" Text='<%# Eval("Title") %>' CssClass="book-title"></asp:Label>
                         <asp:Label ID="lblBookDesc" runat="server" Text='<%# Eval("Description") %>' CssClass="book-desc"></asp:Label>
                         <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price", "{0:C}") %>' CssClass="book-price"></asp:Label>
                         <button type="button" class="btn-details" 
                             data-id='<%# Eval("BookId") %>' 
                             data-title='<%# Eval("Title") %>' 
                             data-description='<%# Eval("Description") %>' 
                             data-genre='<%# Eval("Genre") %>' 
                             data-price='<%# Eval("Price") %>' 
                             data-author='<%# Eval("Author") %>'
                             data-image='<%# Eval("ImageUrl") %>'>
                             View Details
                         </button>
                     </div>

                     <!-- Action Buttons -->
                     <div class="action-buttons">
                         <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="edit-button" />
                         <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="delete-button" />
                     </div>
                 </div>
             </ItemTemplate>

             <EditItemTemplate>
                 <div class="container">
                     <!-- Image Upload -->
                     <div class="image-container">
                         <asp:FileUpload ID="fuImagePath" runat="server" CssClass="file-upload" />
                         <asp:HiddenField ID="hfImagePath" runat="server" Value='<%# Bind("ImageUrl") %>' />
                     </div>

                     <!-- Book Details (Title and Price) -->
                     <div class="details">
                         <asp:TextBox ID="txtBookName" runat="server" Text='<%# Bind("Title") %>' CssClass="edit-textbox book-title-input"></asp:TextBox>
                         <asp:TextBox ID="txtBookDesc" runat="server" Text='<%# Bind("Description") %>' CssClass="edit-textbox book-desc-input"></asp:TextBox>
                         <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' CssClass="edit-textbox book-price-input"></asp:TextBox>
                     </div>

                     <!-- Action Buttons -->
                     <div class="action-buttons">
                         <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="update-button" />
                         <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="cancel-button" />
                     </div>
                 </div>
             </EditItemTemplate>

         </asp:ListView>
     </div>
 </div>
        </section>

    </form>
    <script src="ProductRedesign.js">

    </script>
</body>
</html>
