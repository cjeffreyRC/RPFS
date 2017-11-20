<%@ Page Title="" Language="C#" MasterPageFile="~/RPWeb.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="RPWeb.Pages.Admin.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="text-align:center">RPFS League Administration</h3>
    <ul>
        <li>
            <asp:LinkButton ID="lnkUsers" runat="server" Text="View Users" PostBackUrl="~/Pages/Admin/Users.aspx"></asp:LinkButton>
        </li>
        <li>
            <asp:LinkButton ID="lnkLeagues" runat="server" Text="View Leagues" PostBackUrl="~/Pages/Admin/Leagues.aspx"></asp:LinkButton>
        </li>
    </ul>
</asp:Content>
