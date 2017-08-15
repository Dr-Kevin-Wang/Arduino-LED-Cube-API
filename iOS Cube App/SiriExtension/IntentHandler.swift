//
//  IntentHandler.swift
//  SiriExtension
//
//  Created by Yunxiao Wang on 8/11/17.
//  Copyright © 2017 Min Zhou. All rights reserved.
//
import Foundation
import Intents
    class IntentHandler: INExtension, INSendMessageIntentHandling {
        var send = "";
        override func handler(for intent: INIntent) -> Any {
            // This is the default implementation.  If you want different objects to handle different intents,
            // you can override this and return the handler you want for that particular intent.
            
            return self
        }
        
        // MARK: - INSendMessageIntentHandling
        
        func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
            let notRequired = INPersonResolutionResult.notRequired()
            completion([notRequired])
        }
        
        func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
            if let text = intent.content, !text.isEmpty {
                completion(INStringResolutionResult.success(with: text))
                send = text
            } else {
                completion(INStringResolutionResult.needsValue())
            }
        }
        
        // Once resolution is completed, perform validation on the intent and provide confirmation (optional).
        
        func confirm(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
            // Verify user is authenticated and your app is ready to send a message.
            
            let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
            let response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
            completion(response)
        }
        
        // Handle the completed intent (required).
        
        func handle(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
            // Implement your application logic to send a message here.
            
            var state = 0
            if (send == "Off")
            {
                state = 0
            }
            else
            {
                state = 1
            }
            
                var request = URLRequest(url: URL(string: "http://108.61.72.9/processing.php")!)
                request.httpMethod = "POST"
                let postString = "x=4&y=4&z=4&state=\(state)"
                request.httpBody = postString.data(using: .utf8)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else
                    {
                        print(error!)
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
                    {
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print(response!)
                    }
                }
                task.resume()
                let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
                let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
                completion(response)
            

                    }
                }

