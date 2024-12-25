<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Flipper.aspx.cs" Inherits="BookAssignment.WebForm8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Flip.css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <div class="flipbook">
            <div class="hard">Comedy Book 1 <small>~ HankTheTank</small></div>
            <div class="hard"></div>
            <div>
                <small>Lets look at some Amazing Pokemon</small>
                <small>Gotta catch'em all</small>
            </div>
            <div>
                <small>Charmander</small>
            </div>
            <div>
                <small>Charmander</small>
            </div>
            <div>
                <small>Charmander</small>
            </div>
            <div>
                <small>Charmander</small>
            </div>
            <div>
                <small>Charmander</small>
            </div>
            <div class="hard"></div>
            <div class="hard">Thank you <small>~ HankTheTank</small></div>
        </div>
    </form>
    <script src="jquery.js"></script>
    <script src="turn.js"></script>
    <script>
        $(".flipbook").turn();
    </script>
</body>
</html>
