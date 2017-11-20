<%@ Page Title="" Language="C#" MasterPageFile="~/RPWeb.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RPWeb.Pages.Account.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="max-width:75%;margin:auto;display:block;">
        <h3 style="text-align:center">Log in</h3>
        <table style="margin:auto;border:2px solid gainsboro;padding:8px;width:28%">
            <tr>
                <td>
                    Email address:
                </td>
                <td>
                    <asp:TextBox ID="email" runat="server" style="border-radius:7px;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Password:
                </td>
                <td>
                    <asp:TextBox ID="password" runat="server" TextMode="Password" style="border-radius:7px;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="submit" runat="server" OnClick="submit_Click" Text="Log in" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
