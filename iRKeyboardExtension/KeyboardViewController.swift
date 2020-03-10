//
//  KeyboardViewController.swift
//  iRKeyboardExtension
//
//  Created by Imran Rapiq on 1/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit



class KeyboardViewController: UIInputViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    var isPurchased: Bool = false
    
    var buttonY: CGFloat = 5
    
    let spacingWidth : CGFloat = 5
    var spacingHeight : CGFloat = UIScreen.main.bounds.height * 3 / 192
    let keyboardHeight: CGFloat = UIScreen.main.bounds.height * 3 / 8  //UIScreen.main.bounds.height * 3 / 7
 //UIScreen.main.bounds.height * 3 / 7
    var buttonHeight : CGFloat = 44
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let charNameArray = ["𝔸𝔹ℂ", "𝓐𝓑𝓒", "ＡＢＣ", "𝐀𝐁𝐂", "𝓐𝓑𝓒", "𝔄𝔅ℭ", "ÄḄĊ", "ᗩᗷᑢ", "αв¢", "ɐqɔ", "ᏗᏰፈ", "A̾B̾C̾", "ДБҀ", "ค๒ς", "ልጌር", "A͓̽B͓̽C͓̽", "ⒶⒷⒸ", "A͇B͇C͇", "ᗩᗷᑕ", "A̷B̷C̷"]
    //charSetSource
    let font1: String = """
    𝕢 𝕨 𝕖 𝕣 𝕥 𝕪 𝕦 𝕚 𝕠 𝕡 𝕒 𝕤 𝕕 𝕗 𝕘 𝕙 𝕛 𝕜 𝕝 𝕫 𝕩 𝕔 𝕧 𝕓 𝕟 𝕞 ℚ 𝕎 𝔼 ℝ 𝕋 𝕐 𝕌 𝕀 𝕆 ℙ 𝔸 𝕊 𝔻 𝔽 𝔾 ℍ 𝕁 𝕂 𝕃 ℤ 𝕏 ℂ 𝕍 𝔹 ℕ 𝕄 𝟙 𝟚 𝟛 𝟜 𝟝 𝟞 𝟟 𝟠 𝟡 𝟘 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font2 : String = """
    𝓺 𝔀 𝓮 𝓻 𝓽 𝔂 𝓾 𝓲 𝓸 𝓹 𝓪 𝓼 𝓭 𝓯 𝓰 𝓱 𝓳 𝓴 𝓵 𝔃 𝔁 𝓬 𝓿 𝓫 𝓷 𝓶 𝓠 𝓦 𝓔 𝓡 𝓣 𝓨 𝓤 𝓘 𝓞 𝓟 𝓐 𝓢 𝓓 𝓕 𝓖 𝓗 𝓙 𝓚 𝓛 𝓩 𝓧 𝓒 𝓥 𝓑 𝓝 𝓜 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """

    let font3 : String = """
    ｑ ｗ ｅ ｒ ｔ ｙ ｕ ｉ ｏ ｐ ａ ｓ ｄ ｆ ｇ ｈ ｊ ｋ ｌ ｚ ｘ ｃ ｖ ｂ ｎ ｍ Ｑ Ｗ Ｅ Ｒ Ｔ Ｙ Ｕ Ｉ Ｏ Ｐ Ａ Ｓ Ｄ Ｆ Ｇ Ｈ Ｊ Ｋ Ｌ Ｚ Ｘ Ｃ Ｖ Ｂ Ｎ Ｍ １ ２ ３ ４ ５ ６ ７ ８ ９ ０ － ／ ： ； （ ） ＄ ＆ ＠ “ ． ， ？ ！ ’ ［ ］ ｛ ｝ ＃ ％ ＾ ＊ ＋ ＝ ＿ ＼ ｜ ～ < > € £ ¥ •
    """
    
    let font4 : String = """
    𝐪 𝐰 𝐞 𝐫 𝐭 𝐲 𝐮 𝐢 𝐨 𝐩 𝐚 𝐬 𝐝 𝐟 𝐠 𝐡 𝐣 𝐤 𝐥 𝐳 𝐱 𝐜 𝐯 𝐛 𝐧 𝐦 𝐐 𝐖 𝐄 𝐑 𝐓 𝐘 𝐔 𝐈 𝐎 𝐏 𝐀 𝐒 𝐃 𝐅 𝐆 𝐇 𝐉 𝐊 𝐋 𝐙 𝐗 𝐂 𝐕 𝐁 𝐍 𝐌 𝟏 𝟐 𝟑 𝟒 𝟓 𝟔 𝟕 𝟖 𝟗 𝟎 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font5 : String = """
    𝓺 𝔀 𝓮 𝓻 𝓽 𝔂 𝓾 𝓲 𝓸 𝓹 𝓪 𝓼 𝓭 𝓯 𝓰 𝓱 𝓳 𝓴 𝓵 𝔃 𝔁 𝓬 𝓿 𝓫 𝓷 𝓶 𝓠 𝓦 𝓔 𝓡 𝓣 𝓨 𝓤 𝓘 𝓞 𝓟 𝓐 𝓢 𝓓 𝓕 𝓖 𝓗 𝓙 𝓚 𝓛 𝓩 𝓧 𝓒 𝓥 𝓑 𝓝 𝓜 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font6 : String = """
    𝔮 𝔴 𝔢 𝔯 𝔱 𝔶 𝔲 𝔦 𝔬 𝔭 𝔞 𝔰 𝔡 𝔣 𝔤 𝔥 𝔧 𝔨 𝔩 𝔷 𝔵 𝔠 𝔳 𝔟 𝔫 𝔪 𝔔 𝔚 𝔈 ℜ 𝔗 𝔜 𝔘 ℑ 𝔒 𝔓 𝔄 𝔖 𝔇 𝔉 𝔊 ℌ 𝔍 𝔎 𝔏 ℨ 𝔛 ℭ 𝔙 𝔅 𝔑 𝔐 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font7 : String  = """
    q ẅ ë ṛ ẗ ÿ ü ï ö ṗ ä ṡ ḋ ḟ ġ ḧ j ḳ ḷ ż ẍ ċ ṿ ḅ ṅ ṁ Q Ẅ Ё Ṛ Ṫ Ÿ Ü Ї Ö Ṗ Ä Ṡ Ḋ Ḟ Ġ Ḧ J Ḳ Ḷ Ż Ẍ Ċ Ṿ Ḅ Ṅ Ṁ 1 2 ӟ 4 5 6 7 8 9 0 ⸚ / : ; ( ) $ & @ “ ∵ , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font8 : String = """
    ᕴ ᘺ ᘿ ᖇ ᖶ ᖻ ᑘ ᓰ ᓍ ᕵ ᗩ S ᕲ ᖴ ᘜ ᕼ ᒚ ᖽᐸ ᒪ ᗱ ᙭ ᑢ ᐺ ᗷ ᘉ ᘻ ᕴ ᘺ ᘿ ᖇ ᖶ ᖻ ᑘ ᓰ ᓍ ᕵ ᗩ S ᕲ ᖴ ᘜ ᕼ ᒚ ᖽᐸ ᒪ ᗱ ᙭ ᑢ ᐺ ᗷ ᘉ ᘻ 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font9 : String = """
    q ω є я т у υ ι σ ρ α ѕ ∂ ƒ g н נ к ℓ z χ ¢ ν в η м q ω є я т у υ ι σ ρ α ѕ ∂ ƒ g н נ к ℓ z χ ¢ ν в η м 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font10 : String = """
    b ʍ ǝ ɹ ʇ ʎ n ı o d ɐ s p ɟ ƃ ɥ ɾ ʞ ן z x ɔ ʌ q u ɯ b ʍ ǝ ɹ ʇ ʎ n ı o d ɐ s p ɟ ƃ ɥ ɾ ʞ ן z x ɔ ʌ q u ɯ 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ ⅋ @ “ . ‘ ¿ ¡ ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font11 : String = """
    Ꭴ Ꮗ Ꮛ Ꮢ Ꮦ Ꭹ Ꮼ Ꭵ Ꭷ Ꭾ Ꮧ Ꮥ Ꮄ Ꭶ Ꮆ Ꮒ Ꮰ Ꮶ Ꮭ ፚ ጀ ፈ Ꮙ Ᏸ Ꮑ Ꮇ Ꭴ Ꮗ Ꮛ Ꮢ Ꮦ Ꭹ Ꮼ Ꭵ Ꭷ Ꭾ Ꮧ Ꮥ Ꮄ Ꭶ Ꮆ Ꮒ Ꮰ Ꮶ Ꮭ ፚ ጀ ፈ Ꮙ Ᏸ Ꮑ Ꮇ 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font12 : String = """
    q̾ w̾ e̾ r̾ t̾ y̾ u̾ i̾ o̾ p̾ a̾ s̾ d̾ f̾ g̾ h̾ j̾ k̾ l̾ z̾ x̾ c̾ v̾ b̾ n̾ m̾ Q̾ W̾ E̾ R̾ T̾ Y̾ U̾ I̾ O̾ P̾ A̾ S̾ D̾ F̾ G̾ H̾ J̾ K̾ L̾ Z̾ X̾ C̾ V̾ B̾ N̾ M̾ 1̾ 2̾ 3̾ 4̾ 5̾ 6̾ 7̾ 8̾ 9̾ 0̾ -̾ /̾ :̾ ;̾ (̾ )̾ $̾ &̾ @̾ “̾ .̾ ,̾ ?̾ !̾ ’̾ [̾ ]̾ {̾ }̾ #̾ %̾ ^̾ *̾ +̾ =̾ _̾ \\̾ |̾ ~̾ <̾ >̾ €̾ £̾ ¥̾ •̾
    """
    
    let font13: String = """
    q ш э ѓ т Ў ц і о р а ѕ ↁ f Б Ђ ј к l z х с v ъ и м Q Щ Є Я Г Ч Ц І Ф Р Д Ѕ ↁ F Б Н Ј Ќ L Z Ж Ҁ V Б И М 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font14: String = """
    ợ ฬ є г Շ ץ ย เ ๏ ק ค ร ๔ Ŧ ﻮ ђ ן к ɭ չ א ς ש ๒ ภ ๓ ợ ฬ є г Շ ץ ย เ ๏ ק ค ร ๔ Ŧ ﻮ ђ ן к ɭ չ א ς ש ๒ ภ ๓ 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font15: String = """
    ዒ ሠ ቿ ዪ ፕ ሃ ሁ ጎ ዐ የ ል ነ ዕ ቻ ኗ ዘ ጋ ጕ ረ ጊ ሸ ር ሀ ጌ ክ ጠ ዒ ሠ ቿ ዪ ፕ ሃ ሁ ጎ ዐ የ ል ነ ዕ ቻ ኗ ዘ ጋ ጕ ረ ጊ ሸ ር ሀ ጌ ክ ጠ 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font16: String = """
    q͓̽ w͓̽ e͓̽ r͓̽ t͓̽ y͓̽ u͓̽ i͓̽ o͓̽ p͓̽ a͓̽ s͓̽ d͓̽ f͓̽ g͓̽ h͓̽ j͓̽ k͓̽ l͓̽ z͓̽ x͓̽ c͓̽ v͓̽ b͓̽ n͓̽ m͓̽ Q͓̽ W͓̽ E͓̽ R͓̽ T͓̽ Y͓̽ U͓̽ I͓̽ O͓̽ P͓̽ A͓̽ S͓̽ D͓̽ F͓̽ G͓̽ H͓̽ J͓̽ K͓̽ L͓̽ Z͓̽ X͓̽ C͓̽ V͓̽ B͓̽ N͓̽ M͓̽ 1͓̽ 2͓̽ 3͓̽ 4͓̽ 5͓̽ 6͓̽ 7͓̽ 8͓̽ 9͓̽ 0͓̽ -͓̽ /͓̽ :͓̽ ;͓̽ (͓̽ )͓̽ $͓̽ &͓̽ @͓̽ “͓̽ .͓̽ ,͓̽ ?͓̽ !͓̽ ’͓̽ [͓̽ ]͓̽ {͓̽ }͓̽ #͓̽ %͓̽ ^͓̽ *͓̽ +͓̽ =͓̽ _͓̽ \\͓̽ |͓̽ ~͓̽ <͓̽ >͓̽ €͓̽ £͓̽ ¥͓̽ •͓̽
    """
    
    let font17: String = """
    ⓠ ⓦ ⓔ ⓡ ⓣ ⓨ ⓤ ⓘ ⓞ ⓟ ⓐ ⓢ ⓓ ⓕ ⓖ ⓗ ⓙ ⓚ ⓛ ⓩ ⓧ ⓒ ⓥ ⓑ ⓝ ⓜ Ⓠ Ⓦ Ⓔ Ⓡ Ⓣ Ⓨ Ⓤ Ⓘ Ⓞ Ⓟ Ⓐ Ⓢ Ⓓ Ⓕ Ⓖ Ⓗ Ⓙ Ⓚ Ⓛ Ⓩ Ⓧ Ⓒ Ⓥ Ⓑ Ⓝ Ⓜ ① ② ③ ④ ⑤ ⑥ ⑦ ⑧ ⑨ ⓪ - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font18: String = """
    q͇ w͇ e͇ r͇ t͇ y͇ u͇ i͇ o͇ p͇ a͇ s͇ d͇ f͇ g͇ h͇ j͇ k͇ l͇ z͇ x͇ c͇ v͇ b͇ n͇ m͇ Q͇ W͇ E͇ R͇ T͇ Y͇ U͇ I͇ O͇ P͇ A͇ S͇ D͇ F͇ G͇ H͇ J͇ K͇ L͇ Z͇ X͇ C͇ V͇ B͇ N͇ M͇ 1͇ 2͇ 3͇ 4͇ 5͇ 6͇ 7͇ 8͇ 9͇ 0͇ -͇ /͇ :͇ ;͇ (͇ )͇ $͇ &͇ @͇ “͇ .͇ ,͇ ?͇ !͇ ’͇ [͇ ]͇ {͇ }͇ #͇ %͇ ^͇ *͇ +͇ =͇ _͇ \\͇ |͇ ~͇ <͇ >͇ €͇ £͇ ¥͇ •͇
    """

    let font19: String = """
    ᑫ ᗯ E ᖇ T Y ᑌ I O ᑭ ᗩ ᔕ ᗪ ᖴ G ᕼ ᒍ K ᒪ ᘔ ᙭ ᑕ ᐯ ᗷ ᑎ ᗰ ᑫ ᗯ E ᖇ T Y ᑌ I O ᑭ ᗩ ᔕ ᗪ ᖴ G ᕼ ᒍ K ᒪ ᘔ ᙭ ᑕ ᐯ ᗷ ᑎ ᗰ 1 2 3 4 5 6 7 8 9 0 - / : ; ( ) $ & @ “ . , ? ! ’ [ ] { } # % ^ * + = _ \\ | ~ < > € £ ¥ •
    """
    
    let font20: String = """
    q̷ w̷ e̷ r̷ t̷ y̷ u̷ i̷ o̷ p̷ a̷ s̷ d̷ f̷ g̷ h̷ j̷ k̷ l̷ z̷ x̷ c̷ v̷ b̷ n̷ m̷ Q̷ W̷ E̷ R̷ T̷ Y̷ U̷ I̷ O̷ P̷ A̷ S̷ D̷ F̷ G̷ H̷ J̷ K̷ L̷ Z̷ X̷ C̷ V̷ B̷ N̷ M̷ 1̷ 2̷ 3̷ 4̷ 5̷ 6̷ 7̷ 8̷ 9̷ 0̷ -̷ /̷ :̷ ;̷ (̷ )̷ $̷ &̷ @̷ “̷ .̷ ,̷ ?̷ !̷ ’̷ [̷ ]̷ {̷ }̷ #̷ %̷ ^̷ *̷ +̷ =̷ _̷ \\̷ |̷ ~̷ <̷ >̷ €̷ £̷ ¥̷ •̷
    """
    
//    q̾ ̾w̾ ̾e̾ ̾r̾ ̾t̾ ̾y̾ ̾u̾ ̾i̾ ̾o̾ ̾p̾ ̾a̾ ̾s̾ ̾d̾ ̾f̾ ̾g̾ ̾h̾ ̾j̾ ̾k̾ ̾l̾ ̾z̾ ̾x̾ ̾c̾ ̾v̾ ̾b̾ ̾n̾ ̾m̾ ̾Q̾ ̾W̾ ̾E̾ ̾R̾ ̾T̾ ̾Y̾ ̾U̾ ̾I̾ ̾O̾ ̾P̾ ̾A̾ ̾S̾ ̾D̾ ̾F̾ ̾G̾ ̾H̾ ̾J̾ ̾K̾ ̾L̾ ̾Z̾ ̾X̾ ̾C̾ ̾V̾ ̾B̾ ̾N̾ ̾M̾ ̾1̾ ̾2̾ ̾3̾ ̾4̾ ̾5̾ ̾6̾ ̾7̾ ̾8̾ ̾9̾ ̾0̾ ̾-̾ ̾/̾ ̾:̾ ̾;̾ ̾(̾ ̾)̾ ̾$̾ ̾&̾ ̾@̾ ̾“̾ ̾.̾ ̾,̾ ̾?̾ ̾!̾ ̾’̾ ̾[̾ ̾]̾ ̾{̾ ̾}̾ ̾#̾ ̾%̾ ̾^̾ ̾*̾ ̾+̾ ̾=̾ ̾_̾ ̾\̾ ̾|̾ ̾~̾ ̾<̾ ̾>̾ ̾€̾ ̾£̾ ̾¥̾ ̾•̾
    
    var shiftStatus : Int = 0
    var isChar : Bool = true
    
    var secondCharUpper : [String] = [] // 10
    var secondCharLower : [String] = [] // 10
    
    var secondSymbolUpper : [String] = [] // 10
    var secondSymbolLower : [String] = [] // 10
    
    var thirdCharUpper : [String] = [] // 9
    var thirdCharLower : [String] = [] // 9
    
    var thirdSymbolUpper : [String] = [] // 10
    var thirdSymbolLower : [String] = [] // 10
    
    var forthCharUpper : [String] = [] // 7 (shift, back)
    var forthCharLower : [String] = [] // 7 (shift, back)
    
    var forthSymbol : [String] = [] // 5 (shift, back)
    var fifthSymbol : [String] = ["","","",""] // 4
    
    var fontSource : String = ""
    
    var charSetArray: [String] = []
    var keyboards : [keyboardBtn] = []
    var keyColor = UIColor()
    
    var selectIndex : Int = 0
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let charSet: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .groupTableViewBackground
       return cv
    }()
    
    let locker: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3619183302, green: 0.3619183302, blue: 0.3619183302, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let unlockBtn = UIButton()
   
    
//    @IBOutlet var nextKeyboardButton: UIButton!
//
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
//        inputView?.translatesAutoresizingMaskIntoConstraints = false
        inputView?.heightAnchor.constraint(equalToConstant: keyboardHeight + spacingHeight ).isActive = true
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //My Code
        //initialize&removing
        for subView in view.subviews{
            subView.removeFromSuperview()
        }
        fontSource = ""
        charSetArray.removeAll()
        keyboards.removeAll()
        
       spacingHeight = keyboardHeight / 24
       buttonHeight = keyboardHeight / 6
       buttonY = spacingHeight / 2
        
        //create Keyboard_Container
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leftAnchor.constraint(equalTo: inputView!.leftAnchor, constant: 0).isActive = true
        container.rightAnchor.constraint(equalTo: inputView!.rightAnchor, constant: 0).isActive = true
        container.topAnchor.constraint(equalTo: inputView!.topAnchor, constant: 0).isActive = true
        container.heightAnchor.constraint(equalToConstant: keyboardHeight + spacingHeight).isActive = true
       
        
        
        //charSet-CollectionView
        container.addSubview(charSet)
        charSet.delegate = self
        charSet.dataSource = self
        charSet.showsHorizontalScrollIndicator = false
        charSet.register(UICollectionViewCell.self,
        forCellWithReuseIdentifier: "cell")
                
        //locker
        self.view.addSubview(locker)
        self.locker.addSubview(unlockBtn)
        if !isPurchased {locker.isHidden = true}
        locker.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0).isActive = true
        locker.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0).isActive = true
        locker.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0).isActive = true
        locker.heightAnchor.constraint(equalToConstant: keyboardHeight - buttonHeight).isActive = true
        
        unlockBtn.translatesAutoresizingMaskIntoConstraints = false
        unlockBtn.centerYAnchor.constraint(equalTo: locker.centerYAnchor, constant: 0).isActive = true
        unlockBtn.centerXAnchor.constraint(equalTo: locker.centerXAnchor).isActive = true
        unlockBtn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        unlockBtn.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        unlockBtn.layer.cornerRadius = buttonHeight / 8
//        unlockBtn.lay


        unlockBtn.backgroundColor = UIColor.blue
        unlockBtn.showsTouchWhenHighlighted = true
        unlockBtn.setTitle("UNLOCK", for: .normal)
        unlockBtn.titleColor(for: .normal)
        unlockBtn.addTarget(self, action: #selector(willPurchase), for: .touchUpInside)
        
        
        
        //insert the value
        charSetArray.append(font1)
        charSetArray.append(font2)
        charSetArray.append(font3)
        charSetArray.append(font4)
        charSetArray.append(font5)
        charSetArray.append(font6)
        charSetArray.append(font7)
        charSetArray.append(font8)
        charSetArray.append(font9)
        charSetArray.append(font10)
        charSetArray.append(font11)
        charSetArray.append(font12)
        charSetArray.append(font13)
        charSetArray.append(font14)
        charSetArray.append(font15)
        charSetArray.append(font16)
        charSetArray.append(font17)
        charSetArray.append(font18)
        charSetArray.append(font19)
        charSetArray.append(font20)
        fontSource = charSetArray[0] // 96 characters
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let userDefaults = UserDefaults(suiteName: "group.wecodefonts") {
            isPurchased = userDefaults.bool(forKey: "isPurchase")
        }
        
        if traitCollection.userInterfaceStyle == .light {
           keyColor = UIColor.black
        } else {
           keyColor = UIColor.white
        }
        setupCollectionConstraints()
        self.initializeKeyboard_data(source: fontSource)
        self.array2Keyboard()
    }
    
    
    func initializeKeyboard_data(source: String) {
        // KeyboardData 2 Array
        let splitedArray = fontSource.components(separatedBy: " ")
        secondCharLower.removeAll()
        for i in 0...9 {
            secondCharLower.append(splitedArray[i])
        }
        thirdCharLower.removeAll()
        for i in 10...18 {
            thirdCharLower.append(splitedArray[i])
        }
        forthCharLower.removeAll()
        for i in 19...25{
            forthCharLower.append(splitedArray[i])
        }
        secondCharUpper.removeAll()
        for i in 26...35 {
            secondCharUpper.append(splitedArray[i])
        }
        thirdCharUpper.removeAll()
        for i in 36...44 {
            thirdCharUpper.append(splitedArray[i])
        }
        forthCharUpper.removeAll()
        for i in 45...51{
            forthCharUpper.append(splitedArray[i])
        }
        secondSymbolLower.removeAll()
        for i in 52...61 {
            secondSymbolLower.append(splitedArray[i])
        }
        thirdSymbolLower.removeAll()
        for i in 62...71 {
            thirdSymbolLower.append(splitedArray[i])
        }
        forthSymbol.removeAll()
        for i in 72...76 {
            forthSymbol.append(splitedArray[i])
        }
        secondSymbolUpper.removeAll()
        for i in 77...86 {
            secondSymbolUpper.append(splitedArray[i])
        }
        thirdSymbolUpper.removeAll()
        for i in 87...96 {
            thirdSymbolUpper.append(splitedArray[i])
        }
    }
    
    func setupCollectionConstraints() {

        charSet.translatesAutoresizingMaskIntoConstraints = false
        charSet.topAnchor.constraint(equalTo: container.topAnchor, constant: buttonY).isActive = true
        charSet.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        charSet.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2.5).isActive = true
        charSet.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -2.5).isActive = true
    }
        
    func array2Keyboard() {
        if (shiftStatus == 0) {
            if isChar{
                button2row(kNames: secondCharLower, rowNumber: 2)
                button2row(kNames: thirdCharLower, rowNumber: 3)
                button2row(kNames: forthCharLower, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }else{
                button2row(kNames: secondSymbolLower, rowNumber: 2)
                button2row(kNames: thirdSymbolLower, rowNumber: 3)
                button2row(kNames: forthSymbol, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }
        } else {
            if isChar{
                button2row(kNames: secondCharUpper, rowNumber: 2)
                button2row(kNames: thirdCharUpper, rowNumber: 3)
                button2row(kNames: forthCharUpper, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }else{
                button2row(kNames: secondSymbolUpper, rowNumber: 2)
                button2row(kNames: thirdSymbolUpper, rowNumber: 3)
                button2row(kNames: forthSymbol, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }
        }
    }
        
    func button2row (kNames: [String], rowNumber: Int) {
        var buttonX: CGFloat = 2.5  /// buttonY is defined upper
        let numberInRow: CGFloat = CGFloat(kNames.count)
        let startIndex = 0;
        var endIndex = kNames.count - 1
        
        switch numberInRow {
        case 4:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow - 1)
            for i in startIndex...endIndex {
                var buttonWidth = (screenWidth-subtractXIndex)/(numberInRow + 2)
                if i == 2 {buttonWidth *= 3}
                let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                if i == 0 {
                    if isChar {
                        oneBtn.setImage(#imageLiteral(resourceName: "numbers"), for: .normal)
                        oneBtn.setImage(#imageLiteral(resourceName: "numbersHL"), for: .highlighted)
                    }else {
                        oneBtn.setImage(#imageLiteral(resourceName: "abc"), for: .normal)
                        oneBtn.setImage(#imageLiteral(resourceName: "abcHL"), for: .highlighted)
                    }
                    oneBtn.addTarget(self, action: #selector(switchKeyboardMode), for: .touchUpInside)
                }
                if i == 1 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "globe"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "globeHL"), for: .highlighted)
                    oneBtn.tintColor = .black
                    oneBtn.addTarget(self, action: #selector(globeKeyPressed), for: .touchUpInside)
                }
                if i == 2 {
                    oneBtn.setTitle("space", for: .normal)
                    oneBtn.addTarget(self, action: #selector(spaceKeyPressed), for: .touchUpInside)
                }
                if i == 3 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "return"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "returnHL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(returnKeyPressed), for: .touchUpInside)
                }
                oneBtn.setTitleColor(keyColor, for: .normal)
                
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
                oneBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: buttonY).isActive = true
            }
        case 5:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow+1)
            let buttonWidth = (screenWidth-subtractXIndex)/(numberInRow + 2)
            let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            endIndex += 2
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                if i == 0 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0HL"), for: .highlighted)

                    oneBtn.addTarget(self, action: #selector(shiftKeyPressed), for: .touchUpInside)
                }else if i == endIndex {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspace"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspaceHL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(backspaceKeyPressed), for: .touchUpInside)
                }else{
                    oneBtn.setTitle("\(kNames[i - 1])", for: .normal)
                    oneBtn.addTarget(self, action: #selector(keyPressed(sender:)), for: .touchUpInside)
                }
                
                oneBtn.setTitleColor(keyColor, for: .normal)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
            }
        case 7:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow + 1)
            let buttonWidth = (screenWidth-subtractXIndex)/(numberInRow + 2)
           let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            endIndex += 2
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                if i == 0 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0HL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(shiftKeyPressed), for: .touchUpInside)
                }else if i == endIndex {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspace"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspaceHL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(backspaceKeyPressed), for: .touchUpInside)
                }else {
                    oneBtn.setTitle("\(kNames[i-1])", for: .normal)
                    oneBtn.addTarget(self, action: #selector(keyPressed(sender:)), for: .touchUpInside)
                }
                oneBtn.setTitleColor(keyColor, for: .normal)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
                
            }
        case 9:
            buttonX = 20
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow - 1)
            let buttonWidth = (screenWidth-subtractXIndex)/numberInRow
            let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                oneBtn.setTitle("\(kNames[i])", for: .normal)
                
                oneBtn.addTarget(self, action: #selector(keyPressed(sender: )), for: .touchUpInside)
                
                oneBtn.setTitleColor(keyColor, for: .normal)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
            }
        default:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow - 1)
            let buttonWidth = (screenWidth-subtractXIndex)/numberInRow
            let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                oneBtn.setTitle("\(kNames[i])", for: .normal)
                
                oneBtn.addTarget(self, action: #selector(keyPressed(sender: )), for: .touchUpInside)
                oneBtn.setTitleColor(keyColor, for: .normal)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
            }
        }
    }
    
    @objc func willPurchase(){
        
//        let appUrl = NSURL(string: "iRKeyboard://")!
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        //extensionContext?.open(URL(string: "Fontz://")! , completionHandler: nil)

        self.openURL(url: NSURL(string:"Fontz://HomeVC")!)
        
    }
    
    func openURL(url: NSURL) -> Bool {
        do {
            let application = try self.sharedApplication()
            return application.performSelector(inBackground: "openURL:", with: url) != nil
        }
        catch {
            return false
        }
    }

    func sharedApplication() throws -> UIApplication {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }

            responder = responder?.next
        }

        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
    
    
    @objc func keyPressed(sender: UIButton) {
        //inserts the pressed character into the text document
        var printKey : String = ""
        for i in keyboards{
            if i.tag == sender.tag {printKey = i.titleLabel!.text ?? ""}
        }
        
        textDocumentProxy.insertText(printKey) //String(sender.tag)
//        if shiftStatus is 1, reset it to 0 by pressing the shift key
        if (shiftStatus == 1) {
            shiftKeyPressed()
        }
    }
        
    @objc func globeKeyPressed() {
        advanceToNextInputMode()
    }
    
    @objc func backspaceKeyPressed() {
        textDocumentProxy.deleteBackward()
    }
            
    @objc func spaceKeyPressed() {
        textDocumentProxy.insertText(" ")
    }
    
    @objc func returnKeyPressed() {
        textDocumentProxy.insertText("\n")
    }
            
    @objc func shiftKeyPressed() {
        //if shift is on or in caps lock mode, turn it off. Otherwise, turn it on
        shiftStatus = shiftStatus > 0 ? 0 : 1;
        
        refresh()

    }
     
    @objc func switchKeyboardMode() {
        
        shiftStatus = 0
        isChar = isChar == true ? false : true
        refresh()

        var step : Int = 0
        for i in keyboards{
            if i.imageView?.image == #imageLiteral(resourceName: "numbers") || i.imageView?.image == #imageLiteral(resourceName: "abc") {break}
            step += 1
        }
        
        if isChar {
            keyboards[step].setImage(#imageLiteral(resourceName: "numbers"), for: .normal)
            keyboards[step].setImage(#imageLiteral(resourceName: "numbersHL"), for: .highlighted)
        }else{
            keyboards[step].setImage(#imageLiteral(resourceName: "abc"), for: .normal)
            keyboards[step].setImage(#imageLiteral(resourceName: "abcHL"), for: .highlighted)
        }
        

        
    }
    
    func refresh(){
        for subView in container.subviews{
            subView.removeFromSuperview()
        }
        
        container.addSubview(charSet)
        setupCollectionConstraints()
        self.array2Keyboard()
        
    }
    
    //charSet-CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charSetArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.row == selectIndex {
            if traitCollection.userInterfaceStyle == .light {
              cell.backgroundColor = UIColor.white
           } else {
                cell.backgroundColor = UIColor.darkGray
           }
            
        } else {
            cell.backgroundColor = .lightText
            
        }
        
        cell.layer.cornerRadius = 5
//        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        let cellLbl = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height))
        cellLbl.textColor = keyColor
        cellLbl.textAlignment = .center
        cellLbl.text = charNameArray[indexPath.row]
        cellLbl.tag = indexPath.row
        cell.addSubview(cellLbl)

        for subview in cell.subviews{
            if subview.tag != indexPath.row {subview.removeFromSuperview()}
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: buttonHeight - 2 * buttonY)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
       selectIndex = indexPath.row
       collectionView.reloadData()
       fontSource = charSetArray[indexPath.row]

       for subView in container.subviews{
           subView.removeFromSuperview()
       }
       
       container.addSubview(charSet)
       setupCollectionConstraints()
       
       viewWillAppear(true)
        
        if isPurchased == false {
            if indexPath.row > 1 {
                locker.isHidden = false
                
            }else{
//                self.view.addSubview(locker)
                locker.isHidden = true
            }                
        }
    }
}


//extension UIApplication {
//
//    public static func sharedApplication() -> UIApplication {
//        guard UIApplication.respondsToSelector("sharedApplication") else {
//            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication` does not respond to selector `sharedApplication`.")
//        }
//
//        guard let unmanagedSharedApplication = UIApplication.performSelector("sharedApplication") else {
//            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication.sharedApplication()` returned `nil`.")
//        }
//
//        guard let sharedApplication = unmanagedSharedApplication.takeUnretainedValue() as? UIApplication else {
//            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication.sharedApplication()` returned not `UIApplication` instance.")
//        }
//
//        return sharedApplication
//    }
//
//    public func openURL(url: NSURL) -> Bool {
//        return self.performSelector(inBackground: "openURL:", with: url) != nil
//    }
//
//}


//extension UIInputViewController {
//
//    func openURL(url: NSURL) -> Bool {
//        do {
//            let application = try self.sharedApplication()
//            return application.performSelector(inBackground: "openURL:", with: url) != nil
//        }
//        catch {
//            return false
//        }
//    }
//
//    func sharedApplication() throws -> UIApplication {
//        var responder: UIResponder? = self
//        while responder != nil {
//            if let application = responder as? UIApplication {
//                return application
//            }
//
//            responder = responder?.next
//        }
//
//        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
//    }
//}

