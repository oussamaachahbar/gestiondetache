using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace gestiontaches.etudiant
{
    public partial class Dashbord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            LoadTaskData();
            LoadAssignedTaskData();
            LoadUserData
                ();
        }
        private void LoadUserData()
        {
            // Chaîne de connexion à la base de données
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour compter le nombre d'utilisateurs
            string query = "SELECT COUNT(*) FROM Utilisateur";

            using (SqlConnection con = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, con))
                {
                    con.Open();
                    int nombreUtilisateurs = (int)command.ExecuteScalar();
                    lblNombreUtilisateurs.Text = nombreUtilisateurs.ToString();
                }
            }
        }

        // Méthode pour charger le nombre de tâches
        private void LoadTaskData()
        {
            // Chaîne de connexion à la base de données
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour compter le nombre de tâches
            string query = "SELECT COUNT(*) FROM Taskee";

            using (SqlConnection con = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, con))
                {
                    con.Open();
                    int nombreTaches = (int)command.ExecuteScalar();
                    lblNombreTaches.Text = nombreTaches.ToString();
                }
            }
        }

        // Méthode pour charger le nombre de tâches affectées
        private void LoadAssignedTaskData()
        {
            // Chaîne de connexion à la base de données
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour compter le nombre de tâches affectées
            string query = "SELECT COUNT(*) FROM TaskAssignment";

            using (SqlConnection con = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, con))
                {
                    con.Open();
                    int nombreTachesAffectees = (int)command.ExecuteScalar();
                    lblNombreTachesAffectees.Text = nombreTachesAffectees.ToString();
                }
            }
        }


    }
}