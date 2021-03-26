//
//  Scale.swift
//  mus
//
//  Created by mazen baddad on 3/24/21.
//

import ArgumentParser

extension Mus {
    
    struct Scale : ParsableCommand{
        static let configuration = CommandConfiguration(
            abstract: "Scales information" , subcommands: [Chord.self])
        
        
        @Argument()
        var key : String
        
        @Option(name : .short,help:"Scale kind")
        var kind : String = "major"
        
         
        @Flag()
        var chords : Bool = false
        
//        static var chordsIntervals : Dictionary<String,Array<Int>> = [
//            "major": [0,4,7], // 1 5 8 , 2 6 9 , 3 7 10 , 4 8 11 , 5 9 0 , 6 10 1 , 7 11 2 , 8 0 3 
//            "minor": [0,3,7],
//            "sus2":[0,2,7],
//            "sus4":[0,5,7],
//            "dim":[0,3,6],
//            "maj7":[0,4,7,11],
//            "seventh":[0,4,7,10],
//            "m7":[0,3,7,10],
//            "mmaj7":[0,3,7,11],
//            "m7b5":[0,3,6,10]
//        ]
        
        static var scaleIntervals : Dictionary<String,Array<Int>> = ["chromatic":[0,1,2,3,4,5,6,7,8,9,10,11],
                                                                   "major" : [0,2,4,5,7,9,11],
                                                                   "minor" : [0,2,3,5,7,8,10]]
        
        func validate() throws {
            if !Note.isValidNote(key) {
                throw ValidationError("\(key) is not a valid note , user b for flat and # for sharp.")
            }
            if !Scale.scaleIntervals.keys.contains(kind) {
                throw ValidationError("\(kind) scale is unknow or not supported")
            }
        }
        
        func run() throws {
            if chords {
                print("""
                    Chord within the scale \(key) \(kind) : \n \(allChordsInScale())
                """)
            }else {
                print("Scale \(key) \(kind) : \(scaleNotes())")
            }

        }
        
        func scaleNotes() -> Array<String> {
            let scaleIntervals = Scale.scaleIntervals[kind]
            let sortedNotes = Note.sortedNotes(for: key)
            var notes : Array<String> = []
            for index in scaleIntervals! {
                notes.append( sortedNotes[index] )
            }
            return notes
        }
        
        func allChordsInScale() -> Array<String> {
            let chordsIntervals = Chord.chordsIntervals
            let chordKinds = chordsIntervals.keys
            var chords : Array<String> = []
            let scaleNotes = self.scaleNotes()
            
            for note in scaleNotes {
                for chordKind in chordKinds {
                    let intervals = chordsIntervals[chordKind]!
                    let sortedChromaticNotes = Note.sortedNotes(for: note)
                    let chord = intervals.map{ sortedChromaticNotes[$0] }
                    if scaleNotes.contains(chord) {
                        chords.append("\(note) \(chordKind)")
                    }
                }
            }
            return chords
        }
        
    }
    
}


extension Array where Element: Hashable {
    
    func contains(_ elements : Array<Element>) -> Bool {
        for element in elements {
            if !self.contains(element) {
                return false
            }
        }
        return true
    }
}
