function LimparTela()
    -- se estiver sendo executado em no windows
    if  os.getenv("HOME") == nil then
        os.execute("cls");
    else
        os.execute("clear");
    end
end

function ValidarVerbo(verbo)
    verbo = verbo:lower():gsub(" ", "");
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
    print("Digite um verbo (REGULAR), no infinitivo, a ser conjugado:")
    return ValidarVerbo(io.read());
end

function AddDesNumPessoa(palavra, desinencia)
    if palavra:sub(palavra:len()) == desinencia:sub(1,1) then
        palavra = palavra:sub(1, palavra:len()-1);
    end
    return palavra .. desinencia;
end

function AddDesModoTempo(palavra, desinencia, troca) -- "Troca" deve ser TRUE no plural da segunda pessoa (vós) do modo INDICATIVO
    local vogais = {"a", "e", "i", "o", "u"};

    -- Se a PALAVRA e terminar com vogal e a DESINENCIA iniciar com vogal, a da PALAVRA será suplantada
    for i, value in ipairs(vogais) do
        if palavra:sub(palavra:len()) == value then
            for j, value2 in ipairs(vogais) do
                if desinencia:sub(0,1) == value2 then
                    palavra = palavra:sub(0, palavra:len()-1);
                    break;
                end
            end
            break;
        end
    end

    if troca then
        desinencia = desinencia:gsub("a", "e");
    end
    return palavra .. desinencia;
end

function PresenteIndicativo(verbo, conjugacao)
    --Na terceira conjugação, a vogal temática é substituída pela letra "e", exeto na primeira e segunda pessoa do plural
    if conjugacao == 3 then
        verbo = verbo:sub(0, verbo:len()-2) .. "er";
    end
    local desinencias = {"o", "s", "", "mos", "is", "m"};
    local result = {};
    for i = 1, 6, 1 do
        local temp;
        --Volta a vogal temática da terceira conjugação
        if conjugacao == 3 and i > 3  and i < 6 then
            temp = verbo:sub(0, verbo:len()-2) .. "ir";
        else
            temp = verbo;
        end
        --Na primeira passoa do singular, a vogal temática é suprimida.
        if i == 1 then
            table.insert(result, AddDesNumPessoa(temp:sub(0, verbo:len()-2), desinencias[i]));
        else
            table.insert(result, AddDesNumPessoa(temp:sub(0, verbo:len()-1), desinencias[i]));
        end
    end

    return result;
end

function PretPerfIndicativo(verbo, conjugacao)
    local desinencias = {"i", "ste", "u", "mos", "stes", "ram"};
    local result = {};
    for i = 1, 6, 1 do
        local tempDes = desinencias[i];
        local tempVerbo = verbo;
        
        if conjugacao == 1 then
            --Na primeira pessoa do singular da primeira conjugação, adiciona-se "e" antes da desinência
            if i == 1 then
                tempDes = "e" .. desinencias[i];
            --Na terceira pessoa do singular da primeira conjugação, adiciona-se "o" no lugar da vogal temática
            elseif i == 3 then
                tempVerbo = verbo:sub(0, verbo:len()-2) .. "or";
            end
        end

        --Na primeira e terceira passoa do singular, a vogal temática é suprimida.
        if i == 1 then
            table.insert(result, AddDesNumPessoa(tempVerbo:sub(0, verbo:len()-2), tempDes));
        else
            table.insert(result, AddDesNumPessoa(tempVerbo:sub(0, verbo:len()-1), tempDes));
        end
    end
    return result;
end

--Derivado do infitinivo
function PretImpfIndicativo (verbo, conjugacao)
    local desNumPessoa = {"", "s", "", "mos", "is", "m"};
    local desModoTempo = {"va", "ia"};
    local result = {};

    for i = 1, 6, 1 do
        local des = desModoTempo[2];
        if conjugacao == 1 then
            des = desModoTempo[1];
        end
        table.insert(result, AddDesNumPessoa(AddDesModoTempo(verbo:sub(0, verbo:len()-1), des, i == 5), desNumPessoa[i]));
    end

    return result;
end

--Derivado do presente perfeito
function PretMaisQPerfIndicativo(verbo, conjugacao)
    local desNumPessoa = {"", "s", "", "mos", "is", "m"};
    local desModoTempo = "ra";
    local result = {};

    for i = 1, 6, 1 do
        --Deriva do plural da primeira pessoa, removendo a desinência numero-pessoal. 
        local deriv = PretPerfIndicativo(verbo,conjugacao)[4];
        deriv = deriv:sub(0, deriv:len()-3);

        table.insert(result, AddDesNumPessoa(AddDesModoTempo(deriv, desModoTempo, i == 5), desNumPessoa[i]));
    end

    return result;
end

--Derivado do infinitivo
function FuturoDoPresenteIndivativo(verbo, conjugacao)
    local desNumPessoa = {"i", "s", "", "mos", "is", "o"};
    local desModoTempo = {"re", "ra"};
    local result = {};

    for i = 1, 6, 1 do
        local des = desModoTempo[1];
        if i == 2 or i == 3 or i == 6 then
            des = desModoTempo[2];
        end
        table.insert(result, AddDesNumPessoa(AddDesModoTempo(verbo:sub(0, verbo:len()-1), des, i == 5), desNumPessoa[i]));
    end

    return result;
end

--Derivado do infinitivo
function FuturoDoPreteritoIndivativo(verbo, conjugacao)
    local desNumPessoa = {"", "s", "", "mos", "is", "m"};
    local desModoTempo = "ria";
    local result = {};

    for i = 1, 6, 1 do
        table.insert(result, AddDesNumPessoa(AddDesModoTempo(verbo:sub(0, verbo:len()-1), desModoTempo, i == 5), desNumPessoa[i]));
    end

    return result;
end