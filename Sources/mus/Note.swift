//
//  Note.swift
//  mus
//
//  Created by mazen baddad on 3/24/21.
//

import Foundation

struct Note {
    
    var name : String
    var secondName : String?
    
    static let allNotes : Array<Note> = {
        return [Note(name:"A"),
                Note(name: "A#", secondName: "Bb") ,
                Note(name: "B", secondName: "Cb") ,
                Note(name: "C", secondName: "B#") ,
                Note(name: "C#", secondName: "Db") ,
                Note(name: "D") ,
                Note(name: "D#", secondName: "Eb"),
                Note(name: "E", secondName: "Fb") ,
                Note(name: "F" , secondName: "E#") ,
                Note(name: "F#", secondName: "Gb"),
                Note(name: "G"),
                Note(name: "G#", secondName: "Ab")]
    }()
    
    init(name : String , secondName : String? = nil) {
        self.name = name
        self.secondName = secondName
    }
    
    static func sortedNotes(for key : String) -> Array<String> {
        var formatedKey: String
        if key.count == 2 {
            formatedKey =  "\(key.first!.uppercased())\(key.last!.lowercased())"
        }else {
            formatedKey = key.uppercased()
        }
        let index : Int = Note.allNotes.firstIndex{$0 == formatedKey}!
       var notes = Note.allNotes
       for _ in 0..<index {
           let elemet = notes.removeFirst()
           notes.append(elemet)
       }
       return notes.map{$0.name}
   }
    
    static func isValidNote(_ note : String) -> Bool {
        let absNotes : Array<String> = ["A","B","C","D","E","F","G"]
        if note.count == 1 {
            return absNotes.contains(note.uppercased())
        }else if note.count == 2 {
            let signatures : Array<String> = ["#" , "b"]
            return absNotes.contains(note.first!.uppercased()) && signatures.contains(String(note.last!))
        }
        return false
    }
    
    static func == (arg1 : Note , arg2 : String) -> Bool {
        return arg1.name == arg2 || arg1.secondName == arg2
    }
    
}
