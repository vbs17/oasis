

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth



class KindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, KindTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    
    
   let AllItems: [[String]]  = [[ "赤犬",
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
        "Azami"],
    ["ボアダムス",
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
],
     ["cero",
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
        "Crossfaith"],
    ["怒髪天",
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
        "DUBSENSEMANIA"],
     ["エレファントカシマシ",
        "eastern youth",
        "ELLEGARDEN",
        "envy",
        "EGO-WRAPPIN",
        "EYE"],
   ["Fantastic Plastic Machine",
        "FACT",
        "FAKY",
        "Fear, and Loathing in Las Vegas",
        "FIRE BALL",
        "flumpool",
        "Flower Travellin' Band",
        "FRONT LINE",
        "FRONTIER BACKYARD",
        "FUNKY MONKEY BABYS"],
     ["ギターウルフ",
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
        "GRAPEVINE"],
     ["ハナレグミ",
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
        "HYDE"],
    ["いきものがかり",
        "忌野清志郎",
        "井上陽水",
        "石野卓球",
        "伊藤ふみお",
        "稲葉浩志",
        "iLL ",
        "illion",
        "indigo la end"],
    ["JUDY AND MARY",
        "JUDE",
        "JUN SKY WALKER(S)",
],
     ["加藤登紀子",
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
],
    ["L'Arc~en~Ciel",
        "lecca",
        "LiSA",
        "LITTLE TEMPO",
        "LITTLE CREATURES",
        "LILI LIMIT",
        "LOVE PSYCHEDELICO",
        "LOW IQ 01",
        "LOSALIOS",
        "LOVE JETS"],
    ["槇原敬之",
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
],
     ["ナオト・インティライミ",
        "長渕剛",
        "中田ヤスタカ",
        "中山うり",
        "夏木マリ",
        "七尾旅人",
        "ナンバーガール",
        "西川貴教",
        "ねごと",
       " NICO Touches the Walls",
        "NITRO MICROPHONE UNDERGROUND"],
     ["大沢伸一",
        "大橋トリオ",
        "大森靖子",
        "大江慎也",
        "岡崎体育",
        "岡林信康",
        "岡村靖幸",
        "奥田民生",
        "尾崎豊",
        "押尾コータロー",
        "小田和正",
        "小野リサ",
        "オフコース",
        "オルケスタ・デ・ラ・ルス",
        "OKAMOTO'S",
        "oh sunshine",
        "ONE☆DRAFT",
        "ONE OK ROCK",
        "OOIOO",
        "THE ORAL CIGARETTES",
        "ORANGE RANGE",
        "OVERGROUND ACOUSTIC UNDERGROUND",
        "OZROSAURUS"
],
["プリンセス・プリンセス",
        "ポルノグラフィティ",
        "プレイモ",
        "Pay money To my Pain",
        "PE'Z",
        "Perfume",
        "PEALOUT",
        "the pillows",
        "POLYSICS",
        "PONTIACS",
        "PUFFY"
],
     ["羅針盤",
        "凛として時雨",
        "ルースターズ",
        "レイ・ハラカミ",
        "レミオロメン",
        "RADWIMPS",
        "RHYMESTER",
        "RIRI",
        "RIZE",
        "RIP SLYME",
        "ROVO",
        "ROSSO",
        "RYUKYUDISKO"
],
    ["サカナクション",
        "斉藤和義",
        "サザンオールスターズ",
        "サイケアウツ",
        "桜井和寿",
        "サンハウス",
        "サンディー",
        "サニーデイ・サービス",
        "椎名林檎",
        "清水翔太",
        "シーナ&ロケッツ",
        "渋さ知らズ",
        "シド",
        "シャ乱Q",
        "少年ナイフ",
        "湘南乃風",
        "スキマスイッチ",
        "スカフレイムス",
        "スガシカオ",
        "スピッツ",
        "スカフレイムス",
        "水曜日のカンパネラ",
        "スチャダラパー",
        "砂原良徳",
        "ステレオポニー",
        "セツナブルースター",
        "ソウル・フラワー・ユニオン",
        "曽我部恵一",
        "ソナーポケット",
        "相対性理論",
        "SALTY DOG",
        "SANABAGUN.",
        "SAKEROCK",
        "SCANDAL",
        "SEKAI NO OWARI",
        "SHERBETS",
        "SHISHAMO",
        "Shing02",
        "SKA SKA CLUB",
        "SNAIL RAMP",
        "SION",
        "The Sketchbook",
        "SOIL& PIMP SESSIONS",
        "Spangle call lilli line",
        "SpecialThanks",
        "SPECIAL OTHERS",
        "SQUARE",
        "Suchmos",
        "SUPER BUTTER DOG",
        "SUGIURUMN",
        "SUPERCAR",
        "Superfly",
        "Sunrise In My Attache Case",
        "Super Junky Monkey",
        "SWANKY DANK"
],
     ["高田漣",
        "高橋優",
        "高橋幸宏",
        "田中フミヤ",
        "谷村奈南",
        "玉置浩二",
        "チャットモンチー",
        "つじあやの",
        "つんく♂",
        "土屋アンナ",
        "テイ・トウワ",
        "トクマルシューゴ",
        "トータス松本",
        "豊田勇造",
        "東京スカパラダイスオーケストラ",
        "東京事変",
        "東京カランコロン",
        "徳永英明",
        "TERIYAKI BOYZ",
        "the telephones",
        "thee michelle gun elephant",
        "TMG",
        "T.M.Revolution",
        "TOKYO No.1 SOUL SET",
        "Tommy heavenly6",
        "toe",
        "TOTALFAT",
        "TRICERATOPS",
        "TUXEDO",
        "TUBE",
        "TWIGY"],
   ["上原ひろみ",
        "宇多田ヒカル",
        "ウルフルズ",
        "UA",
        "UVERworld"
],
    ["VOLA & THE ORIENTAL MACHINE"
],
  ["忘れらんねぇよ",
        "ワタナベイビー",
        "和田アキ子",
        "WANDS",
        "WAGDUG FUTURISTIC UNITY",
        "WEAVER",
        "WHITE ASH",
        "The Winking Owl"],
     ["Xmas Eileen"
],
     ["矢沢永吉",
        "山崎まさよし",
        "山下洋輔",
        "山内恵介",
        "山下智久",
        "柳ジョージ&レイニーウッド",
        "矢野顕子",
        "やけのはら",
        "ゆらゆら帝国",
        "湯川潮音",
        "ゆず",
        "ユニコーン",
        "四人囃子",
        "吉井和哉",
        "吉田拓郎",
        "米津玄師",
        "ヨーコ・オノ・プラスチック・オノ・バンド",
        "yanokami",
        "Yellow Magic Orchestra",
        "THE YELLOW MONKEY",
        "YOUR SONG IS GOOD",
        "YUKI",
        "YUI "
],
    ["在日ファンク",
        "頭脳警察",
        "ZAZEN BOYS",
        "ZONE"],
   ["80kidz",
    "9mm Parabellum Bullet"]]
   
    private let mySections: NSArray = ["A", "B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","R","S","T","U","V","W","X","Y","Z","number"]
    
    var buttonImage:UIImage = UIImage(named: "104937")!
    var buttonImage2:UIImage = UIImage(named: "104937")!
    //写真　曲名　秒数　音源
    //filenameをsongDataに渡す
    var songData:NSURL!
    var image:UIImage!
    var songname:UITextField!
    var byou:UILabel!
    var genre = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "KindTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
    }

    
    //FIRDatabase.database().reference().child(CommonConst.PostPATH).child(genre) に保存
    
    @IBAction func post(sender: AnyObject) {
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH).child(genre)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        let songName:NSString = songname.text!
        let kazu:NSString = byou.text!
        let ongen:NSString = songData.path!
        let realSongdata = NSData(contentsOfFile: songData.path!)
        let realsong = realSongdata!.base64EncodedStringWithOptions([])
        let uid:NSString = (FIRAuth.auth()?.currentUser?.uid)!
        let postData = ["byou": kazu, "image": imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), "songname": songName, "ongen": ongen, "realsong":realsong,"uid":uid]
         postRef.childByAutoId().setValue(postData)
        let tabvarviewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("Tab") as! TabViewController
        self.presentViewController(tabvarviewcontroller, animated: true, completion: nil)
    }
    
    
    //どこのジャンル押されたか判明
    func buttonPressed(tableViewCell: KindTableViewCell) {
        let indexPath = tableView.indexPathForCell(tableViewCell)
        genre = AllItems[indexPath!.section][indexPath!.row]
    }
    
    //値を設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! KindTableViewCell
        cell.delegate = self
        let items = AllItems[indexPath.section][indexPath.row]
        cell.label.text = items
        return cell
    }

    
    //Cellが選択された際に呼び出される.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

    //セクションの数を返す.
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mySections.count
    }
    
    //セクションのタイトルを返す.
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
    //テーブルに表示する配列の総数を返す.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllItems[section].count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   }

  
















