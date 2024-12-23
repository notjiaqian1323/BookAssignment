<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reader.aspx.cs" Inherits="BookAssignment.WebForm7" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Reader.css" />
</head>
<body>
    <form id="form1" runat="server">
            <button id="prev-btn">
                <img src="Images/arrow-back.png"/>
            </button>

            <div id="book" class="book">
                <!-- Paper 1 -->
                <div id="p1" class="paper">
                    <div class="front">
                        <div id="f1" class="front-content">
                            <h1>Front 1</h1>
                        </div>
                    </div>
                    <div class="back">
                        <div id="b1" class="back-content">
                            <h1>Back 1</h1>
                        </div>
                    </div>
                </div>
                <div id="p2" class="paper">
                    <div class="front">
                        <div id="f2" class="front-content">
                            <h1>Front 2</h1>
                        </div>
                    </div>
                    <div class="back">
                        <div id="b2" class="back-content">
                            <h1>Back 2</h1>
                        </div>
                    </div>
                </div>
                <div id="p3" class="paper">
                    <div class="front">
                        <div id="f3" class="front-content">
                            <h1>Front 3</h1>
                        </div>
                    </div>
                    <div class="back">
                        <div id="b3" class="back-content">
                            <h1>Back 3</h1>
                        </div>
                    </div>
                </div>
            </div>

            <button id="next-btn">
                <img src="Images/arrow-next.png"/>
            </button>
    </form>
    <script defer src="Reader.js"></script>
</body>
</html>
