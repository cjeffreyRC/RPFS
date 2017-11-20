<%@ Page Title="" Language="C#" MasterPageFile="~/RPWeb.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="RPWeb.Pages.Admin.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="gvUsers" runat="server">
    </asp:GridView>

    <input type="button" id="updateOpen" value="New User" />

    <div id="backdrop" style="position: absolute; top: 0; height: 100%; width: 100%; background-color: rgba(0,0,0,0.90); display: none;">
        <div id="updateContainer" style="background-color: white; border-radius: 8px; max-width: 40%; margin: auto; position: absolute; left: 0; right: 0; top: 25%; width: 40%;">
            <h3 style="text-align: center">Create Account</h3>
            <table style="margin: auto; border: 2px solid gainsboro; padding: 8px; width: 28%">
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
                    <td>Password:
                    </td>
                    <td>
                        <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="updateSubmit" runat="server" Text="Save" OnClick="updateSubmit_Click" />
                        <input type="button" id="updateCancel" value="Cancel" />
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script defer="defer">
        jQuery(window).load(function () {
            jQuery('#updateCancel').click(function () {
                jQuery('#backdrop').hide();
            })

            jQuery('#updateOpen').click(function () {
                jQuery('#backdrop').show();
            })
        })
    </script>
</asp:Content>
