function criar(params)
    local status = Cartao.criar(params.numero, params.usuario_id, params.limite)
    return sailor.respond_json({success = status ~= nil})
end

function bloquear(params)
    local status = Cartao.bloquear(tonumber(params.id))
    return sailor.respond_json({success = status ~= nil})
end

function ajustar_limite(params)
    local status = Cartao.ajustarLimite(tonumber(params.id), tonumber(params.limite))
    return sailor.respond_json({success = status ~= nil})
end

function autenticar(params)
    local token = Cartao.gerarTokenAutenticacao(tonumber(params.id))
    return sailor.respond_json({token = token})
end

function validar_token(params)
    local valid = Cartao.validarToken(tonumber(params.id), params.token)
    return sailor.respond_json({success = valid})
end

function api_route(params)
    if params.action == "criar" then
        return criar(params)
    elseif params.action == "bloquear" then
        return bloquear(params)
    elseif params.action == "ajustar_limite" then
        return ajustar_limite(params)
    elseif params.action == "autenticar" then
        return autenticar(params)
    elseif params.action == "validar_token" then
        return validar_token(params)
    else
        return sailor.respond_json({error = "Ação inválida"}, 400)
    end
end