//
//  ClassOpenExample.swift
//  SeSACFramework
//
//  Created by 황예리 on 2023/08/30.
//

import Foundation

open class ClassOpenExample {
    
    private static func privateExample() {
        print(#function)
    }
    
    fileprivate static func fileprivateExample() {
        print(#function)
    }
    
    internal static func internalExample() {
        print(#function)
    }
    
    public static func publicExample() {
        print(#function)
    }
    
    
}

public class ClassPublicExample {
    
    private static func privateExample() {
        print(#function)
    }
    
    fileprivate static func fileprivateExample() {
        print(#function)
    }
    
    internal static func internalExample() {
        print(#function)
    }
    
    public static func publicExample() {
        print(#function)
    }
    
    
}

class ClassInternalExample { // Internal : default 보호정도
    
    private static func privateExample() {
        print(#function)
    }
    
    fileprivate static func fileprivateExample() {
        print(#function)
    }
    
    internal static func internalExample() {
        print(#function)
    }
    
    public static func publicExample() {
        print(#function)
    }
    
    
} //internal 생략되어 있어서 internal이 디폴트임.

