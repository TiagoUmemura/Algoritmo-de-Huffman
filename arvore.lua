-- ponteiro e referencias assim como no C
local no  = {}

function no:new(obj)
    local n = {}
    n.esquerda = obj[1]
    n.direita = obj[2]
    n.letra = obj[3]
    n.valor = obj[4]
    return n
end

local node = no:new({nil,nil,"a",5})
print(node.letra)   --- a

local node2 = no:new({node,nil,"b",3})
print(node2.letra) -- b

nodetest = node2.esquerda
print(nodetest.valor)

teste = "asd"
teste = teste .. "wert"
print(teste)

--cabeçalho arvore
cabecalho = {}
function prefixArvC(node2,cabecalho)--monta o cabeçalho 
    if node2 ~= nil then
      print(node2.valor)
      if node2.letra == nil then
        table.insert(cabecalho, "<+")
      else
        table.insert(cabecalho, "<"..node2.letra)
      end
      prefixArvC(node2.esquerda, cabecalho)
      prefixArvC(node2.direita, cabecalho)
      table.insert(cabecalho, ">")
    else
      table.insert(cabecalho, "<")
      table.insert(cabecalho, ">")
    end
      
    return cabecalho
end

--função para converter para decimal
--[[function toNum(binario)--converte
  p = 0
  reverse = string.reverse(binario)
  total = 0
  for w in string.gmatch(reverse, "[%g%s]") do--colchete or
    if(w == "1") then
      total = total + 2^p
    end
    p = p+1
  end
  return total
end
--pegar de 8 em 8 bits
contador = 0
subbinario = ""
numeroBits = 0--armazena o numero de bits
seqArq = "" -- sequencia que sera gravada no arquivo
for w in string.gmatch(binario, "[%g%s]") do--colchete or
  numeroBits = numeroBits + 1
  contador = contador + 1
  subbinario = subbinario..w
  if contador == 8 then
    seqArq = seqArq..toNum(subbinario).." "
    subbinario = ""
    contador = 0
  end
end
if contador ~= 0 then --pegar o resto dos bits se tiver, caso contrario pegou 8 em 8
  seqArq = seqArq..toNum(subbinario).." "
end
print(seqArq)--]]

--cabeçalho arvore
--[[cabecalho = {}
function prefixArvC(node2,cabecalho)--monta o cabeçalho 
    if node2 ~= nil then
      print(node2.valor)
      if node2.letra == nil then
        table.insert(cabecalho, "<+")
      else
        table.insert(cabecalho, "<"..node2.letra)
      end
      prefixArvC(node2.esquerda, cabecalho)
      prefixArvC(node2.direita, cabecalho)
      table.insert(cabecalho, ">")
    else
      table.insert(cabecalho, "<")
      table.insert(cabecalho, ">")
    end
      
    return cabecalho
end
cabecalhoStr = ""
cabecalho = prefixArvC(listaOrdenada[1], cabecalho)
index, value = next(cabecalho)
while index do
  --print(index.."==>"..value)
  cabecalhoStr = cabecalhoStr..value 
  index, value = next(cabecalho, index)
end--]]
