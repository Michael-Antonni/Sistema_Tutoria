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
    public class D_Docente
    {
        SqlConnection conexion = new SqlConnection(ConfigurationManager.ConnectionStrings["conectar"].ConnectionString);
        public DataTable ListDocente()
        {
            DataTable table = new DataTable();
            SqlDataReader readRows;
            SqlCommand cmd = new SqlCommand("ListarDocente", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            readRows = cmd.ExecuteReader();
            table.Load(readRows);

            readRows.Close();
            conexion.Close();

            return table;
        }
        public DataTable SearchDocente(E_Docente docente)
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand("BuscarDocente", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@BUSCAR", docente.Search);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(tabla);

            conexion.Close();
            return tabla;
        }

        public void DeleteDocente(int id)
        {
            SqlCommand cmd = new SqlCommand("EliminarDocente", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@IdDocente", id);

            cmd.ExecuteNonQuery();
            conexion.Close();
        }

        public void CreateDocente(E_Docente docente)
        {

            SqlCommand cmd = new SqlCommand("CrearDocente", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@APaterno", docente.ApellidosP);
            cmd.Parameters.AddWithValue("@AMaterno", docente.ApellidosM);
            cmd.Parameters.AddWithValue("@Nombres", docente.Nombres);
            cmd.Parameters.AddWithValue("@TituloAcademico", docente.TituloAcademico);
            cmd.Parameters.AddWithValue("@Categoria", docente.Categoria);
            cmd.Parameters.AddWithValue("@CodEscuela", docente.CodEscuela);

            cmd.ExecuteNonQuery();
            conexion.Close();
        }

        public void UpdateDocente(E_Docente docente)
        {
            SqlCommand cmd = new SqlCommand("ActualizarDocente", conexion);
            cmd.CommandType = CommandType.StoredProcedure;
            conexion.Open();

            cmd.Parameters.AddWithValue("@IdDocente", docente.IdDocente);
            cmd.Parameters.AddWithValue("@APaterno", docente.ApellidosP);
            cmd.Parameters.AddWithValue("@AMaterno", docente.ApellidosM);
            cmd.Parameters.AddWithValue("@Nombres", docente.Nombres);
            cmd.Parameters.AddWithValue("@TituloAcademico", docente.TituloAcademico);
            cmd.Parameters.AddWithValue("@Categoria", docente.Categoria);
            cmd.Parameters.AddWithValue("@CodEscuela", docente.CodEscuela);


            cmd.ExecuteNonQuery();
            conexion.Close();
        }
    }
}
