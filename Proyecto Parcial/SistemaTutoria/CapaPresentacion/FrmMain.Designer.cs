
namespace CapaPresentacion
{
    partial class FrmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FrmMain));
            this.Sidebar = new System.Windows.Forms.Panel();
            this.labelUsuario = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.labelCategoria = new System.Windows.Forms.Label();
            this.btnTutoria = new Bunifu.Framework.UI.BunifuFlatButton();
            this.btnDocentes = new Bunifu.Framework.UI.BunifuFlatButton();
            this.btnEstudiantes = new Bunifu.Framework.UI.BunifuFlatButton();
            this.Header = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.Salir = new System.Windows.Forms.PictureBox();
            this.Wrapper = new System.Windows.Forms.Panel();
            this.bunifuDragControl1 = new Bunifu.Framework.UI.BunifuDragControl(this.components);
            this.bunifuElipse1 = new Bunifu.Framework.UI.BunifuElipse(this.components);
            this.Sidebar.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.Header.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.Salir)).BeginInit();
            this.SuspendLayout();
            // 
            // Sidebar
            // 
            this.Sidebar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(155)))), ((int)(((byte)(44)))), ((int)(((byte)(31)))));
            this.Sidebar.Controls.Add(this.labelUsuario);
            this.Sidebar.Controls.Add(this.pictureBox1);
            this.Sidebar.Controls.Add(this.labelCategoria);
            this.Sidebar.Controls.Add(this.btnTutoria);
            this.Sidebar.Controls.Add(this.btnDocentes);
            this.Sidebar.Controls.Add(this.btnEstudiantes);
            this.Sidebar.Dock = System.Windows.Forms.DockStyle.Left;
            this.Sidebar.Location = new System.Drawing.Point(0, 0);
            this.Sidebar.Name = "Sidebar";
            this.Sidebar.Size = new System.Drawing.Size(250, 571);
            this.Sidebar.TabIndex = 0;
            // 
            // labelUsuario
            // 
            this.labelUsuario.Font = new System.Drawing.Font("Times New Roman", 12F);
            this.labelUsuario.ForeColor = System.Drawing.Color.White;
            this.labelUsuario.Location = new System.Drawing.Point(60, 144);
            this.labelUsuario.Name = "labelUsuario";
            this.labelUsuario.Size = new System.Drawing.Size(123, 23);
            this.labelUsuario.TabIndex = 5;
            this.labelUsuario.Text = "USUARIO1";
            this.labelUsuario.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(74, 38);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(100, 90);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 4;
            this.pictureBox1.TabStop = false;
            // 
            // labelCategoria
            // 
            this.labelCategoria.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelCategoria.ForeColor = System.Drawing.Color.White;
            this.labelCategoria.Location = new System.Drawing.Point(41, 12);
            this.labelCategoria.Name = "labelCategoria";
            this.labelCategoria.Size = new System.Drawing.Size(187, 23);
            this.labelCategoria.TabIndex = 3;
            this.labelCategoria.Text = "SISTEMA DE TUTORÍA";
            this.labelCategoria.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // btnTutoria
            // 
            this.btnTutoria.Activecolor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnTutoria.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnTutoria.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.btnTutoria.BorderRadius = 0;
            this.btnTutoria.ButtonText = "Tutoria";
            this.btnTutoria.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnTutoria.DisabledColor = System.Drawing.Color.Gray;
            this.btnTutoria.Iconcolor = System.Drawing.Color.Transparent;
            this.btnTutoria.Iconimage = ((System.Drawing.Image)(resources.GetObject("btnTutoria.Iconimage")));
            this.btnTutoria.Iconimage_right = null;
            this.btnTutoria.Iconimage_right_Selected = null;
            this.btnTutoria.Iconimage_Selected = null;
            this.btnTutoria.IconMarginLeft = 0;
            this.btnTutoria.IconMarginRight = 0;
            this.btnTutoria.IconRightVisible = true;
            this.btnTutoria.IconRightZoom = 0D;
            this.btnTutoria.IconVisible = true;
            this.btnTutoria.IconZoom = 60D;
            this.btnTutoria.IsTab = false;
            this.btnTutoria.Location = new System.Drawing.Point(12, 317);
            this.btnTutoria.Margin = new System.Windows.Forms.Padding(4);
            this.btnTutoria.Name = "btnTutoria";
            this.btnTutoria.Normalcolor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnTutoria.OnHovercolor = System.Drawing.Color.FromArgb(((int)(((byte)(247)))), ((int)(((byte)(158)))), ((int)(((byte)(4)))));
            this.btnTutoria.OnHoverTextColor = System.Drawing.Color.White;
            this.btnTutoria.selected = false;
            this.btnTutoria.Size = new System.Drawing.Size(216, 37);
            this.btnTutoria.TabIndex = 2;
            this.btnTutoria.Text = "Tutoria";
            this.btnTutoria.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.btnTutoria.Textcolor = System.Drawing.Color.Black;
            this.btnTutoria.TextFont = new System.Drawing.Font("Times New Roman", 12F);
            this.btnTutoria.Click += new System.EventHandler(this.btnTutoria_Click);
            // 
            // btnDocentes
            // 
            this.btnDocentes.Activecolor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnDocentes.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnDocentes.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.btnDocentes.BorderRadius = 0;
            this.btnDocentes.ButtonText = "Docentes";
            this.btnDocentes.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnDocentes.DisabledColor = System.Drawing.Color.Gray;
            this.btnDocentes.Iconcolor = System.Drawing.Color.Transparent;
            this.btnDocentes.Iconimage = ((System.Drawing.Image)(resources.GetObject("btnDocentes.Iconimage")));
            this.btnDocentes.Iconimage_right = null;
            this.btnDocentes.Iconimage_right_Selected = null;
            this.btnDocentes.Iconimage_Selected = null;
            this.btnDocentes.IconMarginLeft = 0;
            this.btnDocentes.IconMarginRight = 0;
            this.btnDocentes.IconRightVisible = true;
            this.btnDocentes.IconRightZoom = 0D;
            this.btnDocentes.IconVisible = true;
            this.btnDocentes.IconZoom = 60D;
            this.btnDocentes.IsTab = false;
            this.btnDocentes.Location = new System.Drawing.Point(12, 274);
            this.btnDocentes.Margin = new System.Windows.Forms.Padding(4);
            this.btnDocentes.Name = "btnDocentes";
            this.btnDocentes.Normalcolor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnDocentes.OnHovercolor = System.Drawing.Color.FromArgb(((int)(((byte)(247)))), ((int)(((byte)(158)))), ((int)(((byte)(4)))));
            this.btnDocentes.OnHoverTextColor = System.Drawing.Color.White;
            this.btnDocentes.selected = false;
            this.btnDocentes.Size = new System.Drawing.Size(216, 37);
            this.btnDocentes.TabIndex = 1;
            this.btnDocentes.Text = "Docentes";
            this.btnDocentes.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.btnDocentes.Textcolor = System.Drawing.Color.Black;
            this.btnDocentes.TextFont = new System.Drawing.Font("Times New Roman", 12F);
            this.btnDocentes.Click += new System.EventHandler(this.btnDocentes_Click);
            // 
            // btnEstudiantes
            // 
            this.btnEstudiantes.Activecolor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnEstudiantes.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnEstudiantes.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.btnEstudiantes.BorderRadius = 0;
            this.btnEstudiantes.ButtonText = "Estudiantes";
            this.btnEstudiantes.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnEstudiantes.DisabledColor = System.Drawing.Color.Gray;
            this.btnEstudiantes.Iconcolor = System.Drawing.Color.Transparent;
            this.btnEstudiantes.Iconimage = ((System.Drawing.Image)(resources.GetObject("btnEstudiantes.Iconimage")));
            this.btnEstudiantes.Iconimage_right = null;
            this.btnEstudiantes.Iconimage_right_Selected = null;
            this.btnEstudiantes.Iconimage_Selected = null;
            this.btnEstudiantes.IconMarginLeft = 0;
            this.btnEstudiantes.IconMarginRight = 0;
            this.btnEstudiantes.IconRightVisible = true;
            this.btnEstudiantes.IconRightZoom = 0D;
            this.btnEstudiantes.IconVisible = true;
            this.btnEstudiantes.IconZoom = 60D;
            this.btnEstudiantes.IsTab = false;
            this.btnEstudiantes.Location = new System.Drawing.Point(12, 228);
            this.btnEstudiantes.Margin = new System.Windows.Forms.Padding(4);
            this.btnEstudiantes.Name = "btnEstudiantes";
            this.btnEstudiantes.Normalcolor = System.Drawing.Color.FromArgb(((int)(((byte)(186)))), ((int)(((byte)(124)))), ((int)(((byte)(17)))));
            this.btnEstudiantes.OnHovercolor = System.Drawing.Color.FromArgb(((int)(((byte)(247)))), ((int)(((byte)(158)))), ((int)(((byte)(4)))));
            this.btnEstudiantes.OnHoverTextColor = System.Drawing.Color.White;
            this.btnEstudiantes.selected = false;
            this.btnEstudiantes.Size = new System.Drawing.Size(216, 37);
            this.btnEstudiantes.TabIndex = 0;
            this.btnEstudiantes.Text = "Estudiantes";
            this.btnEstudiantes.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.btnEstudiantes.Textcolor = System.Drawing.Color.Black;
            this.btnEstudiantes.TextFont = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEstudiantes.Click += new System.EventHandler(this.btnEstudiantes_Click);
            // 
            // Header
            // 
            this.Header.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(244)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            this.Header.Controls.Add(this.label1);
            this.Header.Controls.Add(this.Salir);
            this.Header.Dock = System.Windows.Forms.DockStyle.Top;
            this.Header.Location = new System.Drawing.Point(250, 0);
            this.Header.Name = "Header";
            this.Header.Size = new System.Drawing.Size(1021, 60);
            this.Header.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Dock = System.Windows.Forms.DockStyle.Top;
            this.label1.Location = new System.Drawing.Point(0, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(0, 13);
            this.label1.TabIndex = 1;
            // 
            // Salir
            // 
            this.Salir.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Salir.Image = ((System.Drawing.Image)(resources.GetObject("Salir.Image")));
            this.Salir.Location = new System.Drawing.Point(969, 12);
            this.Salir.Name = "Salir";
            this.Salir.Size = new System.Drawing.Size(40, 37);
            this.Salir.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.Salir.TabIndex = 0;
            this.Salir.TabStop = false;
            this.Salir.Click += new System.EventHandler(this.Salir_Click);
            // 
            // Wrapper
            // 
            this.Wrapper.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(244)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            this.Wrapper.Dock = System.Windows.Forms.DockStyle.Fill;
            this.Wrapper.Location = new System.Drawing.Point(250, 0);
            this.Wrapper.Name = "Wrapper";
            this.Wrapper.Size = new System.Drawing.Size(1021, 571);
            this.Wrapper.TabIndex = 2;
            // 
            // bunifuDragControl1
            // 
            this.bunifuDragControl1.Fixed = true;
            this.bunifuDragControl1.Horizontal = true;
            this.bunifuDragControl1.TargetControl = this.Header;
            this.bunifuDragControl1.Vertical = true;
            // 
            // bunifuElipse1
            // 
            this.bunifuElipse1.ElipseRadius = 15;
            this.bunifuElipse1.TargetControl = this;
            // 
            // FrmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1271, 571);
            this.Controls.Add(this.Header);
            this.Controls.Add(this.Wrapper);
            this.Controls.Add(this.Sidebar);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "FrmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmMain";
            this.Load += new System.EventHandler(this.FrmMain_Load);
            this.Sidebar.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.Header.ResumeLayout(false);
            this.Header.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.Salir)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel Sidebar;
        private System.Windows.Forms.Panel Header;
        private System.Windows.Forms.PictureBox Salir;
        private System.Windows.Forms.Panel Wrapper;
        private Bunifu.Framework.UI.BunifuFlatButton btnTutoria;
        private Bunifu.Framework.UI.BunifuFlatButton btnDocentes;
        private Bunifu.Framework.UI.BunifuFlatButton btnEstudiantes;
        private System.Windows.Forms.Label labelUsuario;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label labelCategoria;
        private System.Windows.Forms.Label label1;
        private Bunifu.Framework.UI.BunifuDragControl bunifuDragControl1;
        private Bunifu.Framework.UI.BunifuElipse bunifuElipse1;
    }
}