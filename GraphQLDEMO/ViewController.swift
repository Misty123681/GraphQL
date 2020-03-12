//
//  ViewController.swift
//  GraphQLDEMO
//
//  Created by Neosoft on 14/01/20.
//  Copyright © 2020 Neosoft. All rights reserved.
//

import UIKit
import Apollo

let token = "b9b76ab5a40c8c5729a45dfe24cc0fcedba45a5d"

 

class ViewController: UIViewController {
    
     @IBOutlet weak var submitButton: UIButton!
//
//    let apollo: ApolloClient = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = [
//            "Authorization":"Bearer\("b9b76ab5a40c8c5729a45dfe24cc0fcedba45a5d")"
//        ]
//
//        let url = URL(string: "https://api.github.com/graphql")!
//
//        return ApolloClient(
//            networkTransport: HTTPNetworkTransport(
//                url: url,session: URLSession(configuration: configuration)
//            )
//        )
//    }()
//
    
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        var authValue: String? = "Bearer \(token)"
        let authPayloads = ["Authorization": authValue ?? ""]
        let graphEndpoint = "https://api.github.com/graphql"
        configuration.httpAdditionalHeaders = authPayloads
        let endpointURL = URL(string: graphEndpoint)!
        return ApolloClient(
            networkTransport: HTTPNetworkTransport( url: endpointURL,  session: URLSession(configuration: configuration))
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var x = 0
        var y = 0
       switch (40, 2) {
        case ( x,  y):
           print("\(x) \(y)")
       default:
        break
        }
       print("\(x) \(y)")
        
       
        apollo.fetch(query:OrganizationInfoQuery(login: "github")){
            result in
            
            switch result{
                case.success(let response):
                    let login = response.data?.organization?.pendingMembers
                   
                   
                 print(response.data!)
                   
                
                case.failure(let error):
               
                debugPrint(error)
            }
            
        }
        // query: OrganizationInfoQuery(login: "github")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
           submitButton.backgroundColor = UIColor.red
    }
    
}

