<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="inscrire.aspx.cs" Inherits="gestiontaches.inscrire" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Utilisateur</title>
    <!-- Inclusion du fichier CSS de Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <style>
        /* Style pour le formulaire d'inscription */
        .container {
            max-width: 400px;
            margin: auto;
        }

        .form-group {
            margin-bottom: 10px; /* Réduction de l'espace entre les groupes de formulaire */
        }

        .form-control {
            width: 100%;
            padding: 8px; /* Réduction de la taille du padding */
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
            border: 1px solid #007bff;
            color: #fff;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: 1px solid #6c757d;
            color: #fff;
        }

        .btn-block {
            display: block;
            width: 100%;
        }

        /* Centrage du titre */
        .text-center {
            text-align: center;
        }

        /* Ajout de styles personnalisés */

        /* Style pour les étiquettes */
        label {
            font-weight: bold;
        }

        /* Style pour les champs de saisie en erreur */
        .form-control.error {
            border-color: #dc3545; /* Rouge pour indiquer une erreur */
        }

        /* Style pour les messages d'erreur */
        .error-message {
            color: #dc3545;
            font-size: 14px;
        }

        /* Style pour le bouton de soumission */
        .btn-primary {
            background-color: #28a745; /* Vert pour un bouton de soumission */
            border-color: #28a745;
        }

        /* Style pour le bouton "Retour" */
        .btn-secondary {
            background-color: #6c757d; /* Gris foncé pour le bouton "Retour" */
            border-color: #6c757d;
        }

        /* Style pour le titre du formulaire */
        .form-title {
            color: #333; /* Couleur de texte plus foncée pour le titre */
            font-size: 24px;
            margin-bottom: 20px; /* Réduction de l'espace sous le titre */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h2 class="text-center form-title">Formulaire d'inscription</h2>
            <div class="form-group">
                <label for="nom">Nom</label>
                <asp:TextBox ID="nom" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="prenom">Prénom</label>
                <asp:TextBox ID="prenom" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="email">Adresse email</label>
                <asp:TextBox ID="email" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexEmail" runat="server" ErrorMessage="Entrez une adresse email valide." ControlToValidate="email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <label for="phone">Téléphone</label>
                <asp:TextBox ID="phone" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexPhone" runat="server" ErrorMessage="Entrez un numéro de téléphone valide." ControlToValidate="phone" ValidationExpression="^(\d{10})?$"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <label for="sexe">Sexe</label>
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Femme" Value="female"></asp:ListItem>
                    <asp:ListItem Text="Homme" Value="male"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="password">Mot de passe</label>
                <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirmer le mot de passe</label>
                <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                <asp:CompareValidator ID="comparePassword" runat="server" ControlToValidate="confirmPassword" ControlToCompare="password" ErrorMessage="Les mots de passe ne correspondent pas."></asp:CompareValidator>
            </div>
            
            <div class="form-group">
                <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary btn-block" OnClick="btnSubmit_Click"></asp:Button>
            </div>
            <div class="form-group">
                <asp:Button ID="Button2" runat="server" Text="Retour" CssClass="btn btn-secondary btn-block" OnClick="btnretour_Click" />
            </div>
        </div>
    </form>
</body>
</html>
