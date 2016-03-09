﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Test._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignalR Simple Chat</title>
	<meta charset="utf-8" />
    <style type="text/css">
        .container {
            background-color: #99CCFF;
            border: thick solid #808080;
            padding: 20px;
            margin: 20px;
        }
    </style>
    <link href="Content/themes/base/all.css" rel="stylesheet" />
    <link href="Content/themes/base/dialog.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false">
    <div>
    <!--Script references. -->
    <!--Reference the jQuery library. -->
    <script src="Scripts/jquery-2.1.0.min.js"></script>
    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>

    <script src="Scripts/jquery-ui-1.11.4.min.js"></script>

    <!--Add script to update the page and send messages.-->
    <script type="text/javascript">
        $(function () {
            // Declare a proxy to reference the hub.
            var chat = $.connection.chatHub;

            chat.client.setUserId = function (Id) {
                $('#userId').val(Id);
            };
            // Create a function that the hub can call to broadcast messages.
            chat.client.broadcastMessage = function (name, message) {
                // Html encode display name and message.
                var encodedName = $('<div />').text(name).html();
                var encodedMsg = $('<div />').text(message).html();
                // Add the message to the page.
                $('#discussion').append('<li><strong>' + encodedName
                    + '</strong>:&nbsp;&nbsp;' + encodedMsg + '</li>');
            };
            // Get the user name and store it to prepend to messages.
            $('#getname').dialog({
                modal: true,
                beforeClose: function (event,ui) {
                        if ($('#displayname').val() == "" || ($('#displayname').val() == null))
                        {
                            return false;
                        }
                    }                
            });
            // Set initial focus to message input box.
            $('#message').focus();

            $('#message').keypress(function (e) {
                if (e.which == 13) {
                    $('#sendmessage').trigger('click');
                    return false;
                }
            });

            // Start the connection.
            $.connection.hub.start().done(function () {
                $('#savename').click(function () {
                    if ($('#displayname').val() != "" && ($('#displayname').val() != null))
                    {
                        chat.server.saveUser($('#displayname').val());
                        $('#lblerror').val("");
                        $('#getname').dialog("close");
                    }
                    else
                    {
                        $('#lblerror').text("Please input a name to continue");
                    }
                    
                });
                $('#sendmessage').click(function () {
                    // Call the Send method on the hub.
                    chat.server.send($('#userId').val(), $('#message').val());
                    // Clear text box and reset focus for next comment.
                    $('#message').val('').focus();
                });
            });
        });
    </script>
     <div class="container">
        <input type="text" id="message" />
        <input type="button" id="sendmessage" value="Send" />
        <div id="getname" title="Enter Name">
            <input type="text" id="displayname" placeholder="Enter Name" />
            <input type="button" id="savename" value="OK" /><br />
            <span id="lblerror" style="color:red"></span>
        </div>
        <input type="hidden" id="userId" />
        <ul id="discussion" runat="server">

        </ul>
    </div>
    
    </div>
    </form>
</body>
</html>
