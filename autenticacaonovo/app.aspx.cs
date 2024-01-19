using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace autenticacaonovo
{
    public partial class app : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_alterar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/alterar.aspx");
        }

        protected void btn_gestao_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/gestao.aspx");
        }
    }
}