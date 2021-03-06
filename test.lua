---@diagnostic disable: undefined-global
--Teste feito utilizando BUSTED, use o comando "busted test.lua" para executá-lo
require("program");

describe("Testes de validação do verbo",function ()
    it("Testa palavras terminadas em \"ar, er, ir\" (possiveis verbos)", function ()
        local entradaTeste = "falaR";
        local verboTeste, conjTeste = ValidarVerbo(entradaTeste);
        assert.are.same({"falar", 1}, {verboTeste, conjTeste});

        entradaTeste = "Co   Mer";
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
    
    it("Pretérito imperfeito do indicativo", function ()
        local verboTeste, conjTeste = ValidarVerbo("amar"); 
        assert.are.same({"amava", "amavas", "amava", "amavamos", "amaveis", "amavam"}, PretImpfIndicativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("correr"); 
        assert.are.same({"corria", "corrias", "corria", "corriamos", "corrieis", "corriam"}, PretImpfIndicativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("partir"); 
        assert.are.same({"partia", "partias", "partia", "partiamos", "partieis", "partiam"}, PretImpfIndicativo(verboTeste, conjTeste));

    end);

    it("Pretérito mais que perfeito do indicativo", function ()
        local verboTeste, conjTeste = ValidarVerbo("amar"); 
        assert.are.same({"amara", "amaras", "amara", "amaramos", "amareis", "amaram"}, PretMaisQPerfIndicativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("correr"); 
        assert.are.same({"correra", "correras", "correra", "correramos", "correreis", "correram"}, PretMaisQPerfIndicativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("partir"); 
        assert.are.same({"partira", "partiras", "partira", "partiramos", "partireis", "partiram"}, PretMaisQPerfIndicativo(verboTeste, conjTeste));

    end);

    it("Futuro do presente do indicativo", function ()
        local verboTeste, conjTeste = ValidarVerbo("amar"); 
        assert.are.same({"amarei", "amaras", "amara", "amaremos", "amareis", "amarao"}, FuturoDoPresenteIndivativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("correr"); 
        assert.are.same({"correrei", "correras", "correra", "correremos", "correreis", "correrao"}, FuturoDoPresenteIndivativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("partir"); 
        assert.are.same({"partirei", "partiras", "partira", "partiremos", "partireis", "partirao"}, FuturoDoPresenteIndivativo(verboTeste, conjTeste));

    end);

    it("Futuro do preterito do indicativo", function ()
        local verboTeste, conjTeste = ValidarVerbo("amar"); 
        assert.are.same({"amaria", "amarias", "amaria", "amariamos", "amarieis", "amariam"}, FuturoDoPreteritoIndivativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("correr"); 
        assert.are.same({"correria", "correrias", "correria", "correriamos", "correrieis", "correriam"}, FuturoDoPreteritoIndivativo(verboTeste, conjTeste));

        verboTeste, conjTeste = ValidarVerbo("partir"); 
        assert.are.same({"partiria", "partirias", "partiria", "partiriamos", "partirieis", "partiriam"}, FuturoDoPreteritoIndivativo(verboTeste, conjTeste));

    end);
end)