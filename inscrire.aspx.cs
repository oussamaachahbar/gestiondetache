using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace gestiontaches
{
    public partial class inscrire : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnretour_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Récupérer les valeurs saisies dans les champs
            string nomValue = nom.Text;
            string prenomValue = prenom.Text;
            string emailValue = email.Text;
            string phoneValue = phone.Text;
            string passwordValue = password.Text; // Nouveau champ pour le mot de passe
            string confirmPasswordValue = confirmPassword.Text;
            string sexe = DropDownList1.SelectedValue;

            // Vérification des données non vides
            if (string.IsNullOrEmpty(nomValue) || string.IsNullOrEmpty(prenomValue) ||
                string.IsNullOrEmpty(emailValue) || string.IsNullOrEmpty(phoneValue))
               
            {
                Response.Write("<script>alert('Veuillez remplir tous les champs.');</script>");
                return;
            }
            if (passwordValue != confirmPasswordValue)
            {
                Response.Write("Les mots de passe ne correspondent pas.");
                return;
            }
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour insérer les données dans la table Utilisateurs
            string query = "INSERT INTO Utilisateur (Nom, Prenom, Email, Telephone, Role, Password,Sexe) " +
                           "VALUES (@nom, @prenom, @email, @phone, 'etudiant', @password,@sexe)";

            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(strConn))
            {
                try
                {
                    // Ouverture de la connexion
                    connection.Open();

                    // Utilisation de SqlCommand pour exécuter la requête SQL
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Ajout des paramètres à la commande SQL
                        command.Parameters.AddWithValue("@nom", nomValue);
                        command.Parameters.AddWithValue("@prenom", prenomValue);
                        command.Parameters.AddWithValue("@email", emailValue);
                        command.Parameters.AddWithValue("@phone", phoneValue);
                        
                        command.Parameters.AddWithValue("@password", passwordValue);
                        command.Parameters.AddWithValue("@sexe", sexe);

                        // Exécution de la commande SQL
                        int rowsAffected = command.ExecuteNonQuery();

                        // Vérification si l'insertion a réussi
                        if (rowsAffected > 0)
                        {
                            // Afficher un message ou rediriger l'utilisateur vers une autre page si nécessaire
                            Response.Write("<script>alert('Données insérées avec succès !.');</script>");
                            nom.Text = "";
                            prenom.Text = "";
                            email.Text = "";
                            phone.Text = "";
                            password.Text = "";
                            confirmPassword.Text = "";

                        }
                        else
                        {
                            // Afficher un message d'erreur si l'insertion a échoué
                            Response.Write("Erreur lors de l'insertion des données.");

                        }
                    }
                }
                catch (Exception ex)
                {
                    // Gestion des exceptions
                    Response.Write($"Erreur : {ex.Message}");
                }
            }
        }
    }
}