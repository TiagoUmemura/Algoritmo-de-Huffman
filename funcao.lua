no  = {}
function no:new(obj)
    local n = {}
    n.esquerda = obj[1]
    n.direita = obj[2]
    n.letra = obj[3]
    n.valor = obj[4]--frequencia
    return n
end

function prefixArv(node, listatotal, direction, caminho, listaBin)   
    if node ~= nil then
      --print(node.valor)
      table.insert(listatotal, direction)
      table.insert(caminho, direction)
      if node.letra ~= nil then -- se é letra então adiciona caminho
        table.insert(listatotal, node.letra)
        caminhoLetra = ""
          index, value = next(caminho)
          while index do -- passar o caminho para listaBin com um for para percorrer a table caminh
          print(index.."==>".." valor: "..value)
          caminhoLetra = caminhoLetra..value 
          index, value = next(caminho, index)
          end
        listaBin[node.letra] = caminhoLetra
      end

      prefixArv(node.esquerda,listatotal, "0", caminho, listaBin)
      prefixArv(node.direita,listatotal, "1", caminho, listaBin)
      table.remove(caminho)
    end
    return listaBin
end