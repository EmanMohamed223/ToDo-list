//
//  ToDo.swift
//  ToDo
//
//  Created by Eman on 26/01/2023.
//

import Foundation
struct ToDo: Equatable , Codable
{
    
    let id = UUID()
        var title: String
        var isComplete: Bool
        var dueDate: Date
        var notes: String?
        static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
            return lhs.id == rhs.id
        }
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
       // formatter.dateFormat = "DD/MM/YYYY"
        return formatter
    }()
    
//“You can use the FileManager class to locate your app's Documents directory, create a subfolder for archiving data, and store that path to a constant.
    
    static let documentsDirectory =
       FileManager.default.urls(for: .documentDirectory,
       in: .userDomainMask).first!
    static let archiveURL =
       documentsDirectory.appendingPathComponent("todos")
       .appendingPathExtension("plist")
    

    static func loadToDos() -> [ToDo]?  {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else
           {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,
           from: codedToDos)
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
}
