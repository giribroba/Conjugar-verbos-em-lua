require("program");
verboEscolhido, conjugacao = PedirVerbo();
t = PresenteIndicativo(verboEscolhido, conjugacao);
for index, value in ipairs(t) do
    print(value);
end