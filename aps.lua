require("funcao")

if arg[1] == "1" then

nomeArquivo = "Arquivo.txt"
--assert produz erro quando o argumento é falso
arquivo = assert(io.open(nomeArquivo, "w"), "Arquivo erro") 
--modos:r, leitura ; a, anexo; w, escrita; r+, a+, w+ todos
arquivo:write("bom esse bombom sa\n aszdd1")
arquivo:flush();
io.close(arquivo)
--io.write, imprime na tela; io.read(), pega algo que o usuário digita
--modo de leitura
arquivo = assert(io.open(nomeArquivo, "r"), "Arquivo erro")
arquivo:seek("set") --Busca o início do arquivo	
stringTeste = arquivo:read("*all")--Le o arquivo inteiro e retorna
io.close(arquivo)
print(stringTeste)

--criar tabela com o nome table para guardar 
--numero de vezes que cada letra aparece na string
tableLetra = {} 
--gmatch funcao iteradora
--para cada vez que é chamada retorna as proximas capturas do padrao
--%a padrão para todas as letras
for w in string.gmatch(stringTeste, "%w") do
	--print(w) -- percorrendo letra por letra
    print(w)
    if tableLetra[w] == nil then --tableLetra.w acessar o hash na posição w
       	tableLetra[w] = 1
    else -- se é nil então a letra nao estava na hash e inicia com 1
    
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


--proximo passo: percorrer uma table e depois ordenar tudo em um novo vetor
--next retorna 0 quando não há mais elementos
i = 1
listaOrdenada = {} --contem os nós ordenados 
index, value = next(tableLetra) --percorrer a table, next pega index e value
while index do--adicionando os nós numa lista
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

--juntando os nós
while i > 1 do --i vai diminuindo já que é a qtd de nos no vtor
  --bubblesort
  for j=1,i do
    for k=1,i-1 do --recebeu i la em cima
      if(listaOrdenada[k].valor > listaOrdenada[k+1].valor) then
      listaOrdenada[k], listaOrdenada[k+1] = listaOrdenada[k+1], listaOrdenada[k]
      end
    end  
  end
  --fim do bubble
  local soma = listaOrdenada[1].valor + listaOrdenada[2].valor
  local node = no:new({listaOrdenada[1],listaOrdenada[2],nil,soma})
  table.insert(listaOrdenada, node)
  table.remove(listaOrdenada,1)--remove os dois primeiros
  table.remove(listaOrdenada,1)--remove os dois primeiros
  i = i - 1
end

--função para percorrer a arvore e armazenar os caminhos
listatotal = {}--caminho todo percorrido
caminho = {}--guardar o caminho atual
listaBin= {}--letras e seus respectivos caminhos

--Percorre a arvore adicionando os caminhos de cada letra em uma table
listaBin = prefixArv(listaOrdenada[1], listatotal, nil, caminho, listaBin)

print(" ")
--percorrendo string e converterndo para binario
binario = ""
for w in string.gmatch(stringTeste, "[%w%s]") do--stringteste tem a frase
       --print(w.." = "..listaBin[w])
       if listaBin[w] ~= nil then
       binario = binario..listaBin[w]
      end
end
print("binário: "..binario)

--cabecalho para o arquivo
cabecalho2 = ""
index, value = next(listaBin)--listaBin table com letras e seus respectivos caminhos
while index do
  cabecalho2 = cabecalho2.."|"..index..value
  index, value = next(listaBin, index)
end

print(cabecalho2)
local out = assert(io.open("arquivosaida.txt", "w"))
out:write(cabecalho2.."\n")
out:write(binario)
io.close(out)


end
--=========================================fim do compactador

--=========================================início do descompactador

if arg[1] == "2" then

arquivo = assert(io.open("arquivosaida.txt", "r"), "Arquivo erro")
arquivo:seek("set")--position 0
cabecalhoCon = arquivo:read("*line")--ler linha e pular
bin = arquivo:read("*line")
print("cabeçalho: "..cabecalhoCon)

letra = ""
caminho = ""
tableCaminho = {}
flag = 0
arvoreRaiz = no:new({nil,nil,nil,nil})

for w in string.gmatch(cabecalhoCon, ".") do -- passar para table letra->string
  if w == "|" then
    flag = 1
    --print(letra.. "caminho: " .. caminho)
    caminho = ""
  else
    if flag == 1 then-- flag para marcar o primeiro caracter depois do |
      letra = w
      flag = 0
    else
    caminho = caminho..w
    tableCaminho[letra] = caminho
    end
  end  
end

index, value = next(tableCaminho)
node = arvoreRaiz
while index do--construir a arvore usando a table
  print(index.." : "..value)
  node = arvoreRaiz --volta pra raiz
  for w in string.gmatch(value, "[%w%s]") do
    if w == "0" then
      if node.esquerda == nil then
        node.esquerda = no:new({nil, nil, nil, 1})
        node = node.esquerda
      else
        node = node.esquerda
      end
    end

    if w == "1" then
      if node.direita == nil then
        node.direita = no:new({nil, nil, nil, 1})
        node = node.direita
      else
        node = node.direita
      end
    end
  end
  node.letra = index
  index, value = next(tableCaminho, index)
end
arvoreRaiz.letra = nil

--percorrendo a arvore e convertendo tudo
node = arvoreRaiz
frase = ""
for w in string.gmatch(bin, "[%w%s]") do
  if w == "0" then
    node = node.esquerda
  end
  if w == "1" then
    node = node.direita
  end
  if node.letra ~= nil then
    frase = frase..node.letra
    node = arvoreRaiz
  end
end
print(frase)
arquivo = assert(io.open("arquivosaida2.txt", "w"), "Arquivo erro")
arquivo:write(frase)
io.close(arquivo)

end--fin do if de argumento