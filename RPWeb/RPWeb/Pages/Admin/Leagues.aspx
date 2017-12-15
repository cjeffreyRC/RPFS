<%@ Page Title="" Language="C#" MasterPageFile="~/RPWeb.Master" AutoEventWireup="true" CodeBehind="Leagues.aspx.cs" Inherits="RPWeb.Pages.Admin.Leagues" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="text-align: center">Leagues</h3>
    <asp:GridView ID="gvLeagues" runat="server" DataKeyNames="ID" OnRowCommand="gvLeagues_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkTeams" runat="server" CommandName="viewLeagueTeams" CommandArgument='<%# Eval("ID") %>'>View teams</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <input type="button" id="btnOpenModal" value="New League" />

    <div id="backdrop" style="position: absolute; top: 0; height: 100%; width: 100%; background-color: rgba(0,0,0,0.80); display: none;" runat="server">
        <div id="updateContainer" style="background-color: white; border-radius: 8px; max-width: 30%; margin: auto; position: absolute; left: 0; right: 0; top: 25%; width: 40%;min-width:300px;">
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
            <table style="margin:auto">
                <tr>
                    <td>Sport:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSport" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Type:
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rblType" runat="server">
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>Draft Date:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Title:
                    </td>
                    <td>
                        <div hidden="hidden">
                            <input id="titleDate" type="hidden" />
                            <input id="titleSport" type="hidden" />
                            <input id="titleType" type="hidden" />
                        </div>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="titleReview"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Roster (CSV):
                    </td>
                    <td>
                        <asp:FileUpload ID="fupRoster" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Select Users:
                    </td>
                    <td>
                        <asp:CheckBoxList ID="cblLeagueUsers" runat="server"></asp:CheckBoxList>
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
                jQuery('#<%= backdrop.ClientID%>').hide();
            })

            jQuery('#btnOpenModal').click(function () {
                jQuery('#<%= backdrop.ClientID%>').show();
            })

            jQuery('#<%= ddlSport.ClientID%>').change(function () {
                jQuery('#titleSport').val(jQuery('#<%= ddlSport.ClientID%> :checked').text());
                jQuery('#titleSport').trigger('change');
                
            })

            jQuery('#<%= txtDate.ClientID%>').on('blur', function () {
                jQuery('#titleDate').val(jQuery('#<%= txtDate.ClientID%>').val().split('-')[0]);
                jQuery('#titleDate').trigger('change');
            })

            jQuery('#<%= rblType.ClientID%> tr td input').change(function () {
                jQuery('#titleType').val(jQuery('#<%= rblType.ClientID%> tr td input:checked').next().html());
                jQuery('#titleType').trigger('change');
            })

            jQuery('#titleType, #titleDate, #titleSport').change(function () {
                jQuery('#<%= txtTitle.ClientID%>').val(jQuery('#titleDate').val() + " " + jQuery('#titleSport').val() + " " + jQuery('#titleType').val());
                console.log("Changing");
            })
        })
    </script>
    <style>
        .titleReview {
            width:100%;
        }
    </style>
</asp:Content>
