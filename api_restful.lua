local lapis = require("lapis")
local app = lapis.Application()
local db = require("lapis.db")

app:get("/usuarios", function()
    local usuarios = db.query("SELECT * FROM public.usuarios")
    return { json = usuarios } -- Retorna a lista de usuários em formato JSON
end)

app:post("/usuarios", function(self)
    local nome = self.params.nome_usuario
    local sobrenome = self.params.sobrenome_usuario
    local senha = self.params.senha_usuario

    local res = db.query("INSERT INTO public.usuarios (nome_usuario, sobrenome_usuario, senha_usuario) VALUES (?, ?, ?)",
        nome, sobrenome, senha)

    return { json = { mensagem = "Usuário criado com sucesso.", cod_usuario = res } }
end)

app:put("/usuarios/:id", function(self)
    local id = self.params.id
    local nome = self.params.nome_usuario
    local sobrenome = self.params.sobrenome_usuario
    local senha = self.params.senha_usuario

    db.query("UPDATE public.usuarios SET nome_usuario = ?, sobrenome_usuario = ?, senha_usuario = ? WHERE cod_usuario = ?",
        nome, sobrenome, senha, id)

    return { json = { mensagem = "Usuário atualizado com sucesso." } }
end)

app:delete("/usuarios/:id", function(self)
    local id = self.params.id
    db.query("DELETE FROM public.usuarios WHERE cod_usuario = ?", id)

    return { json = { mensagem = "Usuário deletado com sucesso." } }
end)

return app
