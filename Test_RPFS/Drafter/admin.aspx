<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="Drafter.admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="cc1" %>
    <br />
    <asp:Button ID="btnRooms" runat="server" Text="Rooms" OnClick="btnRooms_Click" />
    <br />

    <asp:Panel ID="pnlRooms" runat="server" Visible="false">
        <asp:GridView ID="gvRooms" runat="server" DataKeyNames="roomId" OnRowCommand="gvRooms_RowCommand">
            <Columns>
                <asp:ButtonField ButtonType="Button" Text="Edit" CommandName="ed" />
            </Columns>
        </asp:GridView><br />
        <asp:Button ID="btnNewRoom" runat="server" Text="New Room" OnClick="btnNewRoom_Click" />
        <asp:Panel ID="pnlNewRoom" runat="server" Visible="false">
            <asp:HiddenField ID="hfRoomId" runat="server" />
            <table>
                <tr>
                    <td>
                        Type:
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rblTypes" runat="server"></asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Sport:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSports" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Start Time:
                    </td>
                    <td>
                        <cc1:TimeSelector ID="tsTime" runat="server" ></cc1:TimeSelector>
                    </td>
                </tr>
                <tr>
                    <td>
                        Start Date:
                    </td>
                    <td id="rowDate" runat="server">
                        <asp:TextBox ID="txtDate" runat="server" ReadOnly="true"></asp:TextBox><asp:Image ID="imgCal" runat="server" ImageUrl="C:\Users\Chris\Pictures\iconCal.png" />
                    </td>
                </tr>
            </table>
            <div id="divCal" style="display:none" runat="server">
                <asp:Calendar ID="calDate" runat="server" OnSelectionChanged="calDate_SelectionChanged"></asp:Calendar>
            </div>
            <h5>Users to Include</h5>
            <asp:CheckBoxList ID="cblLeagueUsers" runat="server"></asp:CheckBoxList>
            <asp:Button ID="btnSaveRoom" Text="Save" runat="server" OnClick="btnSaveRoom_Click" />
            <asp:Button ID="BtnCancelRoom" Text="Cancel" runat="server" OnClick="BtnCancelRoom_Click" />
        </asp:Panel>
    </asp:Panel>
    <asp:Panel ID="pnlUsers" runat="server" Visible="false">
        <asp:GridView ID="gvUsers" runat="server"></asp:GridView>
    </asp:Panel>
    <asp:Panel ID="pnlTeams" runat="server" Visible="false">
        <asp:GridView ID="gvTeams" runat="server"></asp:GridView>
    </asp:Panel>



    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= rowDate.ClientID%>').click(function () {
                $('#<%= divCal.ClientID%>').slideToggle();
            })
        })
    </script>
</asp:Content>
