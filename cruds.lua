-- Conexão com o banco de dados
local luasql = require "luasql.postgres"

local function connect()
    local env = luasql.postgres()
    local conn = env:connect("nome_do_banco", "usuario", "senha", "host", "porta")
    return conn
end

-- Criar usuário
local function create_usuario(nome, sobrenome, senha)
    local conn = connect()
    local sql = string.format("INSERT INTO public.usuarios (senha_usuario, nome_usuario, sobrenome_usuario) VALUES ('%s', '%s', '%s')", senha, nome, sobrenome)
    
    local res, err = conn:execute(sql)
    if not res then
        print("Erro ao inserir usuário: " .. err)
    else
        print("Usuário inserido com sucesso.")
    end

    conn:close()
end

-- Ler usuário
local function read_usuarios()
    local conn = connect()
    local sql = "SELECT * FROM public.usuarios"
    
    local cursor = conn:execute(sql)
    local row = cursor:fetch({}, "a")

    while row do
        print(string.format("ID: %d, Nome: %s, Sobrenome: %s", row.cod_usuario, row.nome_usuario, row.sobrenome_usuario))
        row = cursor:fetch(row, "a")
    end

    cursor:close()
    conn:close()
end


-- Atualizar usuário
local function update_usuario(cod_usuario, nome, sobrenome, senha)
    local conn = connect()
    local sql = string.format("UPDATE public.usuarios SET nome_usuario = '%s', sobrenome_usuario = '%s', senha_usuario = '%s' WHERE cod_usuario = %d", nome, sobrenome, senha, cod_usuario)
    
    local res, err = conn:execute(sql)
    if not res then
        print("Erro ao atualizar usuário: " .. err)
    else
        print("Usuário atualizado com sucesso.")
    end

    conn:close()
end

-- Deletar usuário
local function delete_usuario(cod_usuario)
    local conn = connect()
    local sql = string.format("DELETE FROM public.usuarios WHERE cod_usuario = %d", cod_usuario)
    
    local res, err = conn:execute(sql)
    if not res then
        print("Erro ao deletar usuário: " .. err)
    else
        print("Usuário deletado com sucesso.")
    end

    conn:close()
end

-- Criar cartão
local function create_cartao(numero_cartao, limite_cartao, cod_usuario)
    local conn = connect()
    local sql = string.format("INSERT INTO public.cartoes (numero_cartao, limite_cartao, cod_usuario) VALUES (%d, %d, %d)", numero_cartao, limite_cartao, cod_usuario)

    local res, err = conn:execute(sql)
    if not res then
        print("Erro ao inserir cartão: " .. err)
    else
        print("Cartão inserido com sucesso.")
    end

    conn:close()
end

-- Ler cartão
local function read_cartoes()
    local conn = connect()
    local sql = "SELECT * FROM public.cartoes"

    local cursor = conn:execute(sql)
    local row = cursor:fetch({}, "a")

    while row do
        print(string.format("ID: %d, Número do Cartão: %d, Limite: %.2f", row.cod_cartao, row.numero_cartao, row.limite_cartao))
        row = cursor:fetch(row, "a")
    end

    cursor:close()
    conn:close()
end

-- Atualizar cartão
local function update_cartao(cod_cartao, numero_cartao, limite_cartao, estado_cartao)
    local conn = connect()
    local sql = string.format("UPDATE public.cartoes SET numero_cartao = %d, limite_cartao = %.2f, estado_cartao = %s WHERE cod_cartao = %d", numero_cartao, limite_cartao, tostring(estado_cartao), cod_cartao)
    
    local res, err = conn:execute(sql)
    if not res then
        print("Erro ao atualizar cartão: " .. err)
    else
        print("Cartão atualizado com sucesso.")
    end

    conn:close()
end

-- Deletar cartão
local function delete_cartao(cod_cartao)
    local conn = connect()
    local sql = string.format("DELETE FROM public.cartoes WHERE cod_cartao = %d", cod_cartao)

    local res, err = conn:execute(sql)
    if not res then
        print("Erro ao deletar cartão: " .. err)
    else
        print("Cartão deletado com sucesso.")
    end

    conn:close()
end
