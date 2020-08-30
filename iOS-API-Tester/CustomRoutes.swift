//
//  CustomRoutes.swift
//  iOS-API-Tester
//
//  Created by Michael Vartanian on 8/29/20.
//  Copyright © 2020 Michael Vartanian. All rights reserved.
//

import Foundation

struct routeType {
    var name: String?
    var method: String?
    var urlPath: String?
    var query: [String: String]?
    var requestHeaders: [String: String]?
    var responseHeaders: [String: String]?
    var code: Int?
    var destination: String?
}

class CustomRoutes {
    
    private let routes: [routeType]

    init() {
        
        // Add your own routes here to test them in the example app
        routes = [
            routeType(name: "Get 1 Todo",
                      method: "GET",
                      urlPath: "https://jsonplaceholder.typicode.com/todos/1",
                      query: [:],
                      requestHeaders: [:],
                      responseHeaders: [:],
                      code: 200,
                      destination: ""),
            routeType(name: "Get All Posts",
            method: "GET",
            urlPath: "https://jsonplaceholder.typicode.com/posts",
            query: [:],
            requestHeaders: [:],
            responseHeaders: [:],
            code: 200,
            destination: ""),
            routeType(name: "Get All Comments",
            method: "GET",
            urlPath: "https://jsonplaceholder.typicode.com/comments",
            query: [:],
            requestHeaders: [:],
            responseHeaders: [:],
            code: 200,
            destination: "")
        ]
    }
    
    func nameOfRoute(at index: Int) -> String {
        if let name = routes[index].name {
            return name
        } else {
            return "error"
        }
    }
    
    var count: Int {
        return routes.count
    }
    
    func performRequest(index: Int, completion: @escaping (HTTPURLResponse, Data, Error?) -> ()) {

        let route = routes[index]
        
        guard let urlPath = route.urlPath, var urlComponents = URLComponents(string: "\(urlPath)")
        //guard let urlPath = route.urlPath, var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/todos/1")
            else {
            print("ERROR: failed to derive URL from mock route")
            return
        }
        
        if let query = route.query {
            urlComponents.queryItems = query.keys.map({ URLQueryItem(name: $0, value: query[$0]) })
        }
        
        guard let url = urlComponents.url else {
            print("ERROR: Couldn't construct URL from components - \(urlComponents)")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = route.requestHeaders
        urlRequest.httpMethod = route.method ?? "GET"
        
        print("Requesting \(url.absoluteString)")

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(HTTPURLResponse(), Data(), error)
            } else {
                completion(response as! HTTPURLResponse, data ?? Data(), error)
            }
        }
        task.resume()
    }
}
