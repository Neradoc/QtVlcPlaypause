//
//  ViewController.swift
//  QtVlcPlaypause
//
//  Created by Toussaint Guglielmi on 22/01/2016.
//  Copyright © 2016 Spyroland. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var backPlus: NSButton!
	@IBOutlet weak var backMoins: NSButton!
	@IBOutlet weak var playPause: NSButton!
	@IBOutlet weak var forwardMoins: NSButton!
	@IBOutlet weak var forwardPlus: NSButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func pressButton(sender: AnyObject) {
		switch sender as! NSButton {
		case backPlus:
			callAppleScriptFile("script_back_plus.scpt")
		case backMoins:
			callAppleScriptFile("script_back_moins.scpt")
		case playPause:
			callAppleScriptFile("script_playpause.scpt")
		case forwardMoins:
			callAppleScriptFile("script_forward_moins.scpt")
		case forwardPlus:
			callAppleScriptFile("script_forward_plus.scpt")
		default:
			break
		}
	}

	func callAppleScriptFile(script_name:String) {
		let bundle = NSBundle.mainBundle()
		guard let script_path = bundle.pathForResource(script_name, ofType: "", inDirectory: "applescript") else {
			return
		}
		let url = NSURL.fileURLWithPath(script_path, isDirectory:false)
		var error: NSDictionary?
		let xerror = AutoreleasingUnsafeMutablePointer<NSDictionary?>()
		if let scriptObject = NSAppleScript(contentsOfURL: url, error: xerror) {
			if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
					print(output.stringValue)
			} else if error != nil {
				print("error: \(error)")
			}
		}
	}
	func callAppleScriptString(myAppleScript:String) {
		var error: NSDictionary?
		if let scriptObject = NSAppleScript(source: myAppleScript) {
			if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
					print(output.stringValue)
			} else if (error != nil) {
				print("error: \(error)")
			}
		}
	}
}

