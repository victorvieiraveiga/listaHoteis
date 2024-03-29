//
//  ExibeHoteisController.swift
//  HotelUrbanoDesafio
//
//  Created by Victor Vieira on 14/10/19.
//  Copyright © 2019 Victor Vieira. All rights reserved.
//

import UIKit
import SDWebImage

//Enum para definir as seções da TableView
enum SectionTable: Int {
    case CincoEstrelas = 0, QuatroEstrelas = 1, TresEstrelas = 2 , DuasEstrelas = 3, UmaEstrela = 4, ZeroEstrelas = 5, Pacotes = 6
}



class ExibeHoteisController: UITableViewController {
    
    fileprivate var results: [SectionTable: [HotelDetalhe]] = [:]
    var listaDeHoteis : [HotelDetalhe] = []
    var isError:Bool = false
    var index : Int?
    var section : Int?
    var hotel : Any?


    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Hotéis"
        
        //chama api hoteis
        getHoteis()
 
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 7 // Estrelas + Pacote
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if let tableSection = SectionTable(rawValue: section), let hotelData = results[tableSection] {
           return hotelData.count
        }

        return 0
        
    }
  

    // MARK: - Table View data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HotelCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HotelCell
        
        //se houver conteudo carrega tableview
       if let tableSection = SectionTable(rawValue: indexPath.section), let hotel = results[tableSection]?[indexPath.row] {
            cell.prepare(with: hotel)
        }
  
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //se houver conteudo na section, alterar height do header para 25. Senão, retorna 0 (conteúdo vazio).
        if let tableSection = SectionTable(rawValue: section), let hotelData = results[tableSection], hotelData.count > 0 {
            return 25
        }
        
        return 0
        
    }
    
    
     // MARK: - Table View Chama Detalhe
    //seleciona registro e vai para o detalhe
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if let tableSection = SectionTable(rawValue: indexPath.section), let hotel = results[tableSection]?[indexPath.row] {
              
            self.section = indexPath.section
            self.index = indexPath.row
            self.hotel = hotel
           // self.performSegue(withIdentifier: "detalheSegue", sender: listaDeHoteis)
            self.performSegue(withIdentifier: "detalheSegue", sender: hotel)
           }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //Preenche o Header das sections
        return Constantes.HEADER[section]
    }
    
    

    // MARK: - Função que chama rotina para consumir API
    func getHoteis() -> Int{
        
        let ht = ApiRequest()
 
        ht.fetchHoteis( sucess: { (hoteis) in
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
            //Ordenando pela categoria (Hotel ou Pacote) para que os pacotes sejam exibidos por ultimo.
            hotelOrdenadoFinal = hotelOrdenado.sorted(by: { (h1, h2) -> Bool in
                h1.category! > h2.category!
            })
             
            self.listaDeHoteis.append(contentsOf: hotelOrdenadoFinal)
            if self.listaDeHoteis.count > 0 {
                
                print("Lista de Hoteis Carregada com \(self.listaDeHoteis.count): elementos")
            }
            
            
            //preenche results organizado pelo numero de estrelas
            //para poder exibir na TableView agrupando por sections
            self.results[.CincoEstrelas] = self.listaDeHoteis.filter({$0.stars == 5})
            self.results[.QuatroEstrelas] = self.listaDeHoteis.filter({$0.stars == 4})
            self.results[.TresEstrelas] = self.listaDeHoteis.filter({$0.stars == 3})
            self.results[.DuasEstrelas] = self.listaDeHoteis.filter({$0.stars == 2})
            self.results[.UmaEstrela] = self.listaDeHoteis.filter({$0.stars == 1})
            self.results[.ZeroEstrelas] = self.listaDeHoteis.filter({$0.stars == 0})
            self.results[.Pacotes] = self.listaDeHoteis.filter({$0.stars == nil})
            
            self.tableView.reloadData()
            
        }) { (error) in
                self.isError = true
                self.tableView.reloadData()
                print(error)
        }
        return self.listaDeHoteis.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Segue para enviar informacoes para pagina de detalhe
        if segue.identifier == "detalheSegue" {
            
            let destinoView = segue.destination as! DetalheHotelController
            destinoView.index = self.index
            destinoView.listaDeHoteis = listaDeHoteis
            destinoView.results = results
            destinoView.section = self.section
            print("Chama Detalhe.")
        }
    }

}

