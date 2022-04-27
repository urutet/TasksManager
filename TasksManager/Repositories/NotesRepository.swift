//
//  NotesRepository.swift
//  TasksManager
//
//  Created by Yushkevich Ilya on 27.04.22.
//

import Foundation
import CoreData

final class NotesRepository {
  private enum Constants {
    static let entityName = "NoteMO"
    static let titlePredicate = "title == %@"
    static let containerName = "NoteModel"
  }
  
  static let instance = NotesRepository()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: Constants.containerName)
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  private init() { }
  
  private func convertToNoteMO(note: NoteInfo, context: NSManagedObjectContext) -> NoteMO {
    let noteMO = NoteMO(context: context)
    
    noteMO.title = note.title
    noteMO.content = note.content
    
    return noteMO
  }
  
  private func convertToNote(noteMO: NoteMO) -> NoteInfo? {
    guard
      let title = noteMO.title,
      let content = noteMO.content
    else { return nil }
    return NoteInfo(title: title, content: content)
  }
  
  func saveNote(_ note: NoteInfo) {
    let managedContext = persistentContainer.viewContext
    
    let managedMovie = convertToNoteMO(note: note, context: managedContext)
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
  
  func getNotes() -> [NoteInfo]? {
    let managedContext = persistentContainer.viewContext
    
    let fetchRequest = NoteMO.fetchRequest()
    
    do {
      let moviesMO = try managedContext.fetch(fetchRequest)
      let movies = moviesMO.compactMap{ convertToNote(noteMO: $0) }
      return movies
    } catch let error as NSError {
      print("Error - \(error)")
    }
    return nil
  }
  
  func deleteNote(title: String) {
    let managedContext = persistentContainer.viewContext
    
    let fetchRequest = NoteMO.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: Constants.titlePredicate, title)
    
    do {
      let objects = try managedContext.fetch(fetchRequest)
      for object in objects {
        managedContext.delete(object)
      }
      try managedContext.save()
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
}
