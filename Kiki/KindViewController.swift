

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
    let c: NSArray = ["cero",
        "CHEMISTRY",
        "CHAGE&ASKA",
        "THE CHECKERS",
        "CHARA",
        "chay",
        "Char",
        "CINEMA dub MONKS",
        "THE CORNELIUS GROUP",
        "coldrain",
        "CORNELIUS",
        "Crossfaith"]
    let d: NSArray = ["怒髪天",
        "電気グルーヴ",
        "電撃ネットワーク",
        "でんぱ組.inc",
        "Def Tech",
        "DEEN",
        "DE DE MOUSE",
        "Dizzy Sunfist",
        "DMBQ",
        "Downy",
        "DOPING PANDA",
        "DOBERMAN",
        "DREAMS COME TRUE",
        "Dragon Ash",
        "DRY&HEAVY",
        "dustbox",
        "DUBSENSEMANIA"]
    let e: NSArray = ["エレファントカシマシ",
        "eastern youth",
        "ELLEGARDEN",
        "envy",
        "EGO-WRAPPIN",
        "EYE"]
    let f: NSArray = ["Fantastic Plastic Machine",
        "FACT",
        "FAKY",
        "Fear, and Loathing in Las Vegas",
        "FIRE BALL",
        "flumpool",
        "Flower Travellin' Band",
        "FRONT LINE",
        "FRONTIER BACKYARD",
        "FUNKY MONKEY BABYS"]
    let g: NSArray = ["ギターウルフ",
        "グッドモーニングアメリカ",
        "グループ魂",
        "ゲスの極み乙女。",
        "ゴスペラーズ",
        "ゴールデンボンバー",
        "郷ひろみ",
        "ゴンチチ",
        "GACKT",
        "GARLIC BOYS",
        "the GazettE",
        "GANGA ZUMBA",
        "GARDEN",
        "GLAY",
        "GLIM SPANKY",
        "THE GOLDEN WET FINGERS",
        "GO!GO!7188",
        "GReeeeN",
        "GRAPEVINE"]
    let h: NSArray = ["ハナレグミ",
        "ハスキング・ビー",
        "浜田省吾",
        "浜田麻里",
        "原田郁子",
        "畠山美由紀",
        "ハジ",
        "早川義夫",
        "ヒートウェイヴ",
        "髭（HiGE）",
        "ヒカシュー",
        "平井堅",
        "氷室京介",
        "フレデリック",
        "フジファブリック",
        "風味堂",
        "藤原基央",
        "福山雅治",
        "フィッシュマンズ",
        "フリクション",
        "フラワーカンパニーズ",
        "ホフディラン",
        "布袋寅泰",
        "細野晴臣",
        "星野源",
        "Hawaiian6",
        "HARUHI",
        "hilcrhyme",
        "THE HIGH-LOWS",
        "HIM",
        "HIROMI THE TRIO PROJECT",
        "HIFANA",
        "the HIATUS",
        "Hi-STANDARD",
        "HUSKING BEE",
        "HY",
        "HYDE"]
    let i: NSArray = ["イエロー・マジック・オーケストラ",
        "いきものがかり",
        "忌野清志郎",
        "井上陽水",
        "石野卓球",
        "伊藤ふみお",
        "稲葉浩志",
        "iLL ",
        "illion",
        "indigo la end"]
    let j: NSArray = ["JUDY AND MARY",
        "JUDE",
        "JUN SKY WALKER(S)",
]
    let k: NSArray = ["加藤登紀子",
        "勝手にしやがれ",
        "かりゆし58",
        "完熟トリオ",
        "加藤ミリヤ",
        "川本真琴",
        "カジヒデキ",
        "氣志團",
        "キセル",
        "きゃりーぱみゅぱみゅ",
        "キュウソネコカミ",
        "キートーク",
        "清木場俊介",
        "筋肉少女帯",
        "木村カエラ",
        "ザ・キング・トーンズ",
        "くるり",
        "桑田佳祐",
        "クラムボン",
        "クレイジーケンバンド",
        "クリープハイプ",
        "クチロロ",
        "ケツメイシ",
        "ケン・イシイ",
        "毛皮のマリーズ",
        "コブクロ",
        "小泉今日子",
        "近藤房之助",
        "小島",
        "コトリンゴ",
        "KANA-BOON",
        "Kemuri",
        "KEYTALK",
        "KEN YOKOYAMA",
        "Dj KENTARO",
        "KIMONOS",
        "KNOCK OUT MONKEY",
        "KREVA　",
        "DJ KRUSH",
        "Kylee"
]
    let l: NSArray = ["L'Arc~en~Ciel",
        "lecca",
        "LiSA",
        "LITTLE TEMPO",
        "LITTLE CREATURES",
        "LILI LIMIT",
        "LOVE PSYCHEDELICO",
        "LOW IQ 01",
        "LOSALIOS",
        "LOVE JETS"]
    let m: NSArray = ["槇原敬之",
        "真心ブラザーズ",
        "マキシマムザホルモン",
        "三浦大知",
        "ミドリ",
        "ミラーズ",
        "雅-MIYAVI-",
        "ムーンライダーズ",
        "元ちとせ",
        "森山直太朗",
        "ももいろクローバーZ",
        "森高千里",
        "MAN WITH A MISSION",
        "THE MAD CAPSULE MARKETS",
        "MEG",
        "m-flo",
        "MiChi",
        "Missile Girl Scoot",
        "miwa",
        "Michael Kaneko",
        "MONGOL800",
        "MO'SOME TONEBENDER",
        "MONORAL",
        "MONO",
        "MONOEYES",
        "THE MODS",
        "MONKEY MAJIK",
        "Mr.Children",
        "MUDDY APES",
        "MURO"
]
    let n: NSArray = ["ナオト・インティライミ",
        "長渕剛",
        "中田ヤスタカ",
        "中山うり",
        "夏木マリ",
        "七尾旅人",
        "ナンバーガール",
        "西川貴教",
        "ねごと",
       " NICO Touches the Walls",
        "NITRO MICROPHONE UNDERGROUND"]
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