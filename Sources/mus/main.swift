import ArgumentParser

struct Mus : ParsableCommand {
    
    static let configuration = CommandConfiguration(
            abstract: "A Swift command-line tool to manage blog post banners",
        subcommands: [Scale.self,Chord.self])
}

Mus.main()
