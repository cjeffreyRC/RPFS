<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="Drafter.admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="cc1" %>
    <br />
    <asp:Button ID="btnRooms" runat="server" Text="Rooms" OnClick="btnRooms_Click" />
    <br />

    <asp:Panel ID="pnlRooms" runat="server" Visible="false">
        <asp:GridView ID="gvRooms" runat="server"></asp:GridView><br />
        <asp:Button ID="btnNewRoom" runat="server" Text="New Room" OnClick="btnNewRoom_Click" />
        <asp:Panel ID="pnlNewRoom" runat="server" Visible="false">
            <table>
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
            </table>
            <h5>Users to Include</h5>
            <asp:CheckBoxList ID="cblRoomUsers" runat="server"></asp:CheckBoxList>
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
</asp:Content>
