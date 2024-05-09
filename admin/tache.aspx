<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tache.aspx.cs" Inherits="gestiontaches.tache" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion des tâches - Admin</title>
    <!-- Inclusion du fichier CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
    <style>body{background-color:#f8f9fa;font-family:Arial,sans-serif;}/* Modal */
.modal-body .form-group {
    margin-bottom: 15px;
}.modal-header {
    background-color: #007bff;
    color: #fff;
    border-bottom: none;
}.modal-title {
    color: #fff;
}.modal-footer {
    border-top: none;
}.modal-header .close {
    color: #fff;
}.sidebar{background-color:#343a40;color:#fff;position:fixed;height:100%;overflow-y:auto;z-index:1;padding-top:20px;width:250px;}.container-main{margin-left:250px;padding:20px;}.box{background-color:#007bff;color:#fff;padding:20px;border-radius:10px;box-shadow:0 0 20px rgba(0,0,0,.1);margin-bottom:20px;}.card{margin-bottom:20px;}.card img{width:100px;height:100px;border-radius:50%;margin-bottom:10px;}table{width:100%;border-collapse:collapse;border:2px solid #ddd;}th{background-color:#f2f2f2;border:1px solid #ddd;padding:8px;text-align:left;}td{border:1px solid #ddd;padding:8px;}tr:nth-child(odd){background-color:#f9f9f9;}.btn-danger{margin-bottom:0;}.table{width:100%;border-collapse:collapse;border:2px solid #ddd;}.th{background-color:#f2f2f2;border:1px solid #ddd;padding:8px;text-align:left;}.td{border:1px solid #ddd;padding:8px;}.tr:nth-child(odd){background-color:#f9f9f9}</style>

</head>
<body>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 sidebar">
                <nav class="navbar navbar-dark">
                    <ul class="navbar-nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="admin.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#home"></use></svg>
                                Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="utilisateur.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"></use></svg>
                                UTILISATEUR
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="tache.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"></use></svg>
                                TACHES
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="affectation_tache.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#grid"></use></svg>
                                AFFECTATION TACHE
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="rapport.aspx">
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#people-circle"></use></svg>
                                RAPPORT
                            </a>
                        </li>                        <li class="nav-item" style="margin-top:300px">
    <a class="nav-link" href="/Default.aspx">
        <svg class="bi me-2" width="16" height="16"><use xlink:href="#power"></use></svg>
        Déconnexion
    </a>
</li>
                    </ul>
                </nav>
            </div>
            <div class="col-md-9 container-main">
                <h1>tâches - Admin</h1>
                <div class="container">
                        <form id="form1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                
                                                              <div class="form-group">
    <asp:Label ID="Label1" runat="server" Text="ID" AssociatedControlID="id"></asp:Label>
    <asp:TextBox ID="id" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
</div>
        <div class="form-group">
            <asp:Label ID="Label6" runat="server" Text="Nom de la tâche" AssociatedControlID="nomTache"></asp:Label>
            <asp:TextBox ID="nomTache" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label ID="Label7" runat="server" Text="Description de la tâche" AssociatedControlID="descriptionTache"></asp:Label>
            <asp:TextBox ID="descriptionTache" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label ID="Label8" runat="server" Text="Date de début"></asp:Label>
            <asp:TextBox ID="dateDebute" runat="server" CssClass="form-control"></asp:TextBox>
<asp:TextBox ID="dateDebut" runat="server" CssClass="form-control" type="date"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label ID="Label10" runat="server" Text="Date de fin"></asp:Label>
            <asp:TextBox ID="dateFine" runat="server" CssClass="form-control"></asp:TextBox>
<asp:TextBox ID="dateFin" runat="server" CssClass="form-control" type="date"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label ID="Label9" runat="server" Text="Priorité" AssociatedControlID="priority"></asp:Label>
            <asp:DropDownList ID="priority" runat="server" CssClass="form-control">
                <asp:ListItem Text="Haute" Value="Haute"></asp:ListItem>
                <asp:ListItem Text="Normale" Value="Normale"></asp:ListItem>
                <asp:ListItem Text="Basse" Value="Basse"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:Button ID="Button2" runat="server" Text="Ajouter une tâche" CssClass="btn btn-primary btn-submit" OnClick="btnAjouterTache_Click"></asp:Button>
      <asp:Button ID="Button1" runat="server" Text="Delete une tâche" CssClass="btn btn-danger btn-submit" OnClick="btndelete_Click"></asp:Button>
            </div>
                
            </div>
            <div class="col-md-6 grid-view" id="DivToPrint" runat="server">
                <asp:GridView ID="GridView1" CssClass="custom-table" runat="server" CellPadding="4" Width="893px" OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" Height="237px" AutoGenerateDeleteButton="True">
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
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
            </div>
        </div>
    </div>
                                                     <div class="modal fade" id="modal-id" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Informations de l'utilisateur</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    
                                        <div class="form-group">
    <label for="id">ID</label>
    <input type="text" class="form-control" id="id" readonly>
</div>
<div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control" id="title" readonly>
</div>
<div class="form-group">
    <label for="desc">Description</label>
    <input type="text" class="form-control" id="desc" readonly>
</div>
<div class="form-group">
    <label for="priority">Priority</label>
    <input type="text" class="form-control" id="priority" readonly>
</div>

<div class="form-group">
    <label for="status">Status</label>
    <input type="text" class="form-control" id="status" readonly>
</div>
   
<div class="form-group">
    <label for="dated">DateDebut</label>
    <input type="text" class="form-control" id="dated" readonly>
</div>
                                    <div class="form-group">
    <label for="datef">DateFin</label>
    <input type="text" class="form-control" id="datef" readonly>
</div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                                </div>
                            </div>
                        </div>
                    </div>
    </form>
        </div>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#GridView1 tbody').on('dblclick', 'tr', function () {
                
                var id = $(this).find('td:eq(1)').text(); 
                var title = $(this).find('td:eq(2)').text();
                var desc = $(this).find('td:eq(3)').text();
                var priority = $(this).find('td:eq(4)').text();
                var statuse = $(this).find('td:eq(5)').text();
                var dated = $(this).find('td:eq(6)').text(); 
                var datef = $(this).find('td:eq(7)').text(); 
                var formattedDated = moment(dated).format("DD/MM/YYYY");
                var formattedDatef = moment(datef).format("DD/MM/YYYY");
                $('#modal-id').find('#id').val(id);
                $('#modal-id').find('#title').val(title);
                $('#modal-id').find('#desc').val(desc);
                $('#modal-id').find('#priority').val(priority);
                $('#modal-id').find('#status').val(statuse);
                $('#modal-id').find('#dated').val(formattedDated);
                $('#modal-id').find('#datef').val(formattedDatef);
                $('#modal-id').modal('show');
            });
        });
    </script>


</body>
</html>
