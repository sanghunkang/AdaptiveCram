//
//  AppDelegate.swift
//  AdaptiveCram
//
//  Created by Sanghun Kang on 25/08/2019.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //appdelegate에 데이터를 저장하는 이유 : 뷰 컨트롤러는 생명주기가 짧기 때문에 화면을 전환할 때 이전 화면의 뷰 컨트롤러는 메모리에서 소멸한다. 그렇기 때문에 뷰 컨트롤러의 커스텀 클래스에는 데이터를 저장하는 것은 적합하지 않다. 앱델리게이트 클래스는 전역변수를 저장하기에 적합하다. 이 클래스는 앱 내에서 하나만 존재하고 어디서든 쉽게 접근할 수 있기 때문이다. 앱 자체의 생명주기와 운명을 함께하기 때문에 중간에 소멸되지 않는다. 묭 읽으면 요약으로 줄이셈
    //var CramQuestionList = [CramQuestionData]() //문제 데이터를 저장할 배열

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

