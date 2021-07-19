

using System;
using System.Data;
using System.Data.SqlClient;
using Modelo;

    public class Controlador
    {
        string aConexión = "";

        #region Constructor
        public Controlador(string pConexión)
        {
            aConexión = pConexión;
        }
        #endregion

        SqlConnection sqlCon = new SqlConnection(@aConexión);

        #region Métodos Get y Set
        public string GetConexión()
        {
            return aConexión;
        }
        public void SetConexión(string pConexión)
        {
            aConexión = pConexión;
        }
        #endregion

        #region Métodos de Clase
        public void Create(string pNombre_Proceso)
        {
            try
            {
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
                SqlCommand sqlCmd = new SqlCommand(pNombre_Proceso, sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                if (pNombre_Proceso == "Create_Estudiante")
                {
                    sqlCmd.Parameters.AddWithValue("@CodEstudiante", txtCodEstudiante);
                    sqlCmd.Parameters.AddWithValue("@APaterno", txtAPaterno);
                    sqlCmd.Parameters.AddWithValue("@AMaterno", txtAMaterno);
                    sqlCmd.Parameters.AddWithValue("@Nombre", txtNombre);
                    sqlCmd.Parameters.AddWithValue("@CodEscuelaP", txtCodEscuelaP);
                    sqlCmd.Parameters.AddWithValue("@Estado", txtEstado);
                    sqlCmd.ExecuteNonQuery();
                }
                if (pNombre_Proceso == "Create_Docente")
                {
                    sqlCmd.Parameters.AddWithValue("@CodDocente", txtCodDocente);
                    sqlCmd.Parameters.AddWithValue("@APaterno", txtAPaterno);
                    sqlCmd.Parameters.AddWithValue("@AMaterno", txtAMaterno);
                    sqlCmd.Parameters.AddWithValue("@Nombre", txtNombre);
                    sqlCmd.Parameters.AddWithValue("@CodEscuelaP", txtCodEscuelaP);
                    sqlCmd.ExecuteNonQuery();
                }
                if (pNombre_Proceso == "Create_Tutoria")
                {
                    sqlCmd.Parameters.AddWithValue("@CodTutoria", txtCodTutoria);
                    sqlCmd.Parameters.AddWithValue("@CodEstudiante", txtCodEstudiante);
                    sqlCmd.Parameters.AddWithValue("@CodDocente", txtCodDocente);
                    sqlCmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                sqlCon.Close();
            }
        }
        public void Read(string pNombre_Proceso)
        {
            try
            {
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
                SqlDataAdapter sqlDa = new SqlDataAdapter(pNombre_Proceso, sqlCon);
                sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dtbl = new DataTable();
                if (pNombre_Proceso == "Read_Estudiante")
                {
                    sqlDa.SelectCommand.Parameters.AddWithValue("@CodEstudiante", txtCodEstudiante);
                    sqlDa.Fill(dtbl);
                }
                if (pNombre_Proceso == "Read_Docente")
                {
                    sqlDa.SelectCommand.Parameters.AddWithValue("@CodDocente", txtCodDocente);
                    sqlDa.Fill(dtbl);
                }
                if (pNombre_Proceso == "Read_Tutoria")
                {
                    sqlDa.SelectCommand.Parameters.AddWithValue("@CodTutoria", txtCodTutoria);
                    sqlDa.Fill(dtbl);
                }
                //Nombre de la tabla
                Nombre_Tabla.DataSource = dtbl;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                sqlCon.Close();
            }
        }
        public void Update(string pNombre_Proceso)
        {
            try
            {
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
                SqlCommand sqlCmd = new SqlCommand(pNombre_Proceso, sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                if (pNombre_Proceso == "Update_Estudiante")
                {
                    sqlCmd.Parameters.AddWithValue("@CodEstudiante", txtCodEstudiante);
                    sqlCmd.Parameters.AddWithValue("@APaterno", txtAPaterno);
                    sqlCmd.Parameters.AddWithValue("@AMaterno", txtAMaterno);
                    sqlCmd.Parameters.AddWithValue("@Nombre", txtNombre);
                    sqlCmd.Parameters.AddWithValue("@CodEscuelaP", txtCodEscuelaP);
                    sqlCmd.Parameters.AddWithValue("@Estado", txtEstado);
                    sqlCmd.ExecuteNonQuery();
                }
                if (pNombre_Proceso == "Update_Docente")
                {
                    sqlCmd.Parameters.AddWithValue("@CodDocente", txtCodDocente);
                    sqlCmd.Parameters.AddWithValue("@APaterno", txtAPaterno);
                    sqlCmd.Parameters.AddWithValue("@AMaterno", txtAMaterno);
                    sqlCmd.Parameters.AddWithValue("@Nombre", txtNombre);
                    sqlCmd.Parameters.AddWithValue("@CodEscuelaP", txtCodEscuelaP);
                    sqlCmd.ExecuteNonQuery();
                }
                if (pNombre_Proceso == "Update_Tutoria")
                {
                    sqlCmd.Parameters.AddWithValue("@CodTutoria", txtCodTutoria);
                    sqlCmd.Parameters.AddWithValue("@CodEstudiante", txtCodEstudiante);
                    sqlCmd.Parameters.AddWithValue("@CodDocente", txtCodDocente);
                    sqlCmd.ExecuteNonQuery();
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                sqlCon.Close();
            }
        }
        public void Delete(string pNombre_Proceso)
        {
            try
            {
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
                SqlCommand sqlCmd = new SqlCommand(pNombre_Proceso, sqlCon);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                if (pNombre_Proceso == "Delete_Estudiante")
                {
                    sqlCmd.Parameters.AddWithValue("@CodEstudiante", txtCodEstudiante);
                    sqlCmd.ExecuteNonQuery();
                }
                if (pNombre_Proceso == "Delete_Docente")
                {
                    sqlCmd.Parameters.AddWithValue("@CodDocente", txtCodDocente);
                    sqlCmd.ExecuteNonQuery();
                }
                if (pNombre_Proceso == "Delete_Tutoria")
                {
                    sqlCmd.Parameters.AddWithValue("@CodTutoria", txtCodTutoria);
                    sqlCmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                sqlCon.Close();
            }
        }
        #endregion
    }

