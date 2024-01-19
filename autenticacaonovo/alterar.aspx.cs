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
    public partial class alterar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_confirmar_Click(object sender, EventArgs e)
        {
            //chamar a base de dados e ver se o utilizador e senha estão correto ou não
            SqlConnection myConn = new SqlConnection(ConfigurationManager.ConnectionStrings["autenticnovoConnectionString2"].ConnectionString);

            SqlCommand myCommand = new SqlCommand();
            //parameters de inputs, ou seja, de passagem de conteúdo da página para o SQL
            myCommand.Parameters.AddWithValue("@pwAtual", EncryptString(tb_atual.Text));
            myCommand.Parameters.AddWithValue("@pwNova", EncryptString(tb_nova.Text));
            myCommand.Parameters.AddWithValue("@confirmePw", EncryptString(tb_nova.Text));

            // parâmetro de saída (output) para a mensagem
            SqlParameter mensagemParam = new SqlParameter("@mensagem", SqlDbType.NVarChar, -1);
            mensagemParam.Direction = ParameterDirection.Output;
            myCommand.Parameters.Add(mensagemParam);

            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.CommandText = "alterar_PW"; //nome da stored procedure

            myCommand.Connection = myConn;
            myConn.Open();
            myCommand.ExecuteNonQuery();//expulsão para a base de dados que não retorna dados, insert

            // Obtenha a mensagem de saída
            string mensagem = mensagemParam.Value.ToString();

            // Exiba a mensagem na sua página
            lbl_mensagem.Text = mensagem;

            myConn.Close();//sempre fechar a conexão

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
    }
}