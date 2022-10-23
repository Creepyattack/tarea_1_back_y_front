using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using tarea_api_2.Models;
namespace tarea_api_2.Controllers{
    [Route("api/[controller]")]
    public class PuestosController : Controller{
        private Conexion dbConexion;
        public PuestosController(){
            dbConexion = Conectar.Create();

        }
        [HttpGet]
        public ActionResult Get(){
            return Ok(dbConexion.Puestos.ToArray());
        }

        [HttpGet("{id}")]
         public async Task<ActionResult> Get(int id) {
             var puestos = await dbConexion.Puestos.FindAsync(id);
            if (puestos != null) {
                return Ok(puestos);
            } else {
                return NotFound();
            }
        }
    }
}