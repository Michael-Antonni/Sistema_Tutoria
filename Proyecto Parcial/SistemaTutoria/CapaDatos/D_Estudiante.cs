using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
using CapaEntidades;
using System.Data;

namespace CapaDatos
{
    public class D_Estudiante
    {
        SqlConnection conexion = new SqlConnection(ConfigurationManager.ConnectionStrings["conectar"].ConnectionString);
      
        public DataTable ListStudents()
        {
            DataTable table = new DataTable();
            SqlDataReader readRows;
            SqlCommand cmd = new SqlCommand("ListarEstudiante", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            readRows = cmd.ExecuteReader();
            table.Load(readRows);

            readRows.Close();
            conexion.Close();

            return table;
        }
        public DataTable SearchStudents(E_Estudiante estudiante)
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand("BuscarEstudiante", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@BUSCAR", estudiante.Search);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(tabla);

            conexion.Close();
            return tabla;
        }

        public void DeleteStudent(string CodEstudiante)
        {
            SqlCommand cmd = new SqlCommand("EliminarEstudiante", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@CodEstudiante", CodEstudiante);

            cmd.ExecuteNonQuery();
            conexion.Close();
        }

        public void CreateStudent(E_Estudiante estudiante)
        {

            SqlCommand cmd = new SqlCommand("CrearEstudiante", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();
            
            cmd.Parameters.AddWithValue("@Nombres", estudiante.Nombres);
            cmd.Parameters.AddWithValue("@APaterno", estudiante.ApellidosP);
            cmd.Parameters.AddWithValue("@AMaterno", estudiante.ApellidosM);
            cmd.Parameters.AddWithValue("@Situacion", estudiante.Situacion);
            cmd.Parameters.AddWithValue("@CodTutor", estudiante.CodTutor);
            cmd.Parameters.AddWithValue("@CodEscuela", estudiante.CodEscuela);

            cmd.ExecuteNonQuery();
            conexion.Close();
        }

        public void UpdateStudent(E_Estudiante estudiante)
        {
            SqlCommand cmd = new SqlCommand("ActualizarEstudiante", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@CodEstudiante", estudiante.CodEstudiante);
            cmd.Parameters.AddWithValue("@Nombres", estudiante.Nombres);
            cmd.Parameters.AddWithValue("@APaterno", estudiante.ApellidosP);
            cmd.Parameters.AddWithValue("@AMaterno", estudiante.ApellidosM);
            cmd.Parameters.AddWithValue("@Situacion", estudiante.Situacion);
            cmd.Parameters.AddWithValue("@CodTutor", estudiante.CodTutor);
            cmd.Parameters.AddWithValue("@CodEscuela", estudiante.CodEscuela);
            cmd.ExecuteNonQuery();
            conexion.Close();
        }

    }
}
