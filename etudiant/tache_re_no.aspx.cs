using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace gestiontaches.etudiant
{
    public partial class tache_re_no : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["NomUtilisateur"] != null)
                {
                    string nomUtilisateur = Request.QueryString["NomUtilisateur"];
                    BindGridView(nomUtilisateur);
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            if (Session["NomUtilisateur"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
        }
        private void BindGridView(string nomUtilisateur)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = @"
        SELECT TA.*, T.Status, T.Priority
        FROM TaskAssignment TA
        JOIN Taskee T ON TA.TaskID = T.TaskID
        WHERE TA.UserName = @NomUtilisateur AND T.Status = 'en fait par ' + @NomUtilisateur
        ORDER BY CASE T.Priority WHEN 'Haute' THEN 1 WHEN 'Normale' THEN 2 ELSE 3 END";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    adapter.SelectCommand.Parameters.AddWithValue("@NomUtilisateur", nomUtilisateur);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    GridView1.DataSource = dataTable;
                    GridView1.DataBind();
                }
            }
        }


        protected void chk_CheckedChanged(object sender, EventArgs e)
        {
            // Récupérer la ligne parente du contrôle CheckBox
            GridViewRow row = (GridViewRow)((CheckBox)sender).NamingContainer;
            string nomUtilisateur = Request.QueryString["NomUtilisateur"];
            // Récupérer l'index de la ligne
            int rowIndex = row.RowIndex;

            // Récupérer les contrôles CheckBox dans la ligne sélectionnée
            CheckBox cbe = (CheckBox)row.FindControl("chke");
            CheckBox cbee = (CheckBox)row.FindControl("chk");

            // Vérifier si la case à cocher cbe est cochée
            if (cbe.Checked)
            {
                // Récupérer l'identifiant de l'affectation de tâche
                int taskAssignmentId;
                if (int.TryParse(GridView1.Rows[rowIndex].Cells[2].Text, out taskAssignmentId))
                {
                    // Mettre à jour l'affectation de tâche correspondante
                    UpdateTaskAssignment(taskAssignmentId, "terminée par " + nomUtilisateur);
                }
            }
            else
            {
                if (cbee.Checked)
                {
                    int taskId;
                    if (int.TryParse(GridView1.Rows[rowIndex].Cells[2].Text, out taskId))
                    {
                        // Mettre à jour l'affectation de tâche correspondante
                        UpdateTask(taskId, "en cours");
                    }

                }
            }

            // Recharger les données dans le GridView
            BindGridView(nomUtilisateur);
        }
        private void UpdateTask(int taskId, string status)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "UPDATE Taskee SET Status = @Status WHERE TaskId = @TaskId AND Status LIKE 'en fait par%'";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@TaskId", taskId);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        private void UpdateTaskAssignment(int taskId, string status)
        {
            string strConn = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            string query = "UPDATE Taskee SET Status = @Status WHERE TaskId = @TaskId AND Status LIKE 'en fait par%'";

            using (SqlConnection connection = new SqlConnection(strConn))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Status", status);
                    command.Parameters.AddWithValue("@TaskId", taskId);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }



    }
}