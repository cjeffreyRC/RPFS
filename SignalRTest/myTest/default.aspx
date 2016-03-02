<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="myTest._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignalR Echo</title>
    <script type="text/javascript" src="Scripts/jquery-2.0.3.min.js"></script>   
    <script type="text/javascript" src="Scripts/jquery.signalR-1.1.3.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <script type="text/javascript">
        function htmlEncode(value) {
            return $("<div/>").text(value).html();
        }
        
        function addMsg(msg) {
            $("#messages").append("<li>" + htmlEncode(msg) + "</li>");
        }
        $(function () {
            $("#join").click(function () {
                var connection = $.connection("/echo", "name=" + $("#name").val(), true);;
                
                connection.received(function (data) {
                    addMsg(data);
                });
                connection.error(function (err) {
                    addMsg("Error: " + err);
                });
            
                addMsg("Connecting...");
                connection.start(function () {
                    addMsg("Connected.");
                    $("#send").click(function () {
                        connection.send($("#msg").val());
                    });
                });
            });
        });
    </script>
    <table>
        <tr>
            <td><span>Name:</span></td>
            <td><input type="text" id="name" /></td>
            <td><input type="button" value="Join" id="join" /></td>
        </tr>
        <tr>
            <td><span>Message:</span></td>
            <td><input type="text" id="msg" /></td>
            <td><input type="button" value="Send" id="send" /></td>
        </tr>
    </table>
    <ul id="messages"></ul>
    </div>
    </form>
</body>
</html>
