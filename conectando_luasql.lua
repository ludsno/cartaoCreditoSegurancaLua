-- Carregar a biblioteca LuaSQL para PostgreSQL
local luasql = require("luasql.postgres")

-- Criar um ambiente de conexão
local env = luasql.postgres()

-- Estabelecer a conexão
local conn = env:connect("nome_do_banco", "usuario", "senha", "host", "porta")

if conn then
    print("Conexão estabelecida com sucesso!")
else
    print("Falha na conexão com o banco de dados.")
end
