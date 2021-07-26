using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class E_Docente
    {
        private int _IdDocente;
        private string _Nombres;
        private string _ApellidosP;
        private string _ApellidosM;
        private string _TituloAcademico;
        private string _CodEscuela;
        private string _Categoria;

        private string search;

        public int IdDocente { get => _IdDocente; set => _IdDocente = value; }
        public string Nombres { get => _Nombres; set => _Nombres = value; }
        public string ApellidosP { get => _ApellidosP; set => _ApellidosP = value; }
        public string ApellidosM { get => _ApellidosM; set => _ApellidosM = value; }
        public string TituloAcademico { get => _TituloAcademico; set => _TituloAcademico = value; }
        public string CodEscuela { get => _CodEscuela; set => _CodEscuela = value; }
        public string Search { get => search; set => search = value; }
        public string Categoria { get => _Categoria; set => _Categoria = value; }
    }
}
