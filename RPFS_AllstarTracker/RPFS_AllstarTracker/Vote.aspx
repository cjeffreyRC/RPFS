<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Vote.aspx.cs" Inherits="RPFS_AllstarTracker.Vote" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    VOTE PAGE<br />

    <div id="LeftPage" style="width:49%;float:left" runat="server">

    </div>
    <div id="RightPage" style="width:49%;float:left" ondragover="allowDrop(event)" runat="server">
        Drop player here to add to list
    </div>

    <script>
function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
}

function drop(ev) {
    ev.preventDefault();
    var data = ev.dataTransfer.getData("HtmlControls");
    ev.target.appendChild(document.getElementById(data));
}
</script>
</asp:Content>
