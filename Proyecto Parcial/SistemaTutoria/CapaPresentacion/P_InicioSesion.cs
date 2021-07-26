using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CapaEntidades;
using CapaNegocios;

namespace CapaPresentacion
{
    public partial class P_InicioSesion : Form
    {
        public P_InicioSesion()
        {
            InitializeComponent();
        }

        private void MensajeError(string Mensaje)
        {
            MessageBox.Show(Mensaje, "Sistema de Tutoría", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void btnIngresar_Click(object sender, EventArgs e)
        {
            if (txtUsuario.Text != "")
            {
                if (txtContraseña.Text != "")
                {
                    N_InicioSesion InicioSesion = new N_InicioSesion();
                    var ValidarDatos = InicioSesion.IniciarSesion(txtUsuario.Text, txtContraseña.Text);

                    if (ValidarDatos == true)
                    {
                        if (E_InicioSesion.Acceso == E_Acceso.DirectorEscuela)
                        {
                            Hide();
                            FrmMain Menu = new FrmMain
                            {
                                Acceso = "Director de Escuela"
                            };
                            Menu.Show();
                        }
                        if (E_InicioSesion.Acceso == E_Acceso.Docente)
                        {
                            Hide();
                            FrmMain Menu = new FrmMain
                            {
                                Acceso = "Docente"
                            };
                            Menu.Show();
                        }
                        if (E_InicioSesion.Acceso == E_Acceso.Estudiante)
                        {
                            Hide();
                            FrmMain Menu = new FrmMain
                            {
                                Acceso = "Estudiante"
                            };
                            Menu.Show();
                        }
                    }
                    else
                    {
                        MensajeError("Usuario incorrecto, intente de nuevo");
                        txtContraseña.Clear();
                        txtUsuario.Focus();
                    }
                }
                else
                {
                    MensajeError("Ingrese su contraseña, por favor");
                    txtContraseña.Focus();
                }
            }
            else
            {
                MensajeError("Ingrese su usuario, por favor");
                txtUsuario.Focus();
            }
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
