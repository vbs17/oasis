

import UIKit

class KindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let a: NSArray = [ "赤犬",
        "あがた森魚",
        "浅井健一",
        "安室奈美恵",
        "あぶらだこ",
        "阿部真央",
        "あゆみくりかまき",
        "AA=",
        "ACIDMAN",
        "A Hundred Birds",
        "AI",
        "AK-69",
        "Aldious",
        "THE ALFEE",
        "Alexandros",
        "andymori",
        "androp",
        "ARIA ASIA",
        "ASIAN KUNG-FU GENERATION",
        "ASPARAGUS",
        "ASA-CHANG&巡礼",
        "audio active",
        "avengers in sci-fi",
        "Azami"
]
    let b: NSArray = ["ボアダムス",
        "Base Ball Bear",
        "back number",
        "THE BAWDIES",
        "BACK DROP BOMB",
        "BABYMETAL",
        "THE BACK HORN",
        "DJ BAKU",
        "the band apart",
        "BEAT CRUSADERS",
        "BEGIN",
        "The Birthday",
        "BIGMAMA",
        "THA BLUE HERB",
        "THE BLUE HEARTS",
        "bloodthirsty butchers",
        "BLANKEY JET CITY",
        "BLUE ENCOUNT",
        "BOØWY",
        "BOOM BOOM SATELLITES",
        "BRAHMAN",
        "BUCK-TICK",
        "BUMP OF CHICKEN",
        "Buffalo Daughter",
        "BUZZ THE BEARS",
        "B'z"
]
    let c: NSArray = []
    let d: NSArray = []
    let e: NSArray = []
    let f: NSArray = []
    let g: NSArray = []
    let h: NSArray = []
    let i: NSArray = []
    let j: NSArray = []
    let k: NSArray = []
    let l: NSArray = []
    let m: NSArray = []
    let n: NSArray = []
    let o: NSArray = []
    let p: NSArray = []
    let q: NSArray = []
    let r: NSArray = []
    let s: NSArray = []
    let t: NSArray = []
    let u: NSArray = []
    let v: NSArray = []
    let w: NSArray = []
    let x: NSArray = []
    let y: NSArray = []
    let z: NSArray = []
   
    private let mySections: NSArray = ["A", "B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status Barの高さを取得を.する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成( status barの高さ分ずらして表示 ).
        let myTableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
     //セクションの数を返す.
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mySections.count
    }
    

     //セクションのタイトルを返す.
 
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
  
     //Cellが選択された際に呼び出される.
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            print("Value: \(a[indexPath.row])")
        } else if indexPath.section == 1 {
            print("Value: \(b[indexPath.row])")
        }
    }
    
  
     //テーブルに表示する配列の総数を返す.
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return a.count
        } else if section == 1 {
            return b.count
        } else {
            return 0
        }
    }
    
    
    // Cellに値を設定する
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(a[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(b[indexPath.row])"
        }
        
        return cell
    }
    
}