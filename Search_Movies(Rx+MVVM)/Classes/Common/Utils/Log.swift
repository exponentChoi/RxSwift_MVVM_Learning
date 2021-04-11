//
//  Log.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

/**
 Literal Expression
 #file: String - 표시되는 파일 및 모듈의 이름
 #filePath: String - 표시되는 파일의 경로
 #line: Int - 표시되는 줄번호
 #column: Int - 시작하는 열 번호
 #function: String - 함수의 이름
 #dsohandle: UnsafeRawPointer - DSO(동적 공유 객체) 핸들이 나타나는 곳에서 사용 중
 */
import Foundation

class Log {
    // Debug Log
    static func d(_ message: Any?, file: String = #file, function: String = #function, line: Int = #line) {
        
        #if DEBUG
        let threadName = Thread.isMainThread ? "Main": Thread.current.name ?? "-"
        let fileName = file.components(separatedBy: "/").last ?? "-"
        
        guard let message = message else {
            return
        }
        
        print("LOG DEBUG [\(Date())] - [\(threadName) Thread] - [\(fileName) - Line \(line) - \(function)] :: \(message)")
        #endif
    }
    
    static func parameters(_ items: [String: Any]) {
        #if DEBUG
        
        print("LOG DEBUG *** parameters ***")
        items.forEach { print($0.key + ": \($0.value)") }
        print("****************************")
        #endif
    }
}
