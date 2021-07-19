
namespace CRUD_02
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.panelMenu = new System.Windows.Forms.Panel();
            this.btnDocente = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.panelChildForm = new System.Windows.Forms.Panel();
            this.btnTutor = new System.Windows.Forms.Button();
            this.btnAlumno = new System.Windows.Forms.Button();
            this.panelMenu.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // panelMenu
            // 
            this.panelMenu.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(23)))), ((int)(((byte)(1)))), ((int)(((byte)(5)))));
            this.panelMenu.Controls.Add(this.btnAlumno);
            this.panelMenu.Controls.Add(this.btnTutor);
            this.panelMenu.Controls.Add(this.btnDocente);
            this.panelMenu.Controls.Add(this.pictureBox1);
            this.panelMenu.Dock = System.Windows.Forms.DockStyle.Left;
            this.panelMenu.Location = new System.Drawing.Point(0, 0);
            this.panelMenu.Name = "panelMenu";
            this.panelMenu.Size = new System.Drawing.Size(246, 611);
            this.panelMenu.TabIndex = 0;
            // 
            // btnDocente
            // 
            this.btnDocente.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnDocente.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnDocente.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDocente.Font = new System.Drawing.Font("Franklin Gothic Demi", 13.8F, System.Drawing.FontStyle.Italic);
            this.btnDocente.ForeColor = System.Drawing.Color.LightGray;
            this.btnDocente.Location = new System.Drawing.Point(0, 142);
            this.btnDocente.Name = "btnDocente";
            this.btnDocente.Size = new System.Drawing.Size(246, 45);
            this.btnDocente.TabIndex = 1;
            this.btnDocente.Text = "Docentes";
            this.btnDocente.UseVisualStyleBackColor = true;
            this.btnDocente.Click += new System.EventHandler(this.btnDocente_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Top;
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(246, 142);
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // panelChildForm
            // 
            this.panelChildForm.BackColor = System.Drawing.Color.Silver;
            this.panelChildForm.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelChildForm.Location = new System.Drawing.Point(246, 0);
            this.panelChildForm.Name = "panelChildForm";
            this.panelChildForm.Size = new System.Drawing.Size(1038, 611);
            this.panelChildForm.TabIndex = 1;
            // 
            // btnTutor
            // 
            this.btnTutor.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnTutor.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnTutor.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnTutor.Font = new System.Drawing.Font("Franklin Gothic Demi", 13.8F, System.Drawing.FontStyle.Italic);
            this.btnTutor.ForeColor = System.Drawing.Color.LightGray;
            this.btnTutor.Location = new System.Drawing.Point(0, 187);
            this.btnTutor.Name = "btnTutor";
            this.btnTutor.Size = new System.Drawing.Size(246, 45);
            this.btnTutor.TabIndex = 2;
            this.btnTutor.Text = "Tutores";
            this.btnTutor.UseVisualStyleBackColor = true;
            this.btnTutor.Click += new System.EventHandler(this.btnTutor_Click);
            // 
            // btnAlumno
            // 
            this.btnAlumno.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnAlumno.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnAlumno.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAlumno.Font = new System.Drawing.Font("Franklin Gothic Demi", 13.8F, System.Drawing.FontStyle.Italic);
            this.btnAlumno.ForeColor = System.Drawing.Color.LightGray;
            this.btnAlumno.Location = new System.Drawing.Point(0, 232);
            this.btnAlumno.Name = "btnAlumno";
            this.btnAlumno.Size = new System.Drawing.Size(246, 45);
            this.btnAlumno.TabIndex = 3;
            this.btnAlumno.Text = "Alumnos";
            this.btnAlumno.UseVisualStyleBackColor = true;
            this.btnAlumno.Click += new System.EventHandler(this.btnAlumno_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1284, 611);
            this.Controls.Add(this.panelChildForm);
            this.Controls.Add(this.panelMenu);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.panelMenu.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panelMenu;
        private System.Windows.Forms.Button btnDocente;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Panel panelChildForm;
        private System.Windows.Forms.Button btnTutor;
        private System.Windows.Forms.Button btnAlumno;
    }
}

