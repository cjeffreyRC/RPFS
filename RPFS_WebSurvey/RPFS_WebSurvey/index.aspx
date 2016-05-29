<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="RPFS_WebSurvey.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color:burlywood">
    <form id="form1" runat="server" >
    <h1>RPFS Web Survey</h1>
    <p>
       Complete the following based on how important you feel each category is for version 1.0 of the drafter.
       Keep in mind the more necessary elements for version 1, the longer it will take for production.<br />
       If you prefer to be anonymous feel free to leave the name blank, (or put something funny). 
    </p>
    <div>
        <table>
            <tr>
                <td>
                    First Name:
                </td>
                <td>
                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="..."></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Last Name:
                </td>
                <td>
                    <asp:TextBox ID="txtLastName" runat="server" placeholder="..."></asp:TextBox>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" />
        <br />
        <h3>Trading Block</h3>
        <p>This section covers different elements of trading during the draft.</p>
        <table>
            <tr>
                <td>
                        Pick Trades                     
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtPickTrades" runat="server" TextMode="Range"></asp:TextBox>                    
                </td>
            </tr>
            <tr>
                <td>
                    Player Trades                    
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtPlayerTrades" runat="server" TextMode="Range"></asp:TextBox>                    
                </td>
            </tr>
            <tr>
                <td>
                    Player For Pick Trades
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtPlayerPickTrades" runat="server" TextMode="Range"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Multi-Team Trades
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtMultiTeamTrades" runat="server" TextMode="Range"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <h3>Pick Queue/Autodraft</h3>
        <p>
            This section covers how the pick queue will function. Drag n Drop allows for resorting the queue, without it you will have to delete all players in queue if you would like to swap plaers around<br />
            If queue is empty and draft timer runs out, select the method which you would prefer the autodraft to function. "Choice" means i will provide a default, and you will get to choose if you would <br />
            like to change it throughout the draft.
        </p>
        <table>
            <tr>
                <td>
                    <h4>Drag n Drop</h4>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtQDragNDrop" runat="server" TextMode="Range"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <h4>Autodraft Functionality</h4>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RadioButtonList ID="rblAutoDraft" runat="server">
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
        <br />
        <h3>Chat Feature</h3>
        <p>Would you like to have an embedded chat feature in the drafter for easy communication/shit talk with anybody drafting from online?<br />
           To access the chat there would be a button on the top of each page that opens and closes the chat box as needed. Private messages <br />
            will be supported, as well as the main chat.
        </p>
        <asp:RadioButtonList ID="rblChat" runat="server">
        </asp:RadioButtonList>
        <br />
        <p>Any other thoughts or suggestions please leave a detailed comment.</p>
        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" placeholder="Comments"></asp:TextBox>
        <br />
        <asp:Button ID="btnGo" runat="server" Text="Submit" OnClick="btnGo_Click" />
    </div>

    
    </form>
</body>
</html>
