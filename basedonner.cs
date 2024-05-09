using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace gestiontaches
{
    public class basedonner
    {
        public basedonner() { }
        public SqlCommand nombase(string query)
        {
            string nom = "Data Source=TORNADO;Initial Catalog=master;Integrated Security=True";
            SqlConnection con = new SqlConnection(nom);
            SqlCommand command = new SqlCommand(query, con);
            con.Open();
            return command;



        }
    }
}