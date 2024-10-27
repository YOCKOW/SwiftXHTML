/* *************************************************************************************************
 TestResources.swift
   © 2019,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Dispatch
import Foundation

/// Data provider for tests.
public final class TestResources: @unchecked Sendable {
  private init() {}
  public static let shared:TestResources = .init()
  
  private let _resourcesDirectory:URL =
    URL(fileURLWithPath: #filePath).deletingLastPathComponent().appendingPathComponent("Resources")

  private var _fileHandles:[String:FileHandle] = [:]
  
  deinit {
    for fileHandle in self._fileHandles.values {
      fileHandle.closeFile()
    }
  }
  
  private func _absolutePath(for relativePath:String) -> URL {
    return _resourcesDirectory.appendingPathComponent(relativePath)
  }

  private let _fileHandlesQueue: DispatchQueue = .init(
    label:"jp.YOCKOW.XHTML.TestResources.fileHandlesQueue",
    attributes: .concurrent
  )
  public func fileHandle(at relativePath:String) -> FileHandle? {
    return _fileHandlesQueue.sync(flags: .barrier) {
      if self._fileHandles[relativePath] == nil {
        let absPath = self._absolutePath(for:relativePath)
        self._fileHandles[relativePath] = try? FileHandle(forReadingFrom: absPath)
      }
      return self._fileHandles[relativePath]
    }
  }
  
  public func data(for relativePath:String) -> Data? {
    guard let fh = self.fileHandle(at:relativePath) else { return nil }
    fh.seek(toFileOffset:0)
    return fh.availableData
  }
}
