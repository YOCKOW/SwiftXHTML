/* *************************************************************************************************
 Relationship.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

public typealias LinkType = Relationship

/// The attribute's value of "rel".
/// See https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types
public enum Relationship: String {
  case alternate
  case archives
  case author
  case bookmark
  case canonical
  case dnsPrefetch = "dns-prefetch"
  case external
  case first
  case help
  case icon
  case `import`
  case index
  case last
  case license
  case manifest
  case modulePreload = "modulepreload"
  case next
  case noFollow = "nofollow"
  case noOpener = "noopener"
  case noReferrer = "noreferrer"
  case opener
  case pingback
  case preconnect
  case prefetch
  case preload
  case prev
  case search
  case shortLink = "shortlink"
  case sidebar
  case styleSheet = "stylesheet"
  case tag
  case up
}
 
