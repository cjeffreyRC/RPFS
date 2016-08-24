<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="RPFS_AllstarTracker.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Login</h3>
    <table>
        <tr>
            <td>
                Email:&nbsp
            </td>
            <td>
                <asp:TextBox id="txtEmail" runat="server" ForeColor="Black"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Password:&nbsp
            </td>
            <td>
                <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" ForeColor="Black"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnLogin" runat="server" Text="Log In" OnClick="btnLogin_Click" />
            </td>
        </tr>
    </table>
    <asp:Label ID="lblError" runat="server"></asp:Label>
</asp:Content>
