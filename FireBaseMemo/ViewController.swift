//
//  ViewController.swift
//  FireBaseMemo
//
//  Created by SO YOUNG on 2018. 1. 13..
//  Copyright © 2018년 SO YOUNG. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var memoTableView: UITableView!
    
    var ref: DatabaseReference!
    
    var memoArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        memoTableView.dataSource = self
        ref = Database.database().reference()
        
        //저장
//        ref.child("soyoung").setValue(["라멘", "해장국", "햄버거"])
        
//        ref.child("test").setValue([1, 2, 3])
        
        //서버에 있는 메모 로드
        loadMemo()
        
        //가져오기
        ref.child("test").observe(.value) { (snapshot) in
            for item in snapshot.children {
                let snapshotItem = item as! DataSnapshot
                print(snapshotItem.value)
            }
        }
        
        
    }
    
    func loadMemo() {
        //가져오기
        ref.child("soyoung").observe(.value) { (snapshot) in
            //            for item in snapshot.children {
            //                let snapshotItem = item as! DataSnapshot
            //                print(snapshotItem.value)
            //            }
            self.memoArray = snapshot.value as! [String]
            self.memoTableView.reloadData()
        }
    }
    
    func addMemo(memoString: String){
        memoArray.append(memoString)
        ref.child("soyoung").setValue(memoArray)
    }
    @IBAction func addClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "추가", message: "정보 추가", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            self.addMemo(memoString: alert.textFields![0].text!)
        }))
        
        alert.addTextField { (textField) in
            textField.placeholder = "메모를 입력하시오"
        }
        
        present(alert, animated: true, completion: nil)
    }
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        cell.textLabel?.text = memoArray[indexPath
        .row]
        return cell
    }
    


}

