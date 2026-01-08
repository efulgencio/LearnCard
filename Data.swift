import Foundation
import SwiftData

struct StudySetDTO: Codable, Sendable {
    let titulo: String
    let preguntas: [FlashcardDTO]
}

struct FlashcardDTO: Codable, Sendable {
    let q: String
    let a: String
}

@Model
class StudySet {
    var titulo: String
    @Relationship(deleteRule: .cascade) var tarjetas: [Flashcard]
    
    init(titulo: String, tarjetas: [Flashcard] = []) {
        self.titulo = titulo
        self.tarjetas = tarjetas
    }
}

@Model
class Flashcard {
    var q: String
    var a: String
    
    init(q: String, a: String) {
        self.q = q
        self.a = a
    }
}
