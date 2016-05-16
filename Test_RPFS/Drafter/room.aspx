﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="room.aspx.cs" Inherits="Drafter.room" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <!--Reference the jQuery library. -->
    <script src="Scripts/jquery-2.2.1.min.js"></script>
    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>
    <script src="Scripts/jquery-ui-1.11.4.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />


        <div id="tbContainer" class="container" runat="server">

        </div>

    <script type="text/javascript">
        $(function () {
            // Declare a proxy to reference the hub.
            var rHub = $.connection.roomHub;
            // Create functions that the hub can call to broadcast messages.
            rHub.client.newUserInRoom = function (username) {
                alert(username + " has joined the room.");
            }

                //Start connection
                $.connection.hub.start().done(function () {
                    rHub.server.joinRoom(1);
                })
            })
    </script>
    </div>
    </form>
</body>
</html>
