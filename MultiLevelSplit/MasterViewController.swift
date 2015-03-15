//
//  MasterViewController.swift
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

import UIKit

class MasterViewController: UITableViewController {

  var children: [Hierarchy<Student>]!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  // MARK: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail",
      let detailContainer = segue.destinationViewController as? UINavigationController,
      let detailVC = detailContainer.topViewController as? DetailViewController {
      let selectedIndexPath = tableView.indexPathForSelectedRow()!
      switch children[selectedIndexPath.row] {
      case let .Leaf(leaf):
        detailVC.student = leaf.unbox
      case .Node:
        break
      }
    }
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
    let selectedIndexPath = tableView.indexPathForSelectedRow()!
    switch children[selectedIndexPath.row] {
    case .Leaf:
      return true
    case .Node:
      return false
    }
  }

  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return children.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

    let child = children[indexPath.row]
    cell.textLabel?.text = child.description
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    switch children[indexPath.row] {
    case let .Node(name, kids):
      let newVC = storyboard?.instantiateViewControllerWithIdentifier("MasterVC") as! MasterViewController
      newVC.children = kids
      newVC.title = name
      showViewController(newVC, sender: self)
    default:
      break
    }
  }
}

