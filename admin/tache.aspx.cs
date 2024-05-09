using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace gestiontaches
{
    public partial class tache : System.Web.UI.Page
    {
        private int rowind;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }


        }

        protected void btnAjouterTache_Click(object sender, EventArgs e)
        {
            string nomTacheValue = nomTache.Text;
            string descriptionTacheValue = descriptionTache.Text;
            DateTime dateDebutValue;
            DateTime dateFinValue;

            if (!DateTime.TryParse(dateDebut.Text, out dateDebutValue) || !DateTime.TryParse(dateFin.Text, out dateFinValue))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Veuillez saisir des dates valides.')", true);
                return;
            }

            if (dateFinValue <= dateDebutValue)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('La date de fin doit être postérieure à la date de début.')", true);
                return;
            }

            string priorityValue = priority.SelectedValue;

            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            string query = "INSERT INTO Taskee (Title, Description, Priority, Status, DateDebut, DateFin) VALUES (@nomTache, @descriptionTache, @priority, 'en cours', @dateDebut, @dateFin)";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                try
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@nomTache", nomTacheValue);
                        command.Parameters.AddWithValue("@descriptionTache", descriptionTacheValue);
                        command.Parameters.AddWithValue("@priority", priorityValue);
                        command.Parameters.AddWithValue("@dateDebut", dateDebutValue);
                        command.Parameters.AddWithValue("@dateFin", dateFinValue);

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Tâche ajoutée avec succès !')", true);

                            nomTache.Text = "";
                            descriptionTache.Text = "";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "ClearFields", "ClearFields();", true);
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Erreur lors de l\\'ajout de la tâche.')", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", $"alert('Erreur : {ex.Message}')", true);
                }
            }
            BindGridView();
        }

        private void BindGridView()
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";

            string query = "SELECT * FROM Taskee ORDER BY CASE Priority WHEN 'Haute' THEN 1 WHEN 'Normale' THEN 2 ELSE 3 END";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    DataTable dataTable = new DataTable();

                    adapter.Fill(dataTable);

                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }


        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            CheckBox cb = (CheckBox)GridView1.Rows[rowIndex].FindControl("chk");
            if (cb.Checked)
            {
                nomTache.Text = GridView1.Rows[rowIndex].Cells[2].Text;
                descriptionTache.Text = GridView1.Rows[rowIndex].Cells[3].Text;
                priority.SelectedValue = GridView1.Rows[rowIndex].Cells[4].Text;
                dateDebut.Text = GridView1.Rows[rowIndex].Cells[6].Text;
                dateFin.Text = GridView1.Rows[rowIndex].Cells[7].Text;
            }
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = GridView1.Rows[e.RowIndex].Cells[1].Text;

            try
            {
                string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
                string query = "DELETE FROM Taskee WHERE TaskID = @id";

                using (SqlConnection connection = new SqlConnection(strConn))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('La tâche a été supprimée avec succès.');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('La tâche n'a pas été trouvée ou n'a pas pu être supprimée.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Une erreur s'est produite lors de la suppression de la tâche : " + ex.Message + "');</script>");
            }

            BindGridView(); // Réactualiser le GridView après la suppression



        }

        protected void chk_CheckedChanged(object sender, EventArgs e)
        {
            int rowIndex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            CheckBox cb = (CheckBox)GridView1.Rows[rowIndex].FindControl("chk");
            if (cb.Checked)
            {
                id.Text = GridView1.Rows[rowIndex].Cells[2].Text;

                nomTache.Text = GridView1.Rows[rowIndex].Cells[3].Text;
                descriptionTache.Text = GridView1.Rows[rowIndex].Cells[4].Text;
                priority.SelectedValue = GridView1.Rows[rowIndex].Cells[5].Text;

                // Récupérer les valeurs des dates de début et de fin
                string dateDebutValue = GridView1.Rows[rowIndex].Cells[7].Text;
                string dateFinValue = GridView1.Rows[rowIndex].Cells[8].Text;

                // Formater les dates pour afficher uniquement la partie date sans l'heure
                DateTime dateDebutFormatted = DateTime.Parse(dateDebutValue);
                DateTime dateFinFormatted = DateTime.Parse(dateFinValue);

                string dateDebutText = dateDebutFormatted.ToString("dd/MM/yyyy");
                string dateFinText = dateFinFormatted.ToString("dd/MM/yyyy");

                // Assigner les valeurs des dates formatées aux champs de texte correspondants
                dateDebut.Text = dateDebutText;
                dateFin.Text = dateFinText;

                // Assigner également les valeurs aux champs d'entrée <input>
                dateDebute.Text = dateDebutText;
                dateFine.Text = dateFinText;
            }
            else
            {
                id.Text = "";
                nomTache.Text = "";
                descriptionTache.Text = "";
                priority.SelectedValue = "";
                dateDebute.Text = "";
                dateFine.Text = "";

            }
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            string nb = id.Text;


            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "DELETE FROM Taskee WHERE TaskID=@nbb";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@nbb", nb);


                    try
                    {
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Tâche supprimée avec succès !')", true);
                            id.Text = "";
                            nomTache.Text = "";
                            descriptionTache.Text = "";
                            priority.SelectedValue = "";
                            dateDebute.Text = "";
                            dateFine.Text = "";
                            BindGridView(); // Rafraîchir la GridView après la suppression
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Aucune tâche n'a été supprimée.')", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", $"alert('Erreur lors de la suppression de la tâche : {ex.Message}')", true);
                    }
                }
            }
        }





        public override void VerifyRenderingInServerForm(Control control)
        {
            base.VerifyRenderingInServerForm(control);
        }

        protected void btnGenerateWord_Click(object sender, EventArgs e)
        {

        }
        
    }

}


