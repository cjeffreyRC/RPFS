<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="rooms.aspx.cs" Inherits="Drafter.rooms" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:DataList ID="dlRooms" DataKeyField="roomId" runat="server" OnItemCommand="dlRooms_ItemCommand" ItemStyle-BorderStyle="Dotted" >
        <ItemTemplate>
            <h4><%# Eval("sportName")%> <%# Eval("leagueType")%></h4>
            <%# Eval("startDateTime")%><br />
            <asp:Button ID="btnJoin" runat="server" Text="Join" CommandArgument='<%# Eval("roomId") %>' CommandName="join" OnCommand="btnJoin_Command" />
        </ItemTemplate>
    </asp:DataList>
</asp:Content>
