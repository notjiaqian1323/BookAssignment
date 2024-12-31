<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="OnlineBookstore.Feedback" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Feedback</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <link rel="stylesheet" href="Feedback.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="feedback-container">
            <h1>Feedback Form</h1>
            <asp:Label ID="lblMessage" runat="server" CssClass="thank-you-message" />
            <label for="txtName">Name:</label>
            <asp:TextBox ID="txtName" runat="server" placeholder="Enter your name" />

            <label for="txtEmail">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email" />

            <label for="txtFeedback">Feedback:</label>
            <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" placeholder="Write your feedback here" />

            <label>Rate Us:</label>
            <div class="rating">
                <asp:RadioButton ID="star1" runat="server" GroupName="Rating" value="1" />
                <label for="star1">★</label>
                <asp:RadioButton ID="star2" runat="server" GroupName="Rating" value="2" />
                <label for="star2">★</label>
                <asp:RadioButton ID="star3" runat="server" GroupName="Rating" value="3" />
                <label for="star3">★</label>
                <asp:RadioButton ID="star4" runat="server" GroupName="Rating" value="4" />
                <label for="star4">★</label>
                <asp:RadioButton ID="star5" runat="server" GroupName="Rating" value="5" />
                <label for="star5">★</label>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="submit-btn" OnClick="btnSubmit_Click" />
        </div>
    </form>
</body>
</html>