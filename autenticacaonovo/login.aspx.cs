using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;//objetos que permitem fazer as conexões na base de dados
using System.Data.SqlClient;//objetos que permitem fazer as conexões na base de dados
using System.Configuration;//objetos que permitem ir ao web config e buscar a conexão a base de dados
using System.Security.Cryptography;//biblioteca para encriptar

namespace autenticacaonovo
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["autenticnovoConnectionString2"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();
            //parameters de inputs, ou seja, de passagem de conteúdo da página para o SQL
            // Parâmetros de inputs
            myCommand.Parameters.AddWithValue("@utilizador", tb_utilizador.Text);
            myCommand.Parameters.AddWithValue("@pw", EncryptString(tb_pw.Text));
            myCommand.Parameters.AddWithValue("@cod_estado", 1); // Assumindo que 1 indica "ativo"

            // Parâmetro de output
            SqlParameter retornoParam = new SqlParameter("@retorno", SqlDbType.Int);
            retornoParam.Direction = ParameterDirection.Output;
            myCommand.Parameters.Add(retornoParam);

            // Chamar a stored procedure
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "login"; // Nome da stored procedure

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery();

            int respostaSP = Convert.ToInt32(myCommand.Parameters["@retorno"].Value);

            myConn.Close();

            if (respostaSP == 1)
            {
                // Utilizador e palavra-passe corretas e ativo
                Response.Redirect("~/app.aspx");
            }
            else
            {
                // Utilizador ou palavra-passe incorretos ou não ativo
                lbl_mensagem.Text = "Utilizador ou senha incorretos ou conta não ativa!";
            }
        }

        public static string EncryptString(string Message)
        {
            string Passphrase = "cinel";
            byte[] Results;
            System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();

            // Step 1. We hash the passphrase using MD5
            // We use the MD5 hash generator as the result is a 128 bit byte array
            // which is a valid length for the TripleDES encoder we use below

            MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
            byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));

            // Step 2. Create a new TripleDESCryptoServiceProvider object
            TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();

            // Step 3. Setup the encoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]
            byte[] DataToEncrypt = UTF8.GetBytes(Message);

            // Step 5. Attempt to encrypt the string
            try
            {
                ICryptoTransform Encryptor = TDESAlgorithm.CreateEncryptor();
                Results = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }

            // Step 6. Return the encrypted string as a base64 encoded string

            string enc = Convert.ToBase64String(Results);
            enc = enc.Replace("+", "KKK");
            enc = enc.Replace("/", "JJJ");
            enc = enc.Replace("\\", "III");
            return enc;
        }

        protected void btn_recuperar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/recuperar.aspx");
        }
    }
}