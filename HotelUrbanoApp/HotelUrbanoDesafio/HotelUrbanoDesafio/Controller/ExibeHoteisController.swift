//
//  ExibeHoteisController.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit
import SDWebImage

struct sectionTitle {
    var title : String?
    //var hoteis : [HotelDetalhe] = []
}

var tituloHeader = [sectionTitle]()



class ExibeHoteisController: UITableViewController {
    
    var listaDeHoteis : [HotelDetalhe] = []
    var isError:Bool = false
    var index : Int?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        //chama api hoteis
        navigationItem.title = "Hotéis"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
//        tituloHeader = [sectionTitle(title: "Pacotes"),
//                        sectionTitle(title: "Hospedagem")]
        
        getHoteis()
        
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        
        
        return   listaDeHoteis.count //listaDeHoteis.count//hoteis!.count
    }
  

    // MARK: - Table View data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HotelCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HotelCell
        
        let stars = listaDeHoteis[indexPath.section].stars
        let hoteis = listaDeHoteis[indexPath.row]
        
        //Chama função para preencher campos da tableview
        cell.prepare(with: hoteis)

        return cell
    }
     // MARK: - Table View Chama Detalhe
    //seleciona registro e vai para o detalhe
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        self.index = indexPath.row
        self.performSegue(withIdentifier: "detalheSegue", sender: listaDeHoteis)
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        //let categoria = listaDeHoteis[section].category
//        
//        
//        for h in listaDeHoteis {
//            if h.category == "hotel" {
//                tituloHeader[section].title = h.stars as? String
//            }else {
//                tituloHeader[section].title = "Pacote"
//            }
//        }
//        //let stars = listaDeHoteis[section].stars
//        return tituloHeader[section].title as! String
//    }
    
//     override func tableview(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        let categoria = listaDeHoteis[section].category
//        print ("uurururururur")
//        print (categoria as Any)
//        return categoria
//    }
    

    // MARK: - Função que chama rotina para consumir API
    func getHoteis(){
        HotelRequest.fetchHoteis( sucess: { (hoteis) in
            var hotelOrdenado = [HotelDetalhe]()
            var hotelOrdenadoFinal = [HotelDetalhe] ()
            self.isError = false
     
            //Ordenando a lista pela quantidade de estrelas
            for h in hoteis
            {
                if h.category != "hospedagem" //se categoria = hospedagem trata de Pacote e pacote não possui estrela.
                    {
                        hotelOrdenado = hoteis.sorted
                        {   (hotel1, hotel2) -> Bool in
                                guard let h1 = hotel1.stars else {return true}
                                guard let h2 = hotel2.stars else {return true}
                                return h1 > h2
                        }
                    }
            }
            //Ordenando pela categoria (Hotel ou Pacote)
            hotelOrdenadoFinal = hotelOrdenado.sorted(by: { (h1, h2) -> Bool in
                h1.category! > h2.category!
            })
             
            self.listaDeHoteis.append(contentsOf: hotelOrdenadoFinal)
            self.tableView.reloadData()
        }) { (error) in
                self.isError = true
                self.tableView.reloadData()
                print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheSegue" {
            let destinoView = segue.destination as! DetalheHotelController
            //let hoteis = listaDeHoteis[tableView.indexPathForSelectedRow!.row]
            destinoView.index = self.index
            destinoView.listaDeHoteis = listaDeHoteis
            
        }
    }
    

}

