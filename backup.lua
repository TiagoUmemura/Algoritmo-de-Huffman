nomeArquivo = "Arquivo.txt"
--assert produz erro quando o argumento é falso
arquivo = assert(io.open(nomeArquivo, "w"), "Arquivo erro") 
--modos:r, leitura ; a, anexo; w, escrita; r+, a+, w+ todos
arquivo:write("teste teste teste")
arquivo:flush();
io.close(arquivo)
--io.write, imprime na tela; io.read(), pega algo que o usuário digita
--modo de leitura
arquivo = assert(io.open(nomeArquivo, "r"), "Arquivo erro")
arquivo:seek("set") --Busca o início do arquivo	
stringTeste = arquivo:read("*all")--Le o arquivo inteiro e retorna
print(stringTeste)

--criar tabela com o nome table para guardar 
--numero de vezes que cada letra aparece na string
tableLetra = {} 
--gmatch funcao iteradora
--para cada vez que é chamada retorna as proximas capturas do padrao
--%a padrão para todas as letras
for w in string.gmatch(stringTeste, "%w") do
	--print(w) -- percorrendo letra por letra
    if tableLetra[w] == nil then --tableLetra.w acessar o hash na posição w
       	--print("não há letra " .. "\n") -- ..(dois pontos) significa concatenação
       	tableLetra[w] = 1
    else -- se é nil então a letra nao estava na hash e inicia com 1
    	--print("repetiu") -- se ja tem a letra soma +1
    	tableLetra[w] = tableLetra[w] + 1
    end
end

-- for para pegar apenas os espaços
for w in string.gmatch(stringTeste, "%s") do
	if tableLetra[" "] == nil then --tableLetra.w acessar o hash na posição w
       	--print("espaço") 
       	tableLetra[" "] = 1
    else -- se é nil então a letra nao estava na hash e inicia com 1
    	--print("espaço") -- se ja tem a letra soma +1
    	tableLetra[" "] = tableLetra[" "] + 1
    end
end

--função para arvore
local no  = {}
function no:new(obj)
    local n = {}
    n.esquerda = obj[1]
    n.direita = obj[2]
    n.letra = obj[3]
    n.valor = obj[4]--frequencia
    return n
end
--proximo passo: percorrer uma table e depois ordenar tudo em um novo vetor
--next retorna 0 quando não há mais elementos
i = 1
listaOrdenada = {} --contem os nós ordenados 
index, value = next(tableLetra) --percorrer a table, next pega index e value
while index do
  local node = no:new({nil,nil,index,value})
  listaOrdenada[i] = node
  i = i + 1 --incrementa i para ir para proxima pos de listaOrdenada
  print(index.."="..value) -- então valor de i é o tamanho do array
  index, value = next(tableLetra, index)
  --local node = no:new({nil,nil,index,value})
end
i = i - 1
tamanhoArray = i--salvando o tamanho inicial
print(" ")
--print dos nos no array
index, noTeste = next(listaOrdenada)
while index do
  print(index.."==>"..noTeste.letra.. " quant: "..noTeste.valor) 
  index, noTeste = next(listaOrdenada, index)
end
print("i = "..i)


--while i > 1 do
  --i = i - 1
--end
--testando ordenação
for j=1,i do 
  for k=1,i-1 do --recebeu i la em cima
    --print(k)
    if(listaOrdenada[k].valor > listaOrdenada[k+1].valor) then
      listaOrdenada[k], listaOrdenada[k+1] = listaOrdenada[k+1], listaOrdenada[k]
    end
  end
end

print(" ")
index, noTeste = next(listaOrdenada)
while index do
  print(index.."==>"..noTeste.letra.. " quant: "..noTeste.valor) 
  index, noTeste = next(listaOrdenada, index)
end

soma =listaOrdenada[1].valor + listaOrdenada[2].valor
local node = no:new({listaOrdenada[1],listaOrdenada[2],nil,soma})
print(node.letra)
