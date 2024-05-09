using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace gestiontaches
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["NomUtilisateur"] = null;
        }
        protected void btnInscrire_Click(object sender, EventArgs e)
        {
            // Code à exécuter lors du clic sur le bouton "inscrire"
            // Par exemple, vous pouvez rediriger l'utilisateur vers la page d'inscription
            Response.Redirect("inscrire.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
           
            string user = txtUsername.Text;
            string pass = txtPassword.Text;

            // Chaîne de connexion à la base de données
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Création d'une connexion à la base de données
            using (SqlConnection con = new SqlConnection(strConn))
            {
                // Ouverture de la connexion
                con.Open();

                // Construction de la requête SQL avec des paramètres
                string query = "SELECT * FROM Utilisateur WHERE CONCAT(Nom, ' ', Prenom) = @Username AND Password = @Password AND Role = 'etudiant'";
                string querye = "SELECT * FROM Utilisateur WHERE CONCAT(Nom, ' ', Prenom) = @Username AND Password = @Password AND Role = 'admin'";

                // Création d'une commande SQL avec la requête et la connexion
                using (SqlCommand command = new SqlCommand(query, con))
                {
                    // Ajout des paramètres à la commande
                    command.Parameters.AddWithValue("@Username", user);
                    command.Parameters.AddWithValue("@Password", pass);

                    // Exécution de la commande SQL et lecture des résultats
                    // Exécution de la commande SQL et lecture des résultats
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        // Vérification si des données correspondent à l'authentification
                        if (reader.HasRows)
                        {
                            // Authentification réussie
                            // Stockage du nom d'utilisateur dans une variable de session
                            Session["NomUtilisateur"] = user;
                            lblMessage.Text = "Connexion réussie!";
                            Response.Redirect("etudiant/Dashbord.aspx?NomUtilisateur=" + user);

                        }
                        else
                        {
                            // Fermer le DataReader
                            reader.Close();

                            // Authentification échouée
                            using (SqlCommand commande = new SqlCommand(querye, con))
                            {
                                // Ajout des paramètres à la commande
                                commande.Parameters.AddWithValue("@Username", user);
                                commande.Parameters.AddWithValue("@Password", pass);

                                // Exécution de la commande SQL et lecture des résultats
                                using (SqlDataReader readere = commande.ExecuteReader())
                                {
                                    // Vérification si des données correspondent à l'authentification
                                    if (readere.HasRows)
                                    {
                                        // Authentification réussie
                                        Session["NomUtilisateur"] = user;
                                        lblMessage.Text = "Connexion réussie!";
                                        Response.Redirect("admin/admin.aspx?NomUtilisateur=" + user);
                                    }
                                    else
                                    {
                                        lblMessage.Text = "Nom d'utilisateur ou mot de passe incorrect.";
                                    }
                                }
                            }
                        }
                    }

                }
            }
        }
    }
}
