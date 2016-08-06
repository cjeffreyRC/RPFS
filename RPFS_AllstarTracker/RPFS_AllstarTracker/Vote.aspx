<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Vote.aspx.cs" Inherits="RPFS_AllstarTracker.Vote" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    VOTE PAGE<br />

    <div id="LeftPage" style="width:49%;float:left" runat="server" ondragover="return true">

    </div>
    <p style="width:49%;float:left" ondragover="allowDrop(event)" ondrop="drop(event)">Drop player here to add to list</p>
    <div id="RightPage" class="container" style="width:49%;float:left" runat="server">
        
    </div>
    <script>
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
    var columnToSplit = row.lastChild;
    columnToSplit.removeAttribute("class");
    columnToSplit.setAttribute("class", "col-xs-1");

    var colUp = document.createElement("div");    
    colUp.setAttribute("class", "col-xs-1");
    colUp.setAttribute("ondrop", "return true");
    colUp.setAttribute("ondragover", "return true");
    var btnUp = document.createElement("input");
    btnUp.setAttribute("type", "button");
    btnUp.setAttribute("id", "btnUp");
    btnUp.setAttribute("value", "/\\");
    btnUp.onclick = function () {

    };
    colUp.appendChild(btnUp);


    var colDown = document.createElement("div");
    colDown.setAttribute("class", "col-xs-1");
    colDown.setAttribute("ondrop", "return true");
    colDown.setAttribute("ondragover", "return true");
    var btnDown = document.createElement("input");
    btnDown.setAttribute("type", "button");
    btnDown.setAttribute("id", "btnDown");
    btnDown.setAttribute("value", "\\/");
    btnDown.onclick = function () {

    };
    colDown.appendChild(btnDown);


    row.appendChild(colUp);
    row.appendChild(colDown);


    $(".container").append(row);
}

function moveUp() {
    
}
</script>
</asp:Content>

