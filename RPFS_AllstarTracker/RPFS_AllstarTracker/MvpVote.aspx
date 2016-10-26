<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MvpVote.aspx.cs" Inherits="RPFS_AllstarTracker.MvpVote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="LeftPage" style="width: 48%; float: left; white-space: nowrap; text-overflow: ellipsis" runat="server" ondragover="return true">
    </div>
    <div style="width: 50%; float: left; position: fixed; right: 5%; top: 5%; white-space: nowrap; text-overflow: ellipsis;" runat="server">
        <img src="Pics/NBA2K16_Logo.png" style="width: 200px;" /><img src="Pics/RPFS2.jpeg" style="width: 200px;" />
        <p style="font-size: 3vw; width: 100%; height: 300px; border: dotted; border-color: darksalmon" ondragover="allowDrop(event)" ondrop="drop(event)"><b><u>Drop player here to add to list</u></b></p>
        
        <div id="RightPage" runat="server" class="container subVal" style="float: left; width: 96%; border: solid; border-color: black; border-right-color: white; border-left-color: white; background-color:black">
            <!--Trying to add headers -->   
        <div id="colHeaders" class="row">
             <div class="col-xs-3"><b><u>Name</u></b></div>
             <div class="col-xs-3"><b><u>Team</u></b></div>
             <div class="col-xs-2"><b><u>Draft Pick</u></b></div>
             <div class="col-xs-1"><b><u>POG Count</u></b></div>
             <div class="col-xs-1" style="margin-left:5px;"><b><u>Vote</u></b></div>
        </div>
        </div>
        <br />
        <input id="btnSubmit" type="button" value="Vote!" style="float: right; height: 100px; width: 90%; font-size: 2.5vw;" onclick="submitValues()" />
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

            var table = $(<%= RightPage.ClientID%>);
            var div = document.createElement("div");
            div.setAttribute("style", "padding-left:20px;");
            div.setAttribute("class", "col-xs-1");
            div.setAttribute("ondrop", "return true");
            div.setAttribute("ondragover", "return true");

            var val = table.contents().contents().last().prev().prev().html();
            console.log("Value of val is: " + val + "; Html inside of Right page: " + table.contents().children().length);
            if (val != 1)
            {
                var columnToSplit = row.lastChild;
                columnToSplit.removeAttribute("class");
                columnToSplit.setAttribute("class", "col-xs-1");
                //columnToSplit.setAttribute("style", "color:blue;font-weight: bold;font-size:larger;background-color:green;");
                columnToSplit.previousSibling.removeAttribute("class");
                columnToSplit.previousSibling.setAttribute("class", "col-xs-2");
            }

            if (table.contents().children().length == 5)
            {
                //No rows exist yet
                div.innerText = "3";
            }
            else
            {
                //Decrements previous point value by one and sets new number as new row point value
                div.innerText = (parseInt(val) - 1);
            }
            
            if (val != "1") {
                

                var colUp = document.createElement("div");
                colUp.setAttribute("class", "col-xs-1");
                colUp.setAttribute("ondrop", "return true");
                colUp.setAttribute("ondragover", "return true");
                var btnUp = document.createElement("input");
                btnUp.setAttribute("type", "button");
                btnUp.setAttribute("id", "btnUp");
                btnUp.setAttribute("name", "btnUp");
                btnUp.setAttribute("value", "Up");
                btnUp.setAttribute("style", "height:20px; box-sizing: content-box; padding: 0;color:black");
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
                btnDown.setAttribute("style", "height:20px; box-sizing: content-box; padding: 0;color:black");
                btnDown.setAttribute("onclick", "moveDown(this)");
                colDown.appendChild(btnDown);

                row.appendChild(div);
                row.appendChild(colUp);
                row.appendChild(colDown);
                
                $(<%= RightPage.ClientID%>).append(row);
                if ($(<%= RightPage.ClientID%>).contents().length == 4) {
                    $('#btnSubmit').removeProp('disabled');
                }
                else {
                    $('#btnSubmit').prop('disabled', true);
                }
            }
            else {
                //Max number of rows reached
                alert("Maximum of 3 players already selected. Refresh the page to start the vote over");
                $('#btnSubmit').removeProp('disabled');
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

        function submitValues() {
            var playerArray = [];
            var x = 0;
            for (var i = 3; i > 0 ; i--) {

                playerArray[x] = [];
                playerArray[x][0] = $(".subVal").contents()[x + 1].id.split("_").pop();
                playerArray[x][1] = i;
                x++;
            }

            $.ajax('/SubmitMvpVote.ashx', {
                data: { players: playerArray },
                success: function (response) {
                    alert("Vote Successful!");
                    document.forms[0].submit();
                },
                error: function (error) {
                    alert("Vote unsuccessful. " +error.responseText)
                }
            })
            
        }
    </script>
</asp:Content>
