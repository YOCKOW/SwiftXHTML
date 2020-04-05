/* *************************************************************************************************
 StringComposition+XHTML.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import StringComposition

extension StringLines {
  internal func _description(indent: String.Indent, newline: Character.Newline) -> String {
    var lines = self
    lines.indent = indent
    lines.newline = newline
    return lines.description
  }
}
