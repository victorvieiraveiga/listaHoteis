# Desafio Hotel Urbano

Aplicativo para dispositivo iOS (Swift) que consome o JSON exposto pela API de busca do Hurb e apresenta as informações em uma listagem. 

<table>
  <tbody>
    <tr>
      <td> <img src="Tela0.png" height="350" width="170" /> </td>
      <td> <img src="Tela1.png" height="350" width="170" /> </td>
      
   
  </tbody>
</table>

# Novas Features
Ao tocar em uma celula o app abre uma pagina de detalhe exibindo o Nome do Hotel, foto em maior tamanho e descrição. 
Na tela de detalhe é possivel ver a localização do Hotel no Mapa tocando no icone no canto superior direito.


<table>
  <tbody>
    <tr>
      <td> <img src="Tela2.png" height="350" width="170" /> </td>
      <td> <img src="Tela3.png" height="350" width="170" /> </td>
    
    
  </tbody>
</table>


# API
A API utilizada neste desafio foi do próprio Hurb, que entrega a listagem de resultados para um determinado local e outra que retorna uma lista de sugestões de lugares de acordo com o texto informado.

URL:

GET https://www.hurb.com/search/api?q=buzios&page=1

Na URL acima, é passado como parâmetros o texto para busca, o item que será ordenado e o número da página. O documento JSON contem um nó chamado results, que contém os hotéis e pacotes de Búzios.

# Funcionalidades

Os hotéis estão ordenados em quantidade de estrelas (de 5 a 0) e, por último, os pacotes.
Foram adicionadas às células de visualização do hotel como nome, preço, cidade, estado, foto, tres amenidades e uma stack exibindo o numero de estrelas do Hotel.
Tela de detalhes do hotel ou pacote
Exibe a foto em escala maior e Descrição do Hotel.
Há um mapa para visualizar o endereço.


#Bibliotecas de terceiros utilizadas

SDWebImage, para fazer cache das imagens no dispositivo.

