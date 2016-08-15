﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Vote.aspx.cs" Inherits="RPFS_AllstarTracker.Vote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    VOTE PAGE<br />

    <div id="LeftPage" style="width: 48%; float: left; white-space: nowrap; text-overflow: ellipsis" runat="server" ondragover="return true">
    </div>
    <div style="width: 50%; float: left; position: fixed; right: 5%; top: 5%; white-space: nowrap; text-overflow: ellipsis;" runat="server">
        <p style="width: 100%" ondragover="allowDrop(event)" ondrop="drop(event)"><b><u>Drop player here to add to list</u></b></p>

        <div id="RightPage" style="float: left; width: 96%; border: solid; border-color: black; border-right-color: white; border-left-color: white" runat="server">
        </div><br />
        <asp:Button ID="btnSubmit" runat="server" Text="Vote!" OnClick="btnSubmit_Click" /><asp:Label ID="lblMsg" runat="server" ></asp:Label>
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
            //row.setAttribute("runat", "server");
            var columnToSplit = row.lastChild;
            columnToSplit.removeAttribute("class");
            columnToSplit.setAttribute("class", "col-xs-1");

            var table = $(<%= RightPage.ClientID%>);
    var val = table.contents().contents().last().prev().prev().text();
    if (val != "1")
    {
        if (val == 0)
        {
            //No rows exist yet
            columnToSplit.innerText = "12";
        }
        else
        {
            //Decrements previous point value by one and sets new number as new row point value
            columnToSplit.innerText = (parseInt(val) - 1)
        }

        var colUp = document.createElement("div");    
        colUp.setAttribute("class", "col-xs-1");
        colUp.setAttribute("ondrop", "return true");
        colUp.setAttribute("ondragover", "return true");
        var btnUp = document.createElement("input");
        btnUp.setAttribute("type", "button");
        btnUp.setAttribute("id", "btnUp");
        btnUp.setAttribute("name", "btnUp");
        btnUp.setAttribute("value", "Up");
        btnUp.setAttribute("style", "height:20px; box-sizing: content-box; padding: 0;");
        //btnUp.setAttribute("style", "height:90%");
        btnUp.setAttribute("onclick", "moveUp(this)");
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
        btnDown.setAttribute("style", "height:20px; box-sizing: content-box; padding: 0;");
        //btnDown.setAttribute("style", "height:90%");
        btnDown.setAttribute("onclick", "moveDown(this)");
        colDown.appendChild(btnDown);

        row.appendChild(colUp);
        row.appendChild(colDown);


        $(<%= RightPage.ClientID%>).append(row);
}
    else
    {
        //Max number of rows reached
        alert("Maximum of 12 players already selected.")
    }
}


function moveUp(btn) { 
    var $row = $(btn).parent().parent().clone();
    var $aboveRow = $(btn).parent().parent().prev().clone();
    var $rowPoints = $(btn).parent().prev().clone();
    var $aboveRowPoints = $(btn).parent().parent().prev().contents().last().prev().prev().clone();

    $row.contents().last().prev().prev().replaceWith($aboveRowPoints);
    $aboveRow.contents().last().prev().prev().replaceWith($rowPoints);

    $(btn).parent().parent().prev().replaceWith($row);
    $(btn).parent().parent().replaceWith($aboveRow);

    //$(btn).parent().prev().val() = $(btn).parent().parent()
}
function moveDown(btn) {   
    var $row = $(btn).parent().parent().clone();
    var $belowRow = $(btn).parent().parent().next().clone();
    var $rowPoints = $(btn).parent().prev().prev().clone();
    var $belowRowPoints = $(btn).parent().parent().next().contents().last().prev().prev().clone();

    $row.contents().last().prev().prev().replaceWith($belowRowPoints);
    $belowRow.contents().last().prev().prev().replaceWith($rowPoints);

    $(btn).parent().parent().next().replaceWith($row);
    $(btn).parent().parent().replaceWith($belowRow);       
}

    </script>
</asp:Content>

