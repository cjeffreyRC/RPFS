<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Vote.aspx.cs" Inherits="RPFS_AllstarTracker.Vote" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    VOTE PAGE<br />

    <div id="LeftPage" style="width:49%;float:left;" runat="server" ondragover="return true">

    </div>
    <div style="width:50%;float:left;position:fixed;left:50%;border:thick; border-color:aliceblue">
        <p style="float:left;width:100%" ondragover="allowDrop(event)" ondrop="drop(event)">Drop player here to add to list</p>
    <div id="MidPage" class="container" style="width:3%;float:left" runat="server" ondragover="return true">
        <div style="height:20px"><div class="col-xs-12">12</div></div>
        <div style="height:20px"><div class="col-xs-12">11</div></div>
        <div style="height:20px"><div class="col-xs-12">10</div></div>
        <div style="height:20px"><div class="col-xs-12">9</div></div>
        <div style="height:20px"><div class="col-xs-12">8</div></div>
        <div style="height:20px"><div class="col-xs-12">7</div></div>
        <div style="height:20px"><div class="col-xs-12">6</div></div>
        <div style="height:20px"><div class="col-xs-12">5</div></div>
        <div style="height:20px"><div class="col-xs-12">4</div></div>
        <div style="height:20px"><div class="col-xs-12">3</div></div>
        <div style="height:20px"><div class="col-xs-12">2</div></div>
        <div style="height:20px"><div class="col-xs-12">1</div></div>

    </div>
    
    <div id="RightPage" class="container" style="width:47%;float:left;" runat="server">
        
    </div>
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
    btnUp.setAttribute("name", "btnUp");
    btnUp.setAttribute("value", "Up");
    btnUp.setAttribute("style", "height:13px; box-sizing: content-box; padding: 0;");
    btnUp.setAttribute("onclick","moveUp(this)")
    colUp.appendChild(btnUp);


    var colDown = document.createElement("div");
    colDown.setAttribute("class", "col-xs-1");
    colDown.setAttribute("ondrop", "return true");
    colDown.setAttribute("ondragover", "return true");
    var btnDown = document.createElement("input");
    btnDown.setAttribute("type", "button");
    btnDown.setAttribute("id", "btnDown");
    btnDown.setAttribute("name", "btnDown");
    btnDown.setAttribute("value", "Down");
    btnDown.setAttribute("style", "height:13px; box-sizing: content-box; padding: 0;");
    btnDown.setAttribute("onclick", "moveDown(this)");
    colDown.appendChild(btnDown);

    row.appendChild(colUp);
    row.appendChild(colDown);


    $(<%= RightPage.ClientID%>).append(row);
}


function moveUp(btn) {
    alert(btn.id);
    
        $row = $(btn).parent().parent().clone();
        $aboveRow = $(btn).parent().parent().prev().clone();

        $(btn).parent().parent().prev().replaceWith($row);
        $(btn).parent().parent().replaceWith($aboveRow);        
    }
function moveDown(btn) {
    alert(btn.id);
    
        $row = $(btn).parent().parent().clone();
        $belowRow = $(btn).parent().parent().next().clone();

        $(btn).parent().parent().next().replaceWith($row);
        $(btn).parent().parent().replaceWith($belowRow);       
    }
</script>
</asp:Content>

