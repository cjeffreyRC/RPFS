<%@ Page Title="" Language="C#" MasterPageFile="~/RPWeb.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="RPWeb.Pages.Account.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="text-align:center">Register for an account</h3>

    <table style="margin:auto;border:2px solid gainsboro;padding:8px;width:28%">
        <tr>
            <td>First Name:
            </td>
            <td>
                <asp:TextBox ID="fName" runat="server" placeholder="John"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Last Name:
            </td>
            <td>
                <asp:TextBox ID="lName" runat="server" placeholder="Smith"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Email Address
            </td>
            <td>
                <asp:TextBox ID="emailAddress" runat="server" placeholder="john.smith@domain.com"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Favorite Sport
            </td>
            <td>
                <asp:DropDownList ID="favoriteSport" runat="server">
                    <asp:ListItem Value="-1" Text="Select a sport..."></asp:ListItem>
                    <asp:ListItem Value="0" Text="Basketball"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Football"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Baseball"></asp:ListItem>
                    <asp:ListItem Value="3" Text="Soccer"></asp:ListItem>
                    <asp:ListItem Value="4" Text="Wrestling"></asp:ListItem>
                    <asp:ListItem Value="5" Text="Hockey"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Password:
            </td>
            <td>
                <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox> 
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>

    <div id="resultDisplay" visible="false" runat="server">
        <p id="result">
            Thanks
            <asp:Label ID="lblName" runat="server"></asp:Label>. Your account has been created with the following credentials:
        </p>
        <table>
            <tr>
                <td>Name:
                </td>
                <td>
                    <asp:Label ID="lblFullName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Email Address:
                </td>
                <td>
                    <asp:Label ID="lblEmailAddress" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
