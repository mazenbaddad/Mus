//
//  Chord.swift
//  mus
//
//  Created by mazen baddad on 3/24/21.
//

import ArgumentParser

extension Mus {
    
    struct Chord : ParsableCommand {
        static let configuration = CommandConfiguration(
                abstract: "Chord information")
        
        @Option()
        var kind : String
        
        @Argument()
        var key : String
        
        static var chordsIntervals : Dictionary<String,Array<Int>> = [
            "major": [0,4,7],
            "minor": [0,3,7],
            "sus2":[0,2,7],
            "sus4":[0,5,7],
            "dim":[0,3,6],
            "maj7":[0,4,7,11],
            "seventh":[0,4,7,10],
            "m7":[0,3,7,10],
            "mmaj7":[0,3,7,11],
            "m7b5":[0,3,6,10]
        ]
        
        private var upKey:String {
            if key.count == 2 {
                return "\(key.first!.uppercased())\(key.last!.lowercased())"
            }
            return key.uppercased()
        }
        
        func validate() throws {
            if !Note.isValidNote(key) {
                throw ValidationError("\(key) is not a valid note , user b for flat and # for sharp.")
            }
        }
        
        func run() throws {
            if let indices = Chord.chordsIntervals[kind] {
                let notes = Note.sortedNotes(for: key)
                var chords : Array<String> = []
                
                for i in indices{
                    let note = notes[i]
                    chords.append(note)
                }
                print(chords)
            }else {
                print("\(kind) is not supported chord , Supported chords \(Chord.chordsIntervals.keys)")
            }
            
        }
        
    }
}
