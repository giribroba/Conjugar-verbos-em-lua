--Teste feito utilizando BUSTED, use o comando "busted test.lua" para executá-lo
require("program");

describe("Testes de validação do verbo",function ()
    it("Testa palavras terminadas em \"ar, er, ir\" (possiveis verbos)", function ()
        local entradaTeste = "falaR";
        local verboTeste, conjTeste = ValidarVerbo(entradaTeste);
        assert.are.same({"falar", 1}, {verboTeste, conjTeste});

        entradaTeste = "Co Mer";
        verboTeste, conjTeste = ValidarVerbo(entradaTeste);
        assert.are.same({"comer", 2}, {verboTeste, conjTeste});

        entradaTeste = "DOR mir";
        verboTeste, conjTeste = ValidarVerbo(entradaTeste);
        assert.are.same({"dormir", 3}, {verboTeste, conjTeste});
    end);
end);

describe("Testa conjugações",function ()
    it("Presente do indicativo", function ()
        local verboTeste, conjTeste = ValidarVerbo("amar"); 
        assert.are.same({"amo", "amas", "ama", "amamos", "amais", "amam"}, PresenteIndicativo(verboTeste,conjTeste));

        verboTeste, conjTeste = ValidarVerbo("correr"); 
        assert.are.same({"corro", "corres", "corre", "corremos", "correis", "correm"}, PresenteIndicativo(verboTeste,conjTeste));

        verboTeste, conjTeste = ValidarVerbo("partir"); 
        assert.are.same({"parto", "partes", "parte", "partimos", "partis", "partem"}, PresenteIndicativo(verboTeste,conjTeste));
    end);
    it("Pretérito perfeito do indicativo", function ()
        local verboTeste, conjTeste = ValidarVerbo("amar"); 
        assert.are.same({"amei", "amaste", "amou", "amamos", "amastes", "amaram"}, PretPerfIndicativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("correr"); 
        assert.are.same({"corri", "correste", "correu", "corremos", "correstes", "correram"}, PretPerfIndicativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("partir"); 
        assert.are.same({"parti", "partiste", "partiu", "partimos", "partistes", "partiram"}, PretPerfIndicativo(verboTeste, conjTeste));
    end);
end)