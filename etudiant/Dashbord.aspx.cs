using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace gestiontaches.etudiant
{
    public partial class Dashbord : System.Web.UI.Page
    {
        private int maxuser = 50;
        private int maxtache = 100;
        basedonner b = new basedonner();
        protected List<UserModel> Users { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            LoadTaskComplet();
            LoadTaskData();
            LoadAssignedTaskData();
            LoadUserData();

            Users = GetUsersFromDatabase();
            // Mettre à jour l'affichage des données
            if (!IsPostBack)
            {
                BindGridView();
                chart();
            }
        }

        private int GetNombreUtilisateursFromDatabase()
        {
            int nombreUtilisateurs = 0;
            string connectionString = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT COUNT(*) FROM Utilisateur";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    nombreUtilisateurs = (int)command.ExecuteScalar();
                }
            }

            return nombreUtilisateurs;
        }

        // Méthode pour récupérer le nombre de tâches depuis la base de données
        private int GetNombreTachesFromDatabase()
        {
            int nombreTaches = 0;
            string connectionString = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT COUNT(*) FROM Taskee";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    nombreTaches = (int)command.ExecuteScalar();
                }
            }

            return nombreTaches;
        }

        // Méthode pour récupérer le nombre de tâches terminées depuis la base de données
        private int GetNombreTachesTerminesFromDatabase()
        {
            int nombreTachesTermines = 0;
            string connectionString = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT COUNT(*) FROM Taskee WHERE Status LIKE 'T%'";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    nombreTachesTermines = (int)command.ExecuteScalar();
                }
            }

            return nombreTachesTermines;
        }

        // Méthode pour récupérer le nombre de tâches en cours depuis la base de données
        private int GetNombreTachesEnCoursFromDatabase()
        {
            int nombreTachesEnCours = 0;
            string connectionString = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "SELECT COUNT(*) FROM Taskee WHERE Status = 'En cours'";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    nombreTachesEnCours = (int)command.ExecuteScalar();
                }
            }

            return nombreTachesEnCours;
        }
        private void chart()
        {
            // Récupération des données depuis la base de données
            int nombreUtilisateurs = GetNombreUtilisateursFromDatabase();
            int nombreTaches = GetNombreTachesFromDatabase();
            int nombreTachesTermines = GetNombreTachesTerminesFromDatabase();
            int nombreTachesEnCours = GetNombreTachesEnCoursFromDatabase();

            // Calcul des pourcentages et mise à jour des contrôles d'interface utilisateur
            double pourcentageUtilisateurs = (double)nombreUtilisateurs / maxuser * 100;
            double pourcentageTaches = (double)nombreTaches / maxtache * 100;
            double pourcentageTachesComplet = (double)nombreTachesTermines / nombreTaches * 100;
            double pourcentageTachesEnCours = (double)nombreTachesEnCours / nombreTaches * 100;

            lblPourcentageUtilisateur.Text = pourcentageUtilisateurs.ToString("0") + "%";
            lblPourcentageTaches.Text = pourcentageTaches.ToString("0") + "%";
            lblPourcentageTachesComplet.Text = pourcentageTachesComplet.ToString("0") + "%";
            lblPourcentageTachesEnCours.Text = pourcentageTachesEnCours.ToString("0") + "%";

            progressBarUtilisateur.Style["width"] = pourcentageUtilisateurs.ToString("0") + "%";
            progressBarTaches.Style["width"] = pourcentageTaches.ToString("0") + "%";
            progressBarTachesComplet.Style["width"] = pourcentageTachesComplet.ToString("0") + "%";
            progressBarTachesEnCours.Style["width"] = pourcentageTachesEnCours.ToString("0") + "%";
        }
        protected string GetCircleColor(object dataItem)
        {
            // Récupérer la catégorie de l'élément de données
            string category = DataBinder.Eval(dataItem, "Category").ToString();

            // Déterminer la couleur en fonction de la catégorie
            switch (category)
            {
                case "Utilisateurs":
                    return "#007bff"; // Bleu
                case "Tâches":
                    return "#28a745"; // Vert
                case "Tâches affectées":
                    return "#ffc107"; // Jaune
                default:
                    return "#000000"; // Noir par défaut
            }
        }

        private void BindGridView()
        {
            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour sélectionner les utilisateurs sans inclure la colonne de mot de passe
            string query = "SELECT * FROM Taskee ORDER BY CASE Priority WHEN 'Haute' THEN 1 WHEN 'Normale' THEN 2 ELSE 3 END";

            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(strConn))
            {
                // Utilisation de SqlDataAdapter pour récupérer les données de la base de données
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    // Création d'un DataTable pour stocker les données récupérées
                    DataTable dataTable = new DataTable();

                    // Remplissage du DataTable avec les données récupérées
                    adapter.Fill(dataTable);

                    // Liaison du DataTable à la GridView pour afficher les données
                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }
        protected List<UserModel> GetUsersFromDatabase()
        {
            List<UserModel> users = new List<UserModel>();

            // Chaîne de connexion à votre base de données à partir du fichier Web.config
            string connectionString = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            // Requête SQL pour sélectionner les utilisateurs depuis la table Utilisateur
            string query = "SELECT Nom, Prenom, Email, Sexe, Photo FROM Utilisateur";

            // Utilisation de SqlConnection pour se connecter à la base de données
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Utilisation de SqlCommand pour exécuter la requête SQL
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        // Ouverture de la connexion
                        connection.Open();

                        // Utilisation de SqlDataReader pour lire les données de la base de données
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            // Lecture des données et ajout à la liste des utilisateurs
                            while (reader.Read())
                            {
                                UserModel user = new UserModel();
                                user.Nom = reader["Nom"].ToString();
                                user.Prenom = reader["Prenom"].ToString();
                                user.Email = reader["Email"].ToString();
                                user.Sexe = reader["Sexe"].ToString();
                                user.Photo = (byte[])reader["Photo"]; // Récupération des données de l'image
                                users.Add(user);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Gestion des exceptions
                        // Vous pouvez gérer les erreurs de connexion ici
                        Console.WriteLine("Erreur : " + ex.Message);
                    }
                }
            }

            return users;
        }



        // Modèle pour représenter un utilisateur
        public class UserModel
        {
            public string Nom { get; set; }
            public string Prenom { get; set; }
            public string Email { get; set; }
            public string Sexe { get; set; }
            public byte[] Photo { get; set; } // Champ pour stocker les données de l'image
        }


        private void LoadUserData()
        {
            string query = "SELECT COUNT(*) FROM Utilisateur";
            SqlCommand command = b.nombase(query);

            int nombreUtilisateurs = (int)command.ExecuteScalar();
            lblNombreUtilisateurs.Text = nombreUtilisateurs.ToString();
        }

        private void LoadTaskData()
        {
            // Requête SQL pour compter le nombre d'utilisateurs
            string query = "SELECT COUNT(*) FROM Taskee";
            SqlCommand command = b.nombase(query);

            int nombreUtilisateurs = (int)command.ExecuteScalar();
            lblNombreTaches.Text = nombreUtilisateurs.ToString();
        }
        private void LoadTaskComplet()
        {
            // Requête SQL pour compter le nombre d'utilisateurs
            string query = "SELECT COUNT(*) FROM Taskee WHERE Status LIKE 'T%'";
            SqlCommand command = b.nombase(query);

            int nombreUtilisateurs = (int)command.ExecuteScalar();
            lblNombreTachesComplet.Text = nombreUtilisateurs.ToString();
        }

        private void LoadAssignedTaskData()
        {
            string query = "SELECT COUNT(*) FROM TaskAssignment";
            SqlCommand command = b.nombase(query);

            int nombreUtilisateurs = (int)command.ExecuteScalar();
            lblNombreTachesAffectees.Text = nombreUtilisateurs.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachement;filename=taches.doc");
            Response.ContentType = "application/vnd.ms-word";
            using (StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(stringWriter);
                GridView1.AllowPaging = false;
                this.BindGridView();
                GridView1.HeaderRow.BackColor = Color.White;
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                    }
                }
                GridView1.RenderControl(hw);
                Response.Output.Write(stringWriter.ToString());
                Response.Flush();
                Response.End();
            }
        }
        public override void VerifyRenderingInServerForm(Control control)
        {

        }


        public class CircleModel
        {
            public string Category { get; set; }
            public double Percentage { get; set; }
        }



    }
}