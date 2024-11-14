local luasql = require("luasql.postgres")
local env = luasql.postgres()
local conn = env:connect("cartao_seguro", "seu_usuario", "sua_senha", "localhost")

function Cartao.criar(numero, usuario_id, limite)
    local query = string.format(
        "INSERT INTO cartoes (numero, usuario_id, limite) VALUES ('%s', %d, %f);",
        numero, usuario_id, limite
    )
    return conn:execute(query)
end

function Cartao.obterPorId(id)
    local cur = conn:execute(string.format("SELECT * FROM cartoes WHERE id = %d;", id))
    return cur:fetch({}, "a")
end

function Cartao.ajustarLimite(id, novo_limite)
    return conn:execute(string.format("UPDATE cartoes SET limite = %f WHERE id = %d;", novo_limite, id))
end

function Cartao.bloquear(id)
    return conn:execute(string.format("UPDATE cartoes SET bloqueado = TRUE WHERE id = %d;", id))
end

function Cartao.deletar(id)
    return conn:execute(string.format("DELETE FROM cartoes WHERE id = %d;", id))
end

function Cartao.gerarTokenAutenticacao(id)
    local token = tostring(math.random(100000, 999999))
    conn:execute(string.format("UPDATE cartoes SET token_autenticacao = '%s' WHERE id = %d;", token, id))
    return token
end

function Cartao.validarToken(id, token)
    local cur = conn:execute(string.format("SELECT token_autenticacao FROM cartoes WHERE id = %d;", id))
    local result = cur:fetch({}, "a")
    return result and result.token_autenticacao == token
end