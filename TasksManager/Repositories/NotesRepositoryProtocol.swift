//
//  NotesRepositoryProtocol.swift
//  TasksManager
//
//  Created by Yushkevich Ilya on 28.04.22.
//

protocol NotesRepositoryProtocol {
  func saveNote(_ note: NoteInfo)
  func getNotes() -> [NoteInfo]?
  func deleteNote(title: String)
}
