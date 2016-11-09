

import UIKit
import Firebase
import FirebaseDatabase
import AVFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let ApplicationDidEnterBackgroundNotification = "ApplicationDidEnterBackgroundNotification"
    
    
    func applicationDidEnterBackground(application: UIApplication) {
        let ns = NSNotificationCenter.defaultCenter()
        ns.postNotificationName(ApplicationDidEnterBackgroundNotification, object: nil)
    }
    
    


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        let postPathRef = FIRDatabase.database().referenceWithPath(CommonConst.PostPATH)
        postPathRef.keepSynced(true)
        let postPath2Ref = FIRDatabase.database().referenceWithPath(CommonConst.PostPATH2)
        postPath2Ref.keepSynced(true)
        let ProfileRef = FIRDatabase.database().referenceWithPath(CommonConst.Profile)
        ProfileRef.keepSynced(true)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
       
    }

    
    

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
       
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

