//
//  main.swift
//  Crawl
//
//  Created by Kelbin David on 2022-03-03.
//

import Foundation

let fileManager = FileManager.default
let home = FileManager.default.currentDirectoryPath
crawl(URL(fileURLWithPath: home),indent: "")

func crawl(_ url: URL,indent: String){
  let dir = try? fileManager.contentsOfDirectory(at: URL(fileURLWithPath: url.path), includingPropertiesForKeys: [], options: .skipsHiddenFiles)
  guard dir != nil else { return }
  for (idx, url) in dir!.enumerated() {
      var isDir = ObjCBool(false)
      let isExists = fileManager.fileExists(atPath: url.path, isDirectory: &isDir)
    let branchLine = idx == dir!.endIndex - 1 ? "└─" : "├─"
    let isConnected = idx == dir!.endIndex - 1 ? "  " : " │"
      if isExists && isDir.boolValue {
        print(indent, branchLine, fileManager.displayName(atPath: url.path))
        crawl(url, indent: indent + isConnected + "  ")
      } else {
        print(indent, branchLine, fileManager.displayName(atPath: url.path))
        crawl(url, indent: indent + "  ")
      }
  }
}


