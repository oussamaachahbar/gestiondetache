<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="gestiontaches.admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion des tâches - Admin</title>
    <!-- Inclusion du fichier CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
        <style>body{background-color:#f8f9fa;font-family:Arial,sans-serif}.sidebar{background-color:black;color:#fff;position:fixed;height:100%;overflow-y:auto;z-index:1;padding-top:20px;width:250px;border-radius:10px}.container-main{margin-left:250px;padding:20px}.modal-body .form-group{margin-bottom:15px}.modal-header{background-color:#007bff;color:#fff;border-bottom:none}.modal-title{color:#fff}.modal-footer{border-top:none}.modal-header .close{color:#fff}.box{background-color:#007bff;color:#ffffff;padding:20px;border-radius:10px;box-shadow:0 0 20px rgba(0,0,0,0.1);margin-bottom:20px}.card{margin-bottom:20px}.card img{width:100px;height:100px;border-radius:50%;margin-bottom:10px}.btn-danger{margin-bottom:0px}table{width:100%;border-collapse:collapse;border:2px solid #ddd}th{background-color:#f2f2f2;border:1px solid #ddd;padding:8px;text-align:left}td{border:1px solid #ddd;padding:8px}tr:nth-child(odd){background-color:#f9f9f9}.nav-link{border-radius:5px;transition:background-color 0.3s}.nav-link:hover{background-color:#ffc107}.nav-icon{width:20px;height:auto;margin-right:10px}</style>

</head>
<body>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
                                   <div class="col-md-3 sidebar">
    <nav class="navbar navbar-dark">
        <ul class="navbar-nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href='<%= "admin.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                    <img src="/img/home.png" alt="Home Icon" class="nav-icon"/> <!-- Image pour Home -->
                    Home
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%= "utilisateur.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                    <img src="/img/utilisateuricon.png" alt="User Icon" class="nav-icon"/> <!-- Image pour Utilisateur -->
                    UTILISATEUR
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%= "tache.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                    <img src="/img/tacheicon.png" alt="Tasks Icon" class="nav-icon"/> <!-- Image pour Taches -->
                    TACHES
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%= "affectation_tache.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                    <img src="/img/afficon.png" alt="Assignment Icon" class="nav-icon"/> <!-- Image pour Affectation Tache -->
                    AFFECTATION TACHE
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='<%= "rapport.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
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
            <div class="col-md-9 container-main">
                 <form id="form1" runat="server">
                <div class="row">
    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card bg-primary text-white shadow">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-uppercase mb-1">Utilisateurs</div>
                        <div class="h5 mb-0 font-weight-bold">
                            <asp:Label ID="lblNombreUtilisateurs" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-users fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card bg-success text-white shadow">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-uppercase mb-1">Tâches</div>
                        <div class="h5 mb-0 font-weight-bold">
                            <asp:Label ID="lblNombreTaches" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-tasks fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Earnings (Monthly) Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card bg-info text-white shadow">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-uppercase mb-1">Affectation Tâches</div>
                        <div class="h5 mb-0 font-weight-bold">
                            <asp:Label ID="lblNombreTachesAffectees" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clipboard-check fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending Requests Card Example -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card bg-warning text-white shadow">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-uppercase mb-1">Tâches Complétées</div>
                        <div class="h5 mb-0 font-weight-bold">
                            <asp:Label ID="lblNombreTachesComplet" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-check-circle fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

                
                    <div class="container">
                         <div class="row">
        <!-- Tableau des pourcentages à gauche -->
        <div class="col-md-8">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Projects</h6>
                </div>
                <div class="card-body">
                    <h4 class="small font-weight-bold">Utilisateur <span class="float-right"><asp:Label ID="lblPourcentageUtilisateur" runat="server" Text=""></asp:Label></span></h4>
                    <div class="progress mb-4">
                        <asp:Panel ID="progressBarUtilisateur" CssClass="progress-bar bg-danger" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" runat="server"></asp:Panel>
                    </div>
                    <h4 class="small font-weight-bold">Taches <span class="float-right"><asp:Label ID="lblPourcentageTaches" runat="server" Text=""></asp:Label></span></h4>
                    <div class="progress mb-4">
                        <asp:Panel ID="progressBarTaches" CssClass="progress-bar bg-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" runat="server"></asp:Panel>
                    </div>
                    <h4 class="small font-weight-bold">Taches Complet <span class="float-right"><asp:Label ID="lblPourcentageTachesComplet" runat="server" Text=""></asp:Label></span></h4>
                    <div class="progress mb-4">
                        <asp:Panel ID="progressBarTachesComplet" CssClass="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" runat="server"></asp:Panel>
                    </div>
                    <h4 class="small font-weight-bold">Taches En Cours <span class="float-right"><asp:Label ID="lblPourcentageTachesEnCours" runat="server" Text=""></asp:Label></span></h4>
                    <div class="progress mb-4">
                        <asp:Panel ID="progressBarTachesEnCours" CssClass="progress-bar bg-info" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" runat="server"></asp:Panel>
                    </div>
                </div>
            </div>
        </div>
        <!-- Description de l'application et image à droite -->
        <div class="col-md-4">
    <div class="card shadow mb-4">
        <div class="card-body">
            <div class="text-center">
                <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="/img/undraw_posting_photo.svg" alt="Illustration of a person managing tasks">
            </div>
            <p>La gestion des tâches est un processus visant à organiser, suivre et contrôler l'exécution des différentes activités d'un projet ou d'une entreprise. Elle implique la planification, l'attribution de ressources, le suivi de l'avancement et la coordination des tâches pour atteindre les objectifs fixés dans les délais impartis.</p>
        </div>
    </div>
</div>

    </div>
</div>



                    </div>
            <div style="margin-left:340px">
                    <asp:GridView  ID="GridView1" CssClass="custom-table" runat="server" BackColor="White" BorderColor="#3366CC" BorderStyle="None"  BorderWidth="1px" CellPadding="4" Width="1083px">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SortedAscendingCellStyle BackColor="#EDF6F6" />
                        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                        <SortedDescendingCellStyle BackColor="#D6DFDF" />
                        <SortedDescendingHeaderStyle BackColor="#002876" />
                    </asp:GridView></div>
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
                var id = $(this).find('td:eq(0)').text();
                var title = $(this).find('td:eq(1)').text();
                var desc = $(this).find('td:eq(2)').text();
                var priority = $(this).find('td:eq(3)').text();
                var statuse = $(this).find('td:eq(4)').text();
                var dated = $(this).find('td:eq(5)').text();
                var datef = $(this).find('td:eq(6)').text();
                var formattedDated = moment(dated, "DD/MM/YYYY").format("DD/MM/YYYY");
                var formattedDatef = moment(datef, "DD/MM/YYYY").format("DD/MM/YYYY");
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
