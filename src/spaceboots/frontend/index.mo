import Text "mo:base/Text";
module { 
 public func get_html() : Blob { return Text.encodeUtf8("<!DOCTYPE html>"
#"<html lang=\"en\">"
#"<head>"
#"  <meta charset=\"UTF-8\">"
#"  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
#"  <title>Ocean space boots</title>"
#"  <style>"
#"    :root {"
#"      --color1: rgb(0, 231, 255);"
#"      --color2: rgb(16, 56, 217);"
#"      --charizard1: rgb(255, 213, 170);"
#"      --charizard2: #d2ddaa;"
#"      --charizardfront: url(oceanspaceboots.jpg);"
#"    }"
#""
#"    body, html {"
#"      margin: 0;"
#"      padding: 0;"
#"      display: flex;"
#"      flex-direction: column;"
#"      align-items: center;"
#"      justify-content: flex-start;"
#"      background-color: white;"
#"      overflow-x: hidden;"
#"    }"
#""
#"    .container {"
#"      display: flex;"
#"      flex-direction: column;"
#"      align-items: center;"
#"      margin-top: 20px;"
#"      flex: 1 0 auto;"
#"    }"
#""
#"    .card {"
#"      width: 85vw;"
#"      height: 119vw;"
#"      @media screen and (min-width: 600px) {"
#"        width: clamp(15vw, 85vh, 22vw);"
#"        height: clamp(21vw, 119vh, 30.8vw);"
#"      }"
#"      position: relative;"
#"      overflow: hidden;"
#"      margin: 20px;"
#"      z-index: 10;"
#"      touch-action: none;"
#"      border-radius: 5% / 3.5%;"
#"      box-shadow: -5px -5px 5px -5px var(--color1),"
#"                  5px 5px 5px -5px var(--color2),"
#"                  -7px -7px 10px -5px transparent,"
#"                  7px 7px 10px -5px transparent,"
#"                  0 0 5px 0px rgba(255, 255, 255, 0),"
#"                  0 55px 35px -20px rgba(0, 0, 0, 0.5);"
#"      transition: transform 0.5s ease, box-shadow 0.2s ease;"
#"      will-change: transform, filter;"
#"      background-color: #040712;"
#"      background-image: var(--front);"
#"      background-size: cover;"
#"      background-repeat: no-repeat;"
#"      background-position: 50% 50%;"
#"      transform-origin: center;"
#"    }"
#""
#"    .card:hover {"
#"      box-shadow: -20px -20px 30px -25px var(--color1),"
#"                  20px 20px 30px -25px var(--color2),"
#"                  -7px -7px 10px -5px var(--color1),"
#"                  7px 7px 10px -5px var(--color2),"
#"                  0 0 13px 4px rgba(255, 255, 255, 0.3),"
#"                  0 55px 35px -20px rgba(0, 0, 0, 0.5);"
#"    }"
#""
#"    .card.charizard {"
#"      --color1: var(--charizard1);"
#"      --color2: var(--charizard2);"
#"      --front: var(--charizardfront);"
#"    }"
#""
#"    .card:before,"
#"    .card:after {"
#"      content: \"\";"
#"      position: absolute;"
#"      left: 0;"
#"      right: 0;"
#"      bottom: 0;"
#"      top: 0;"
#"      background-repeat: no-repeat;"
#"      opacity: .5;"
#"      mix-blend-mode: color-dodge;"
#"      transition: all .33s ease;"
#"    }"
#""
#"    .card:before {"
#"      background-position: 50% 50%;"
#"      background-size: 300% 300%;"
#"      background-image: linear-gradient("
#"        115deg,"
#"        transparent 0%,"
#"        var(--color1) 25%,"
#"        transparent 47%,"
#"        transparent 53%,"
#"        var(--color2) 75%,"
#"        transparent 100%"
#"      );"
#"      opacity: .5;"
#"      filter: brightness(.5) contrast(1);"
#"      z-index: 1;"
#"    }"
#""
#"    .card:after {"
#"      opacity: 1;"
#"      background-image: url(\"https://assets.codepen.io/13471/sparkles.gif\"),"
#"                        url(\"https://assets.codepen.io/13471/holo.png\"),"
#"                        linear-gradient(125deg, #ff008450 15%, #fca40040 30%, #ffff0030 40%, #00ff8a20 60%, #00cfff40 70%, #cc4cfa50 85%);"
#"      background-position: 50% 50%;"
#"      background-size: 160%;"
#"      background-blend-mode: overlay;"
#"      z-index: 2;"
#"      filter: brightness(1) contrast(1);"
#"      transition: all .33s ease;"
#"      mix-blend-mode: color-dodge;"
#"      opacity: .75;"
#"    }"
#""
#"    .card.active:after,"
#"    .card:hover:after {"
#"      filter: brightness(1) contrast(1);;"
#"      opacity: 1;"
#"    }"
#""
#"    .card.active,"
#"    .card:hover {"
#"      animation: none;"
#"      transition: box-shadow 0.1s ease-out;"
#"    }"
#""
#"    .card.active:before,"
#"    .card:hover:before {"
#"      animation: none;"
#"      background-image: linear-gradient("
#"        110deg,"
#"        transparent 25%,"
#"        var(--color1) 48%,"
#"        var (--color2) 52%,"
#"        transparent 75%"
#"      );"
#"      background-position: 50% 50%;"
#"      background-size: 250% 250%;"
#"      opacity: .88;"
#"      filter: brightness(.66) contrast(1.33);"
#"      transition: none;"
#"    }"
#""
#"    .card.active:before,"
#"    .card:hover:before,"
#"    .card.active:after,"
#"    .card:hover:after {"
#"      animation: none;"
#"      transition: none;"
#"    }"
#""
#"    .card.animated {"
#"      transition: none;"
#"      animation: holoCard 12s ease 0s 1;"
#"      &:before {"
#"        transition: none;"
#"        animation: holoGradient 12s ease 0s 1;"
#"      }"
#"      &:after {"
#"        transition: none;"
#"        animation: holoSparkle 12s ease 0s 1;"
#"      }"
#"    }"
#""
#"    @keyframes holoSparkle {"
#"      0%, 100% {"
#"        opacity: .75; background-position: 50% 50%; filter: brightness(1.2) contrast(1.25);"
#"      }"
#"      5%, 8% {"
#"        opacity: 1; background-position: 40% 40%; filter: brightness(.8) contrast(1.2);"
#"      }"
#"      13%, 16% {"
#"        opacity: .5; background-position: 50% 50%; filter: brightness(1.2) contrast(.8);"
#"      }"
#"      35%, 38% {"
#"        opacity: 1; background-position: 60% 60%; filter: brightness(1) contrast(1);"
#"      }"
#"      55% {"
#"        opacity: .33; background-position: 45% 45%; filter: brightness(1.2) contrast(1.25);"
#"      }"
#"    }"
#""
#"    @keyframes holoGradient {"
#"      0%, 100% {"
#"        opacity: 0.5;"
#"        background-position: 50% 50%;"
#"        filter: brightness(.5) contrast(1);"
#"      }"
#"      5%, 9% {"
#"        background-position: 100% 100%;"
#"        opacity: 1;"
#"        filter: brightness(.75) contrast(1.25);"
#"      }"
#"      13%, 17% {"
#"        background-position: 0% 0%;"
#"        opacity: .88;"
#"      }"
#"      35%, 39% {"
#"        background-position: 100% 100%;"
#"        opacity: 1;"
#"        filter: brightness(.5) contrast(1);"
#"      }"
#"      55% {"
#"        background-position: 0% 0%;"
#"        opacity: 1;"
#"        filter: brightness(.75) contrast(1.25);"
#"      }"
#"    }"
#""
#"    @keyframes holoCard {"
#"      0%, 100% {"
#"        transform: rotateZ(0deg) rotateX(0deg) rotateY(0deg);"
#"      }"
#"      5%, 8% {"
#"        transform: rotateZ(0deg) rotateX(6deg) rotateY(-20deg);"
#"      }"
#"      13%, 16% {"
#"        transform: rotateZ(0deg) rotateX(-9deg) rotateY(32deg);"
#"      }"
#"      35%, 38% {"
#"        transform: rotateZ(3deg) rotateX(12deg) rotateY(20deg);"
#"      }"
#"      55% {"
#"        transform: rotateZ(-3deg) rotateX(-12deg) rotateY(-27deg);"
#"      }"
#"    }"
#""
#"    .button {"
#"      margin-top: 30px;"
#"      padding: 10px 20px;"
#"      border: none;"
#"      border-radius: 5px;"
#"      background-color: #040712;"
#"      color: white;"
#"      font-size: 18px;"
#"      cursor: pointer;"
#"      box-shadow: -5px -5px 5px -5px var(--color1),"
#"                  5px 5px 5px -5px var(--color2),"
#"                  -7px -7px 10px -5px transparent,"
#"                  7px 7px 10px -5px transparent,"
#"                  0 0 5px 0px rgba(255, 255, 255, 0),"
#"                  0 55px 35px -20px rgba(0, 0, 0, 0.5);"
#"      transition: box-shadow 0.2s ease, transform 0.2s ease;"
#"    }"
#""
#"    .button:hover {"
#"      box-shadow: -10px -10px 15px -10px var(--color1),"
#"                  10px 10px 15px -10px var(--color2),"
#"                  -7px -7px 10px -5px var(--color1),"
#"                  7px 7px 10px -5px var(--color2),"
#"                  0 0 13px 4px rgba(255, 255, 255, 0.3),"
#"                  0 55px 35px -20px rgba(0, 0, 0, 0.5);"
#"      transform: scale(1.05);"
#"    }"
#""
#"    footer {"
#"      text-align: center;"
#"      padding-top: 80px ;"
#"      flex-shrink: 0;"
#"      color: black;"
#"    }"
#""
#"    footer a {"
#"      color: var(--color1);"
#"      text-decoration: none;"
#"    }"
#""
#"    footer a:hover {"
#"      text-decoration: underline;"
#"    }"
#"  </style>"
#"</head>"
#"<body>"
#"  <div class=\"container\">"
#"    <div class=\"card charizard animated\"></div>"
#"    <button class=\"button\">View Entire Collection</button>"
#"  </div>"
#"    <footer>"
#"      <p>Part of <a href=\"https://raygen.org\" target=\"_blank\">raygen.org</a> project</p>"
#"    </footer>"
#"  </div>"
#"  <style class=\"hover\"></style>"
#"  <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js\"></script>"
#"  <script>"
#"    var x;"
#"    var $cards = $(\".card\");"
#"    var $style = $(\".hover\");"
#""
#"    $cards.on(\"mousemove touchmove\", function(e) {"
#"      // normalise touch/mouse"
#"      var pos = [e.offsetX, e.offsetY];"
#"      e.preventDefault();"
#"      if (e.type === \"touchmove\") {"
#"        pos = [e.touches[0].clientX, e.touches[0].clientY];"
#"      }"
#"      var $card = $(this);"
#"      // math for mouse position"
#"      var l = pos[0];"
#"      var t = pos[1];"
#"      var h = $card.height();"
#"      var w = $card.width();"
#"      var px = Math.abs(Math.floor(100 / w * l) - 100);"
#"      var py = Math.abs(Math.floor(100 / h * t) - 100);"
#"      var pa = (50 - px) + (50 - py);"
#"      // math for gradient / background positions"
#"      var lp = (50 + (px - 50) / 1.5);"
#"      var tp = (50 + (py - 50) / 1.5);"
#"      var px_spark = (50 + (px - 50) / 7);"
#"      var py_spark = (50 + (py - 50) / 7);"
#"      var p_opc = 20 + (Math.abs(pa) * 1.5);"
#"      var ty = ((tp - 50) / 2) * -1;"
#"      var tx = ((lp - 50) / 1.5) * .5;"
#"      // css to apply for active card"
#"      var grad_pos = `background-position: ${lp}% ${tp}%;`;"
#"      var sprk_pos = `background-position: ${px_spark}% ${py_spark}%;`;"
#"      var opc = `opacity: ${p_opc / 100};`;"
#"      var tf = `transform: rotateX(${ty}deg) rotateY(${tx}deg);`;"
#"      // need to use a <style> tag for psuedo elements"
#"      var style = `.card:hover:before { ${grad_pos} }  /* gradient */ .card:hover:after { ${sprk_pos} ${opc} }   /* sparkles */`;"
#"      // set / apply css class and style"
#"      $cards.removeClass(\"active\");"
#"      $card.removeClass(\"animated\");"
#"      $card.attr(\"style\", tf);"
#"      $style.html(style);"
#"      if (e.type === \"touchmove\") {"
#"        return false;"
#"      }"
#"      clearTimeout(x);"
#"    }).on(\"mouseout touchend touchcancel\", function() {"
#"      // remove css, apply custom animation on end"
#"      var $card = $(this);"
#"      $style.html(\"\");"
#"      $card.removeAttr(\"style\");"
#"      x = setTimeout(function() {"
#"        $card.addClass(\"animated\");"
#"      }, 2500);"
#"    });"
#"  </script>"
#"</body>"
#"</html>"
#"");
 };
}