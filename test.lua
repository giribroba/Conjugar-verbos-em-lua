--Teste feito utilizando BUSTED, use o comando "busted test.lua" para executá-lo
require("program");

describe("Testes de validação do verbo",function ()
    it("Testa palavras terminadas em \"ar, er, ir\" (possiveis verbos)", function ()
        local inputTest = "falaR";
        local testVerbo, testConj = ValidarVerbo(inputTest);
        assert.are.same({inputTest:lower(), 1}, {testVerbo, testConj});

        inputTest = "CoMer";
        testVerbo, testConj = ValidarVerbo(inputTest);
        assert.are.same({inputTest:lower(), 2}, {testVerbo, testConj});

        inputTest = "DORmir";
        testVerbo, testConj = ValidarVerbo(inputTest);
        assert.are.same({inputTest:lower(), 3}, {testVerbo, testConj});
    end)
end);