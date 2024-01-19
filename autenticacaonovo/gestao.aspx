<%@ Page Title="" Language="C#" MasterPageFile="~/masterpage.Master" AutoEventWireup="true" CodeBehind="gestao.aspx.cs" Inherits="autenticacaonovo.gestao" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GERIR UTILIZADORES</p>
<p>
    <asp:GridView ID="GridView1" runat="server" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Width="748px" AutoGenerateColumns="False" DataKeyNames="cod_utilizador" AllowPaging="True" AllowSorting="True" PageSize="4">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="cod_utilizador" HeaderText="cod_utilizador" InsertVisible="False" ReadOnly="True" SortExpression="cod_utilizador" />
            <asp:BoundField DataField="utilizador" HeaderText="utilizador" SortExpression="utilizador" />
            <asp:BoundField DataField="palavra_passe" HeaderText="palavra_passe" SortExpression="palavra_passe" />
            <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
            <asp:BoundField DataField="cod_estado" HeaderText="cod_estado" SortExpression="cod_estado" />
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/icons/close.png" CausesValidation="False" DeleteImageUrl="~/icons/delete.png" EditImageUrl="~/icons/edit.png" InsertImageUrl="~/icons/check-mark.png" ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:autenticnovoConnectionString2 %>" SelectCommand="SELECT * FROM [utilizadores]" DeleteCommand="DELETE FROM [utilizadores] WHERE [cod_utilizador] = @cod_utilizador" InsertCommand="INSERT INTO [utilizadores] ([utilizador], [palavra_passe], [email], [cod_estado]) VALUES (@utilizador, @palavra_passe, @email, @cod_estado)" UpdateCommand="UPDATE [utilizadores] SET [utilizador] = @utilizador, [palavra_passe] = @palavra_passe, [email] = @email, [cod_estado] = @cod_estado WHERE [cod_utilizador] = @cod_utilizador">
        <DeleteParameters>
            <asp:Parameter Name="cod_utilizador" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="utilizador" Type="String" />
            <asp:Parameter Name="palavra_passe" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="cod_estado" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="utilizador" Type="String" />
            <asp:Parameter Name="palavra_passe" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="cod_estado" Type="Int32" />
            <asp:Parameter Name="cod_utilizador" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>
