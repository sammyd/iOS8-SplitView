//
//  Data.swift
//  MultiLevelSplit
//
// Copyright 2015 Sam Davies
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

/* Generic-level objects */

public final class Box<T> {
  public let unbox: T
  public init(_ value: T) { self.unbox = value }
}

enum Hierarchy<T: Printable> {
  case Leaf(Box<T>)
  case Node(String, [Hierarchy<T>])
}

extension Hierarchy: Printable {
  var description: String {
    switch self {
    case let .Leaf(val):
      return val.unbox.description
    case let .Node(name, _):
      return name
    }
  }
}

extension Hierarchy: DebugPrintable {
  var debugDescription: String {
    switch self {
    case let .Leaf(val):
      return val.unbox.description
    case let .Node(name, children):
      return "\(name) => \(children)"
    }
  }
}

extension Hierarchy {
  static func createFromDict(leafFromDict: NSDictionary -> T)(dict: NSDictionary) -> Hierarchy<T> {
    if let values = dict["values"] as? [NSDictionary],
      let name = dict["name"] as? String {
        return .Node(name, values.map(createFromDict(leafFromDict)))
    } else {
      return .Leaf(Box(leafFromDict(dict)))
    }
  }
  
  static func createFromPlist(leafFromDict: NSDictionary -> T)(plistName: String) -> Hierarchy<T>? {
    let plistPath = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist")
    if NSFileManager.defaultManager().fileExistsAtPath(plistPath!) {
      if let rawData = NSDictionary(contentsOfFile: plistPath!) {
        return createFromDict(leafFromDict)(dict: rawData)
      }
    }
    return .None
  }
}


/* Model specific objects */
struct Student {
  let name: String
  let grade: String
  
  init(name: String, grade: String) {
    self.name = name
    self.grade = grade
  }
}

extension Student: Printable {
  var description: String {
    return name
  }
}

extension Student: DebugPrintable {
  var debugDescription: String {
    return "\(name): \(grade)"
  }
}

extension Student {
  init?(dict: NSDictionary) {
    if let name = dict["Name"] as? String,
      let grade = dict["Grade"] as? String {
        self.grade = grade
        self.name = name
    } else {
      return nil
    }
  }
  
  static func create(dict: NSDictionary) -> Student {
    return Student(dict: dict)!
  }
}


func loadStudentDataModel() -> Hierarchy<Student>? {
  return Hierarchy.createFromPlist(Student.create)(plistName: "HierarchicalData")
}
