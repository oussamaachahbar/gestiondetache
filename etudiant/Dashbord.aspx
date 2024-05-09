<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashbord.aspx.cs" Inherits="gestiontaches.etudiant.Dashbord" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion des tâches - Admin</title>
    <!-- Inclusion du fichier CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .sidebar {
            background-color: #343a40;
            color: #ffffff;
            position: fixed;
            height: 100%;
            overflow-y: auto;
            z-index: 1;
            padding-top: 20px;
            width: 250px;
        }

        .container-main {
            margin-left: 250px; /* La même largeur que le sidebar */
            padding: 20px;
        }

        .box {
            background-color: #007bff;
            color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .card {
            margin-bottom: 20px;
        }

        .card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 10px;
        }

        .btn-danger {
            margin-bottom: 0px;
        }        /* Style pour la table */
table {
    width: 100%;
    border-collapse: collapse;
    border: 2px solid #ddd; /* Bordure de la table */
}

/* Style pour les cellules d'en-tête */
th {
    background-color: #f2f2f2; /* Couleur de fond */
    border: 1px solid #ddd; /* Bordure */
    padding: 8px; /* Espacement interne */
    text-align: left; /* Alignement du texte */
}

/* Style pour les cellules de données */
td {
    border: 1px solid #ddd; /* Bordure */
    padding: 8px; /* Espacement interne */
}

/* Style pour les lignes impaires */
tr:nth-child(odd) {
    background-color: #f9f9f9; /* Couleur de fond */
}
    </style>
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
                            <a class="nav-link" href='<%= "tache_re_no.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"></use></svg>
                                Tache En Fait
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href='<%= "etudiant.aspx?NomUtilisateur=" + Server.UrlEncode(Session["NomUtilisateur"].ToString()) %>'>
                                <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"></use></svg>
                                Tache Associer
                            </a>
                        </li>
                         <li class="nav-item" style="margin-top:300px">
     <a class="nav-link" href="/Default.aspx">
         <svg class="bi me-2" width="16" height="16"><use xlink:href="#power"></use></svg>
         Déconnexion
     </a>
 </li>
                    </ul>
                </nav>
            </div>
            <!-- Contenu principal -->
            <div class="col-md-9 container-main">
                <h1>Utilisateur - Admin</h1>
                <!-- Le contenu principal ici -->
                <div class="container">
                           <form id="form1" runat="server" class="container">
    <div class="container">
    <div class="row">
        <div class="col-md-4">
            <div class="box">
                <h3>Nombre d'utilisateurs</h3>
                <p>Nombre total : <asp:Label ID="lblNombreUtilisateurs" runat="server"></asp:Label></p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="box">
                <h3>Nombre de tâches</h3>
                <p>Nombre total : <asp:Label ID="lblNombreTaches" runat="server"></asp:Label></p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="box">
                <h3>Nombre de tâches affectées</h3>
                <p>Nombre total : <asp:Label ID="lblNombreTachesAffectees" runat="server"></asp:Label></p>
            </div>
        </div>
    </div>
</div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        
        </form>
        </div>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
            <!-- JavaScript de Bootstrap -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-xxxx" crossorigin="anonymous"></script>

</body>
</html>
