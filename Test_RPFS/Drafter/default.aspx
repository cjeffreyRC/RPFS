<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Drafter._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h3>Login</h3><br />
            <table>
                <tr>
                    <td>
                        Username:
                    </td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server" required="required" placeholder="Username"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Password:
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" required="required" placeholder="Password"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Button ID="btnLogin" runat="server" Text="Login" />
</asp:Content>
