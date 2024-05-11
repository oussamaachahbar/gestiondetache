<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rapport.aspx.cs" Inherits="gestiontaches.rapport" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion des tâches - Admin</title>
    <!-- Inclusion du fichier CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
<style>body{background-color:#f8f9fa;font-family:Arial,sans-serif}table{width:100%;border-collapse:collapse;border:2px solid #ddd}th{background-color:#f2f2f2;border:1px solid #ddd;padding:8px;text-align:left}td{border:1px solid #ddd;padding:8px}tr:nth-child(odd){background-color:#f9f9f9}.sidebar{background-color:black;color:#fff;position:fixed;height:100%;overflow-y:auto;z-index:1;padding-top:20px;width:250px;border-radius:10px}.container-main{margin-left:250px;padding:20px}.form-group label{font-weight:bold;margin-bottom:5px}.form-group input[type="text"],.form-group input[type="email"],.form-group input[type="password"]{width:100%;padding:10px;border:1px solid #ccc;border-radius:5px;box-sizing:border-box;margin-bottom:15px}.form-group input[readonly]{background-color:#f0f0f0}.btn{background-color:#007bff;color:#fff;border:none;padding:10px 20px;border-radius:5px;cursor:pointer}.btn:hover{background-color:#0056b3}.modal-body .form-group{margin-bottom:15px}.modal-header{background-color:#007bff;color:#fff;border-bottom:none}.modal-title{color:#fff}.modal-footer{border-top:none}.col-md-3.sidebar{overflow-y:auto}.modal-header .close{color:#fff}.nav-item{display:flex;align-items:center}.nav-icon{width:20px;height:auto;margin-right:10px}.nav-link{border-radius:5px;transition:background-color 0.3s}.nav-link:hover{background-color:#ffc107}</style>

</head>
<body>

    <div class="container-fluid">
        <div class="row">
                      <div class="col-md-3 sidebar">

    <nav class="navbar navbar-dark">
        <ul class="navbar-nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="admin.aspx">
                    <img src="/img/home.png" alt="Home Icon" class="nav-icon"/> <!-- Image pour Home -->
                    Home
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="utilisateur.aspx">
                    <img src="/img/utilisateuricon.png" alt="User Icon" class="nav-icon"/> <!-- Image pour Utilisateur -->
                    UTILISATEUR
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="tache.aspx">
                    <img src="/img/tacheicon.png" alt="Tasks Icon" class="nav-icon"/> <!-- Image pour Taches -->
                    TACHES
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="affectation_tache.aspx">
                    <img src="/img/afficon.png" alt="Assignment Icon" class="nav-icon"/> <!-- Image pour Affectation Tache -->
                    AFFECTATION TACHE
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="rapport.aspx">
                    <img src="/img/rapporticon.png" alt="Report Icon" class="nav-icon"/> <!-- Image pour Rapport -->
                    RAPPORT
                </a>
            </li>
            <li class="nav-item" style="margin-top:300px">
                <a class="nav-link" href="/Default.aspx">
                    <img src="/img/out.png" alt="Logout Icon" class="nav-icon"/> <!-- Image pour Déconnexion -->
                    Déconnexion
                </a>
            </li>
        </ul>
    </nav>
</div>
            <!-- Contenu principal -->
            <div class="col-md-9 container-main" style="zoom:110%">
                <!-- Le contenu principal ici -->
                <div class="container">
                        <form id="form1" runat="server">
        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="1028px">
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SortedAscendingCellStyle BackColor="#EDF6F6" />
            <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
            <SortedDescendingCellStyle BackColor="#D6DFDF" />
            <SortedDescendingHeaderStyle BackColor="#002876" />
        </asp:GridView>
        <div style="margin-top:20px;margin-bottom:20px">
            <asp:Button ID="Button1" runat="server" Text="Print Affectation Tache" CssClass="btn btn-danger" OnClick="Button1_Click" />
        </div>
        <asp:GridView ID="GridView2" runat="server" CellPadding="4" Width="1028px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px">
    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
    <RowStyle BackColor="White" ForeColor="#003399" />
    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    <SortedAscendingCellStyle BackColor="#EDF6F6" />
    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
    <SortedDescendingCellStyle BackColor="#D6DFDF" />
    <SortedDescendingHeaderStyle BackColor="#002876" />
</asp:GridView>
<div style="margin-top:20px;margin-bottom:20px">
    <asp:Button ID="Button2" runat="server" Text="Print Tache Terminer" CssClass="btn btn-danger" OnClick="Button2_Click" />
</div>
                <asp:GridView ID="GridView3" runat="server" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="1028px">
    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
    <RowStyle ForeColor="#003399" BackColor="White" />
    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    <SortedAscendingCellStyle BackColor="#EDF6F6" />
    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
    <SortedDescendingCellStyle BackColor="#D6DFDF" />
    <SortedDescendingHeaderStyle BackColor="#002876" />
</asp:GridView>
<div style="margin-top:20px;margin-bottom:20px">
    <asp:Button ID="Button3" runat="server" Text="Print Tache En Train De Faire" CssClass="btn btn-danger" OnClick="Button3_Click" />
</div>                <asp:GridView ID="GridView4" runat="server" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="1028px">
    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
    <RowStyle BackColor="White" ForeColor="#003399" />
    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    <SortedAscendingCellStyle BackColor="#EDF6F6" />
    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
    <SortedDescendingCellStyle BackColor="#D6DFDF" />
    <SortedDescendingHeaderStyle BackColor="#002876" />
</asp:GridView>
<div style="margin-top:20px">
    <asp:Button ID="Button4" runat="server" Text="Print Utilisateur" CssClass="btn btn-danger" OnClick="Button4_Click" />
</div>
    </form>
        </div>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
