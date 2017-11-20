<%@ Page Title="" Language="C#" MasterPageFile="~/RPWeb.Master" AutoEventWireup="true" CodeBehind="Teams.aspx.cs" Inherits="RPWeb.Pages.Admin.Teams" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlLeft" runat="server" CssClass="left">
        <asp:GridView ID="gvTeam" runat="server" DataKeyNames="ID">

        </asp:GridView>

    </asp:Panel>
    <asp:Panel ID="pnlRight" runat="server" CssClass="right">
        <asp:GridView ID="gvFreeAgents" runat="server" DataKeyNames="ID">

        </asp:GridView>
    </asp:Panel>



    <style>
        .left, .right {
            width:48%;
        }
        .left {
            float:left;
        }
        .right {
            float:right;
        }
    </style>
</asp:Content>
