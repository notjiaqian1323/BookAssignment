<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Flipper.aspx.cs" Inherits="BookAssignment.Flipper" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Flipper</title>
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <script type="text/javascript">
        // Function to change background color of the form
        function changeBackgroundColor() {
            var color = document.getElementById("colorPicker").value;
            document.getElementById("form1").style.backgroundColor = color;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="flipper-container">
            <!-- Color Picker and Button -->
<div class="color-picker">
    <label for="colorPicker">Choose Background Color: </label>
    <input type="color" id="colorPicker" value="#ffffff" onchange="changeBackgroundColor()" />
</div>

            <h2 id="bookTitle" runat="server"></h2>
            <div id="bookContent" class="content-area" runat="server"></div>
        </div>
    </form>
</body>
</html>
