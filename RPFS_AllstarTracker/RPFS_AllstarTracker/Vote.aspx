<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Vote.aspx.cs" Inherits="RPFS_AllstarTracker.Vote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    VOTE PAGE<br />
    Drag players to the drop zone.<br />
    Use the up/down buttons to sort the position.<br />
    Must be 12 players selected to submit your vote.<br />
    <hr style="width:48%" />
    <div id="LeftPage" style="width: 48%; float: left; white-space: nowrap; text-overflow: ellipsis" runat="server" ondragover="return true">
    </div>
    <div style="width: 50%; float: left; position: fixed; right: 5%; top: 5%; white-space: nowrap; text-overflow: ellipsis;" runat="server">
        <p style="width: 100%" ondragover="allowDrop(event)" ondrop="drop(event)"><b><u>Drop player here to add to list</u></b></p>

        <div id="RightPage" runat="server" name="RightPage" class="container subVal" style="float: left; width: 96%; border: solid; border-color: black; border-right-color: white; border-left-color: white">
        </div>
        <br />
        <input id="btnSubmit" type="button" value="Vote!" onclick="submitValues()" />
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
                if ($(<%= RightPage.ClientID%>).contents().length == 13)
                {
                    $('#btnSubmit').prop('disabled', false);
                }
                else
                {
                    $('#btnSubmit').prop('disabled', true);
                }
            }
            else
            {
                //Max number of rows reached
                alert("Maximum of 12 players already selected.");
                $('#btnSubmit').prop('disabled', false);
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
            for (var i = 12; i > 0 ; i--)
            {
                //alert($(".subVal").contents()[x + 1].id.split("_").pop());
                playerArray[x] = [];
                playerArray[x][0] = $(".subVal").contents()[x + 1].id.split("_").pop();
                playerArray[x][1] = i;
                x++;
            }

            $.ajax('SubmitVote.ashx', {
                data: { players:playerArray },
                success: function (response) { alert(response) },
                error: function (error) { alert(error.responseText) }
            })
        }

        
    </script>
</asp:Content>

