using System.ComponentModel.DataAnnotations;

namespace tarea_api_2.Models{
    public class Puestos{
        [Key]
        public int idPuesto{get; set;}
        public string Puesto{get; set;}
    }
}