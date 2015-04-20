Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms

CSS_COLOR_NAMES = ["Blue","BlueViolet","Brown","BurlyWood","CadetBlue","Chartreuse","Chocolate","Coral","CornflowerBlue","Cornsilk","Crimson","Cyan","DarkBlue","DarkCyan","DarkGoldenRod","DarkGray","DarkGreen","DarkKhaki","DarkMagenta","DarkOliveGreen","Darkorange","DarkOrchid","DarkRed","DarkSalmon","DarkSeaGreen","DarkSlateBlue","DarkSlateGray","DarkSlateGrey","DarkTurquoise","DarkViolet","DeepPink","DeepSkyBlue","DimGray","DimGrey","DodgerBlue","FireBrick","FloralWhite","ForestGreen","Fuchsia","Gainsboro","GhostWhite","Gold","GoldenRod","Gray","Grey","Green","GreenYellow","HoneyDew","HotPink","IndianRed","Indigo","Ivory","Khaki","Lavender","LavenderBlush","LawnGreen","LemonChiffon","LightBlue","LightCoral","LightCyan","LightGoldenRodYellow","LightGray","LightGrey","LightGreen","LightPink","LightSalmon","LightSeaGreen","LightSkyBlue","LightSlateGray","LightSlateGrey","LightSteelBlue","LightYellow","Lime","LimeGreen","Linen","Magenta","Maroon","MediumAquaMarine","MediumBlue","MediumOrchid","MediumPurple","MediumSeaGreen","MediumSlateBlue","MediumSpringGreen","MediumTurquoise","MediumVioletRed","MidnightBlue","MintCream","MistyRose","Moccasin","NavajoWhite","Navy","OldLace","Olive","OliveDrab","Orange","OrangeRed","Orchid","PaleGoldenRod","PaleGreen","PaleTurquoise","PaleVioletRed","PapayaWhip","PeachPuff","Peru","Pink","Plum","PowderBlue","Purple","Red","RosyBrown","RoyalBlue","SaddleBrown","Salmon","SandyBrown","SeaGreen","SeaShell","Sienna","Silver","SkyBlue","SlateBlue","SlateGray","SlateGrey","Snow","SpringGreen","SteelBlue","Tan","Teal","Thistle","Tomato","Turquoise","Violet","Wheat","White","WhiteSmoke","Yellow","YellowGreen"]
EXEMPLES = 
  "ZERO"  : "(λf.λx.x)"
  "ONE"   : "(λf.λx.f x)"
  "TWO"   : "(λf.λx.f (f x))"
  "THREE" : "(λf.λx.f (f (f x)))"
  "SUCC"  : "(λn.λf.λx.f (n f x))"
  "PLUS"  : "(λm.λn.λf.λx.m f (n f x))"
  "MULT"  : "(λm.λn.λf.m (n f))"
  "POW"   : "(λb.λe.e b)"
  "PRED"  : "(λn.λf.λx.n (λg.λh.h (g f)) (λu.x) (λu.u))"
  "SUB"   : "(λm.λn.n (λn.λf.λx.n (λg.λh.h (g f)) (λu.x) (λu.u)) m)"
  "TRUE"  : "(λx.λy.x)"
  "FALSE" : "(λx.λy.y)"
  "AND"   : "(λp.λq.p q p)"
  "OR"    : "(λp.λq.p p q)"
  "NOT"   : "(λp.λa.λb.p b a)"
  "IFTHENELSE" : "(λp.λa.λb.p a b)"
  "ISZERO"     : "(λn.n (λx.(λx.λy.y)) (λx.λy.x))"
  "LEQ"        : "(λm.λn.(λp.p (λx.(λx.λy.y)) (λx.λy.x)) ((λq.λr.r (λr.λf.λx.r (λg.λh.h (g f)) (λu.x) (λu.u)) q) m n))"

lambda_exemples = ["(λx.x) (λy.y)","(λx.λy.x) (λy.y)","((λy.y) (λz.z))(λx.x)","(λx.λy. x) a b","(λx.λy. y) a b","(λa. a (λm.(λn. n ))(λp.(λq. p )))(λx.λy. y) a b","(λx.x x) (λx.x x)","λy.(λx.y (x x)) (λx.y (x x))","(λa.λs.λz.s (a s z)) (λs.λz.z) ","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s z)) (λs.λz.(s z))","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s (s (s z)))) (λs.λz.(s (s (s (s z)))))"]
ALPHABET = "abcdefghijklmnopqrstuvwxyz"
[color_tab, var_tab, debug, speed, id, parentheses] = [ [], {}, false, true, 0, 0 ]

$ ->
  #Preparation html - Construction du top-panel
  do initialize_html = ->
    for letter,index in ALPHABET[0..25]
      color_tab.push CSS_COLOR_NAMES[index]
      var_tab["#{letter}"] = CSS_COLOR_NAMES[index]

    $.get "css/svg/egg.svg", (rawSvg) -> 
      importedSVGRootElement = document.importNode rawSvg.documentElement,true
      $("#egg-svg").append(importedSVGRootElement)
      $("#egg-svg svg")[0].setAttribute('viewBox', '0 0 116 80')
    , "xml"
    $.get "css/svg/open.svg", (rawSvg) -> 
      importedSVGRootElement = document.importNode rawSvg.documentElement,true
      $("#open-svg").append(importedSVGRootElement)
      $("#open-svg svg")[0].setAttribute('viewBox', '-25 0 330 150')
    , "xml"

    $.get "css/svg/vieux.svg", (rawSvg) -> 
      importedSVGRootElement = document.importNode rawSvg.documentElement,true
      $("#vieux-svg").append(importedSVGRootElement)
      $("#vieux-svg svg")[0].setAttribute('viewBox', '0 0 228 78')
    , "xml"

    html= ""
    html += "<button id='ex-#{i}' class='panel-button' data-type='exemple' data-numero='#{i}'>#{i}</button>" for i in [0..lambda_exemples.length-1]
    $( "#draw" ).after "#{html}<br>"

    html= ""
    html += "<button id='#{key}' class='panel-button' data-type='fonction' data-lambda='#{value}'>#{key}</button>" for key,value of EXEMPLES
    $( "#items" ).before html
    html= ""
    #Préchargement des images
    for color,index in color_tab
      html+= "<div id='#{color}' class='color' style='background-color:#{color};' data-color='#{color}' data-variable='#{ALPHABET[index]}'>#{ALPHABET[index]}</div>"
    $( "#panel-variable" ).after html

    $( ".item" ).draggable
      helper : "clone"
      tolerance :"touch"
      start:  (event, ui) -> $(ui.helper).addClass("ui-draggable-helper")
      stop : (event, ui) ->  $(this).show()
      cursorAt : {top :  100, left : 25}
     
    $("#game-container").dialog
      zIndex : 10
      modal: true
      show:  {effect: 'fade', duration: 2000}
      hide: "size"
      width : "90%"
      height:  Math.floor(90 * $(window).height() / 100)
      position:
        my: "center"
        at: "center"
        of: window
      open: -> $("body").addClass("stop-scrolling")
      close: -> $("body").removeClass("stop-scrolling")
        

  $("#play").on "click", -> $("#game-container").dialog("open")
  
  #Choix d'une couleur dans la palette
  $( ".color" ).on "click", ->
    [color, variable] = [$( this ).attr("data-color"),$( this ).attr("data-variable")]
    $( "#choose-color" ).attr("data-color", color)
    $( "#panel-lambda" ).attr("data-variable", variable).html("λ#{variable}")
    $("#panel-variable").attr("data-variable", variable).html("#{variable}")
    $( ".item" ).find(".skin").css("fill", color)
    $( ".color" ).removeClass("selected-color" )
    $( this ).addClass( "selected-color" )
  $( "#Blue" ).trigger "click"

  #Gestion du panel
  $( ".panel-button" ).on "click", ->
    switch $( this ).attr("data-type")
      when "lambda"
        $( "#prompt").val($( "#prompt").val() + "λ#{$( this ).attr('data-variable')}.")
      when "variable"
        $( "#prompt").val($( "#prompt").val() + " #{$( this ).attr('data-variable')} ")
      when "open"
        $( "#prompt").val($( "#prompt").val() + "(")
      when "close"
        $( "#prompt").val($( "#prompt").val() + ")")
      when "draw"
        e = jQuery.Event("keypress")
        e.which = 13
        $('#prompt').trigger(e)
      when "clear"
        parentheses = 0
        $("#root" ).empty().append "<div id='root_definition' class='definition_drop'></div>"
        $( "#prompt" ).val("")
        make_dropped_droppable()
      when "exemple"
        $("#prompt").val lambda_exemples[$(this).attr("data-numero")]
        e = jQuery.Event("keypress")
        e.which = 13
        $('#prompt').trigger(e)
      when "fonction"
        $("#prompt").val( $("#prompt").val() + " " + $(this).attr("data-lambda") )
      when "autoclose"
        parentheses = 0
        for letter,index in $("#prompt").val()
          switch letter
            when "("
              parentheses += 1
            when ")"
              parentheses -= 1
        if parentheses < 0
          alert "il y a #{parentheses} parenthese(s) fermée en trop !)"
        else
          while parentheses > 0
            $( "#prompt").val($( "#prompt").val() + ")")
            parentheses -= 1
      when "speed"
        $(this).html( if speed then "slow" else "fast" )
        speed = not speed
      when "read"
        $("#prompt").val get_lambda_from $("#root")

  get_lambda_from = (root) ->
    getKeyByValue = ( value ) -> 
      for key of var_tab
        return key if ( var_tab[key] is value )
    exp = root.clone()
    exp.find("svg").remove()
    exp.find(".definition_drop").remove()
    exp.find(".application_drop").remove()
    exp = exp.html()
    exp = exp.replace /<div id="\d+" class="variable dropped" data-variable="(\w+)"[ style="opacity: 1;"]*>\s*<\/div>/g, (str,match) -> return " " + getKeyByValue(match)
    exp = exp.replace /<div id="\d*" class="lambda dropped" data-variable="(\w+)"[ style="opacity: 1;"]*>/g, (str,match) -> return "(λ"+getKeyByValue(match)+"."
    exp = exp.replace /<div id="\d*" class="lambda priorite dropped" data-variable="white"[ style="opacity: 1;"]*>/g, "("
    exp = exp.replace(/<\/div>/g , ")")

  #Parser une expression
  inserer_direct = (symbole, droppable,mode) ->
    switch symbole
      when "("
        [color , type, classe] = ["white","lambda priorite", ".lambda.priorite"]
        lambda = $('<div/>').html("<div id='#{id++}' class='#{type} dropped' data-variable='#{color}' ></div>").contents()
        $( "#vieux-svg").clone().contents().prependTo $(lambda)
      else
        if ALPHABET.indexOf(symbole) > -1
          [color , type, classe] = ["#{var_tab[symbole[0]]}","variable", ".variable"]
          $( "#egg-svg").find(".skin").css("fill",color)
          lambda = $('<div/>').html("<div id='#{id++}' class='#{type} dropped' data-variable='#{color}' ></div>").contents()
          $( "#egg-svg").clone().contents().prependTo $(lambda)
        else
          [color , type, classe] = ["#{var_tab[symbole[1]]}","lambda", ".lambda"]
          $( "#open-svg").find(".skin").css("fill",color)
          lambda = $('<div/>').html("<div id='#{id++}' class='#{type} dropped' data-variable='#{color}' ></div>").contents()
          $( "#open-svg").clone().contents().prependTo $(lambda)
    droppable = if mode is "definition" then droppable.append($(lambda)).children(classe).first() else droppable = droppable.after($(lambda)).next(classe)
  $('#prompt').keypress (key) ->
    local_debug = false
    if key.which is 13
      [exp, pointer] = [$( "#prompt").val() , $("#root" ).empty()]
      [parentheses, symbole, previous] = [ [],"", "none" ]
      for i in [0..exp.length-1]
        symbole += exp[i]
        alert symbole if local_debug
        switch symbole
          when "(","λa.","λb.","λc.","λd.","λe.","λf.","λg.","λh.","λi.","λj.","λk.","λl.","λm.","λn.","λo.","λp.","λq.","λr.","λs.","λt.","λu.","λv.","λw.","λx.","λy.","λz.","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
            alert "previous:#{previous}" if local_debug
            switch previous
              when "none", "(","λa.","λb.","λc.","λd.","λe.","λf.","λg.","λh.","λi.","λj.","λk.","λl.","λm.","λn.","λo.","λp.","λq.","λr.","λs.","λt.","λu.","λv.","λw.","λx.","λy.","λz."
                pointer = inserer_direct symbole, pointer, "definition"
                parentheses.push pointer.parent() if previous is "("
              else
                pointer = inserer_direct symbole, pointer, "application"
            alert "#{symbole} - new pointer is:"+ pointer.attr("id") if local_debug
            [previous, symbole] = [symbole, ""]
          when ")"
            pointer = parentheses.pop()
            [previous, symbole] = [symbole, ""]
          when " "
            symbole = ""
            continue
          else
            continue
      #eviter la propagation de la touche "entrée"
      return false

  #inserer un draggable dans un droppable - construction par glisser/déposer
  inserer = (draggable, droppable) ->
    variable = if draggable.hasClass("vieux-croco") then 'white' else $("#choose-color").attr("data-color")
    if draggable.hasClass("egg")
      type = "variable"
    else if draggable.hasClass("croco")
        type = "lambda"
    else
      type ="lambda priorite"
    lambda = "<div id='#{id++}' class='#{type} dropped' data-variable='#{variable}' ><div class='application_drop'></div></div>"
    lambda = $('<div/>').html(lambda).contents()
    if type isnt "variable"
      $( lambda ).prepend "<div class='definition_drop'></div>"
    switch type
      when "variable"
        $( "#egg-svg").find(".skin").css("fill",variable)
        $( "#egg-svg").clone().contents().prependTo $(lambda)
      when "lambda"
        $( "#open-svg").find(".skin").css("fill",variable)
        $( "#open-svg").clone().contents().prependTo $(lambda)
      when "lambda priorite"
        $( "#vieux-svg").clone().contents().prependTo $(lambda)
    if droppable.hasClass( "definition_drop" )
      droppable.before $(lambda)
    else
      droppable.parent().after $(lambda)
    droppable.remove()
  make_dropped_droppable = () ->
    $( ".application_drop, .definition_drop" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".item"
      drop : ( event, ui ) ->
        inserer ui.draggable, $(this)
        make_dropped_droppable()
  make_dropped_droppable()

  #gestion d'une etape
  $( "#go" ).on "click", ->
    local_debug = false
    delta = if speed then 500 else 4000
    $( ".application_drop, .definition_drop" ).remove()
    # Top-left RULE
    pointer = $("#root > .lambda:first")
    ahead_color =[]
    stay = true
    decapsule = (pointer) ->
      fragment = document.createDocumentFragment()
      while (pointer[0].firstChild)
        fragment.appendChild(pointer[0].firstChild)
      pointer[0].parentNode.replaceChild(fragment, pointer[0])
    while stay
      alert "stay for a loop" if local_debug
      #On tombe sur un croco blanc
      if (pointer.hasClass "priorite")
        alert "Croco blanc !" if local_debug
        #il y a des crocos de couleurs dessous
        switch pointer.children(":not(svg)").length
          #il n'y en a qu'un -> ce croco blanc ne sert à rien
          when 1
            pointer.find("svg").first().find("g#layer1").attr("transform", "rotate(180,140,65)")
            alert "Ce vieil alligator ne sert plus à rien !" if not speed
            pointer.find("svg").first().remove()
            decapsule(pointer)
            continue
          else
            if pointer.find(".lambda").length > 0
              pointer = pointer.find(".lambda").first()
            else
              pointer = pointer.next()
            continue
      #On tombe sur un croco de couleur
      if (pointer.hasClass "lambda") and (not pointer.hasClass "priorite")
        alert "Croco #{pointer.attr('data-variable')} !" if local_debug
        ahead_color.push pointer.attr("data-variable")
        switch pointer.next().length
          when 0
            alert "has nothing to eat...go deeper" if local_debug
            if pointer.find(".lambda").length > 0
              pointer = pointer.find(".lambda").first()
              continue
            else
              "nothing to eat, no deeper lambda...over !" if local_debug
              stay = false
              continue
          else
            #c'est bon action !
            stay = false
            continue
      # On tombe sur un oeuf
      if (pointer.hasClass "variable")
        alert "Oeuf #{pointer.attr('data-variable')} !" if local_debug
        ahead_color.push pointer.attr("data-variable")
        pointer = pointer.next()
        continue
      #rien ne va plus
      alert "no if detected. breakin' !" if local_debug
      stay = false

    if (pointer.hasClass "lambda") and (pointer.attr("data-color") isnt "white") and (pointer.next().length > 0)
      #Paré pour la regle de la couleur, on a la couleur de base et l'ensemble de couleurs reservées !
      ahead_color = ahead_color.unique()
      variable = pointer.attr("data-variable")
      # On recupere l'application, eventuellement on change de couleur et on la clone parce qu'elle va degager
      application = pointer.next()
      do color_rule_check = (pointer, application) ->
        get_colors = (tree) ->
          palette = []
          tree.find( "[data-variable]" ).andSelf().filter("[data-variable]").not(".lambda.priorite").each -> palette.push $( this ).data("variable")
          palette.unique()
        #On va lister les couleurs utilisées dans la definition de la fonction
        pointer_colors = get_colors pointer
        #On verifie en suite que chacune des couleurs de la fonction ne se retrouve pas dans l'application
        for color in pointer_colors
          application_items = application.find( "[data-variable='#{color}']").andSelf().filter("[data-variable='#{color}']")
          # Aie ! On en a trouvé
          if application_items.length
            alert "Règle de la couleur !(Color rule)" if not speed
            #Alors on va lister toutes les couleurs de l'application
            application_colors = get_colors application
            #On fabrique donc un ensemble de couleurs qu'on ne peut pas utiliser
            used_colors = (pointer_colors.concat application_colors.concat ahead_color).unique()
            #Et on prend autant de couleurs dans la palette qu'il y en a dans la fonction
            difference = (item for item in color_tab when item not in used_colors)
            difference = difference[0..application_colors.length-1]
            #Pour chacune des couleurs de la fonction on va echanger dans l'application avec une couleur disponible de la palette
            for new_color, index in difference
              application.find( "[data-variable=#{application_colors[index]}]").andSelf().filter("[data-variable=#{application_colors[index]}]").each ->
                if $( this ).attr("data-variable") not in ahead_color
                  $( this ).attr("data-variable", new_color)
                  $( this ).find("svg").first().find(".skin").css("fill", new_color)
            alert "C'est vu ?" if not speed
            break
      applicationClone =  application.clone()
      do bust_a_move = (p=pointer,timer=delta ,j=0) ->
        bustit = interval 50, -> p.children("svg").css("z-index":"9000").find("#jaw").attr("transform", "rotate(#{-10+Math.floor 6*Math.cos(j++)}) translate(-100,20)")
        delay timer, ->
          clearInterval bustit
          pointer.children("svg").find("g#layer1").attr("transform", "rotate(180 125 75)")
          pointer.children("svg").animate {"opacity" : 0}, delta, -> $(this).closest("svg").remove()
      application.css('visibility','hidden')
        .clone().prependTo(pointer)
        .css({"z-index" : "-1",border:"dashed black 1px",visibility:"visible",position:"absolute",top:"0px",left:"100%"})
        .animate {"min-width":"0px",padding:"0px", height: '1vw', width: "1vw", top:"0", left:"60%"} , delta, ->
          #On fait disparaitre l'application
          $(this).remove()
          application.remove()
          #On va faire reapparaitre l'application à chaque oeuf
          eggs = pointer.find( ".variable[data-variable=#{variable}]"  )
          n = eggs.length;
          if n>0
            eggs.each (index, element) ->
              $(this).after applicationClone.clone().css(opacity: 0).animate {opacity: 1}, delta, ->
                decapsule pointer if index is n-1
              $(this).animate { opacity: 0} , delta, ->
                $(this).remove()
          else
            alert "Aucun oeuf !(no egg)" if not speed
            decapsule pointer

  #Pour l'article
  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)