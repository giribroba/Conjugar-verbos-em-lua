function LimparTela()
    -- se estiver sendo executado em no windows
    if  os.getenv("HOME") == nil then
        os.execute("cls");
    else
        os.execute("clear");
    end
end
function ValidarVerbo(verbo)
    verbo = verbo:lower();
    local terminacoes = {"ar","er","ir"};
    local valido = false;
    local conjugacao = 1;
    --se a palavra fornecida como "verbo" termina com "xr" sendo "x" uma vogal temática (a,e,i) => valido = true
    for i , value in ipairs(terminacoes) do  
        if verbo:sub(verbo:len()-1,verbo:len()) == value then
            valido = true;
            break;
        end
        conjugacao = conjugacao + 1;
    end
    
    if valido then
        return verbo, conjugacao;
    else
        print("\nVerbo inválido! \nPrecione ENTER para continuar");
        io.read();
        return PedirVerbo();
    end
end

function PedirVerbo()
    LimparTela();
    print("Digite um verbo (regular), no infinitivo, a ser conjugado:")
    return ValidarVerbo(io.read());
end