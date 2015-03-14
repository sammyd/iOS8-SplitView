//
//  AppDelegate.swift
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

  var window: UIWindow?
  let studentData = loadStudentDataModel()


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    // Override point for customization after application launch.
    let splitViewController = self.window!.rootViewController as! UISplitViewController
    let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    
    
    // Faff around to get hold of the master VC
    let masterContainer = splitViewController.viewControllers.first! as! UINavigationController
    if let masterVC = masterContainer.topViewController as? MasterViewController {
      switch studentData! {
      case let .Node(name, children):
        masterVC.children = children
        masterVC.title = name
      default:
        println("error")
      }
    }

    return true
  }

}

