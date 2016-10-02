<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MvpVote.aspx.cs" Inherits="RPFS_AllstarTracker.MvpVote" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="LeftPage" style="width: 48%; float: left; white-space: nowrap; text-overflow: ellipsis" runat="server" ondragover="return true">
    </div>
    <div style="width: 50%; float: left; position: fixed; right: 5%; top: 5%; white-space: nowrap; text-overflow: ellipsis;" runat="server">
        <img src="Pics/NBA2K16_Logo.png" style="width:200px;" /><img src="Pics/RPFS2.jpeg" style="width:200px;" />
        <p style="font-size:3vw;width:100%;height:300px;border:dotted;border-color:darksalmon" ondragover="allowDrop(event)" ondrop="drop(event)"><b><u>Drop player here to add to list</u></b></p>

        <div id="RightPage" runat="server" class="container subVal" style="float: left; width: 96%; border: solid; border-color: black; border-right-color: white; border-left-color: white">
        </div>
        <br />
        <input id="btnSubmit" type="button" value="Vote!" style="float:right;height:100px;width:90%;font-size:2.5vw;" onclick="submitValues()" />
    </div>
    <script>
        $('#btnSubmit').prop('disabled', true);
        function allowDrop(ev) {
            ev.preventDefault();
        }

        function drag(ev) {
            ev.dataTransfer.setData("text", ev.target.id);
            return true;
        }

        function drop(ev) {
            ev.preventDefault();
            var data = ev.dataTransfer.getData("text");
            var row = document.getElementById(data);

            $(<%= RightPage.ClientID%>).append(row);
            if ($(<%= RightPage.ClientID%>).contents().length == 13) {
                $('#btnSubmit').prop('disabled', false);
            }
            else {
                $('#btnSubmit').prop('disabled', true);
            }
        }
    </script>
</asp:Content>
