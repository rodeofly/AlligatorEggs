Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms

CSS_COLOR_NAMES = ["Blue","Brown","BurlyWood","CadetBlue","Chartreuse","Chocolate","Coral","CornflowerBlue","Crimson","Cyan","DarkBlue","DarkCyan","DarkGoldenRod","DarkGray","DarkGreen","DarkKhaki","DarkMagenta","DarkOliveGreen","Darkorange","DarkOrchid","DarkRed","DarkSalmon","DarkSeaGreen","DarkSlateBlue","DarkSlateGrey","DeepPink","DeepSkyBlue","DimGray","DimGrey","DodgerBlue","FireBrick","FloralWhite","ForestGreen","Fuchsia","Gainsboro","GhostWhite","Gold","GoldenRod","Gray","Grey","Green","GreenYellow","HoneyDew","HotPink","IndianRed","Indigo","Ivory","Khaki","Lavender","LavenderBlush","LawnGreen","LemonChiffon","LightBlue","LightCoral","LightCyan","LightGoldenRodYellow","LightGray","LightGrey","LightGreen","LightPink","LightSalmon","LightSeaGreen","LightSkyBlue","LightSlateGray","LightSlateGrey","LightSteelBlue","LightYellow","Lime","LimeGreen","Linen","Magenta","Maroon","MediumAquaMarine","MediumBlue","MediumOrchid","MediumPurple","MediumSeaGreen","MediumSlateBlue","MediumSpringGreen","MediumTurquoise","MediumVioletRed","MidnightBlue","MintCream","MistyRose","Moccasin","NavajoWhite","Navy","OldLace","Olive","OliveDrab","Orange","OrangeRed","Orchid","PaleGoldenRod","PaleGreen","PaleTurquoise","PaleVioletRed","PapayaWhip","PeachPuff","Peru","Pink","Plum","PowderBlue","Purple","Red","RosyBrown","RoyalBlue","SaddleBrown","Salmon","SandyBrown","SeaGreen","SeaShell","Sienna","Silver","SkyBlue","SlateBlue","SlateGray","SlateGrey","Snow","SpringGreen","SteelBlue","Tan","Teal","Thistle","Tomato","Turquoise","Violet","Wheat","White","WhiteSmoke","Yellow","YellowGreen"]
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

lambda_exemples = ["(λx.x) (λy.y)","(λx.λy.x) (λy.y)","((λy.y) (λz.z))(λx.x)","(λx.λy. x) a b","(λx.λy. y) a b","(λa. a (λm.(λn. n ))(λp.(λq. p )))(λx.λy. y) a b","(λx.x x) (λx.x x)","λy.((λx.y (x x)) (λx.y (x x)))","(λa.λs.λz.s (a s z)) (λs.λz.z) ","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s z)) (λs.λz.(s z))","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s (s (s z)))) (λs.λz.(s (s (s (s z)))))"]
EXERCICES =
  "0" :
    "titre"    : 'Tutoriel : "Le vieil alligator & les oeufs"'
    "texte"     : "<p>Voilà un vieil alligator avec des oeufs ! Le vieil alligator n'a plus faim, il a assez mangé.</p>
                   <p>Tous ce qu'il fait, c'est prendre soins de sa famille : ici ce sont des oeufs !</p>
                   <p>Les oeufs vont éclorent et donner de nouvelles familles d'alligators</p>
                   <p>Fais glisser un vieil alligator dans le panel, puis fais glisser le premier oeuf sur le bout de la queue. Enfin, un à un, glisse des oeufs les uns sur les autres pour les ajouter !</p>"
    "lambda"   : ""
    "solution" : "(f g h i i )" 
  "1" :
    "titre"    : 'Tutoriel : "Les alligators affamés"'
    "texte"     : "Voilà des alligators affamés...Les alligators affamés ont faim. Ils vont manger tout ce qui est en face d'eux! Mais ils sont aussi des alligators responsables, et comme les vieux alligators, ils gardent leurs familles. Allez fais glisser !"
    "lambda"   : "λx.?"
    "solution" : "λx.λy.λz." 
  "2" :
    "titre"    : 'Exercice 1 - La règle du "Mange-moi"'
    "texte"     : "Trouves le bon oeuf à placer sous le crocodile 'x' afin d'obtenir le résultat ci dessous"
    "lambda"   : "(λx.?) (λy.y)"
    "solution" : "λy.y"
ALPHABET = "abcdefghijklmnopqrstuvwxyz"
[color_tab, var_tab, debug, speed, id, parentheses] = [ [], {}, false, true, 0, 0 ]

$ ->
  #Preparation html - Construction de la console
  do initialize_html = ->
    for key of EXERCICES
      $( '#exercices' ).append "<button class='panel-button exercice'  data-id='#{key}'>Ex#{key}</button>"
    for letter,index in ALPHABET[0..25]
      color_tab.push CSS_COLOR_NAMES[index]
      var_tab["#{letter}"] = CSS_COLOR_NAMES[index]

    $.get "css/svg/egg.svg", (rawSvg) -> 
      $("#egg-svg").append(document.importNode rawSvg.documentElement,true)
      $("#egg-svg svg")[0].setAttribute('viewBox', '0 0 116 80')
    , "xml"
    $.get "css/svg/open.svg", (rawSvg) -> 
      $("#open-svg").append(document.importNode rawSvg.documentElement,true)
      $("#open-svg svg")[0].setAttribute('viewBox', '-25 0 330 150')
    , "xml"

    $.get "css/svg/vieux.svg", (rawSvg) -> 
      $("#vieux-svg").append(document.importNode rawSvg.documentElement,true)
      $("#vieux-svg svg")[0].setAttribute('viewBox', '0 0 228 78')
    , "xml"

    html= ""
    html += "<button id='ex-#{i}' class='panel-button' data-type='exemple' data-numero='#{i}'>#{i}</button>" for i in [0..lambda_exemples.length-1]
    $( "#draw" ).after "#{html}<br>"

    html= ""
    html += "<button id='#{key}' class='panel-button' data-type='fonction' data-lambda='#{value}'>#{key}</button>" for key,value of EXEMPLES
    $( "#panel-variable" ).after html
    html= ""
    #Préchargement des images
    for color,index in color_tab
      html+= "<div id='#{color}' class='color' style='background-color:#{color};' data-color='#{color}' data-variable='#{ALPHABET[index]}'>#{ALPHABET[index]}</div>"
    $( "#items" ).before html

    $( ".item" ).draggable
      helper : "clone"
      start:  (event, ui) -> $(ui.helper).addClass("ui-draggable-helper")
      stop : (event, ui) ->  $(this).show()
      #cursorAt : {top :  50, left : 150}

    $("#game-container").dialog
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
        

  #Choix d'une couleur dans la palette
  $( ".color" ).on "click", ->
    [color, variable] = [$( this ).attr("data-color"),$( this ).attr("data-variable")]
    $( "#choose-color" ).attr("data-variable", variable)
    $( "#choose-color" ).attr("data-color", color)
    $( "#panel-lambda" ).attr("data-variable", variable).html("λ#{variable}")
    $("#panel-variable").attr("data-variable", variable).html("#{variable}")
    $( "#egg-svg, #open-svg" ).find(".skin").css("fill", color)
    $( ".color" ).removeClass("selected-color" )
    $( this ).addClass( "selected-color" )
  $( ".color:first" ).trigger 'click'

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
  #Parser une expression
  get_lambda_from = (root) ->
    exp = root.clone()
    exp.find("svg").remove()
    exp.find(".definition_drop").remove()
    exp.find(".application_drop").remove()
    exp = exp.html()
    exp = exp.replace /<div id="\d*" class="variable dropped" data-variable="(\w+)" data-color="\w+"[ style="opacity: 1;"]*>\s*<\/div>/g, "$1 "
    exp = exp.replace /<div id="\d*" class="lambda dropped" data-variable="(\w+)" data-color="\w+"[ style="opacity: 1;"]*>/g, "λ$1.("
    exp = exp.replace /<div id="\d*" class="lambda priorite dropped" data-variable="\(" data-color="white"[ style="opacity: 1;"]*>/g, "("
    exp = exp.replace(/<\/div>/g , ")")

  insert_exp_into_div = (exp, root) ->
    expression = exp
    id = 0
    #make it easy to retrieve variables
    expression = expression.replace /([.( ])([a-z])/g, "$1woot$2" 
    #lambdas
    while expression.match /λ/
      expression = expression.replace /λ(\w).([^)]*\s?\)*)/ , "<div id='' class='lambda dropped' data-variable='$1' data-color=''>$2</div>"
    #most outer parentheses
    expression = expression.replace /[ ]*\(([^)]*\s?\)*)\)[ ]*/g, "<div id='' class='lambda priorite dropped' data-variable='parenthese' data-color='white' >$1</div>"   
    expression = expression.replace /\(/g, "<div id='' class='lambda priorite dropped' data-variable='parenthese' data-color='white'>"
    expression = expression.replace /\)/g, "</div>"
    expression = expression.replace /parenthese/g, "("
    #variables
    reg = /woot(\w)/g
    expression = expression.replace reg, "<div id='' class='variable dropped' data-variable='$1' data-color='' ></div>"
    #? inconnues
    if expression.match /\?/
      expression = expression.replace /\?/, "<div class='definition_drop'></div>"
    expression = $('<div/>').html( expression ).contents()
    root.empty().append $( expression )
    make_dropped_droppable()
    #Insert alligators
    $( root ).find(".dropped").each ->
      $( this ).attr "id", "#{id++}"
      if ($( this ).hasClass "lambda") and ($( this ).hasClass "priorite") 
        $( "#vieux-svg").clone().contents().prependTo $(this)
      else
        variable = $( this ).attr "data-variable"
        $( this ).attr "data-color", "#{var_tab[variable]}"
        if $( this ).hasClass "variable"
          $( "#egg-svg").find(".skin").css("fill", $(this).attr "data-color")
          $( "#egg-svg").clone().contents().prependTo  $(this)
        else
          $( "#open-svg").find(".skin").css("fill", $(this).attr "data-color")
          $( "#open-svg").clone().contents().prependTo  $(this)
 
  $('#prompt').keypress (key) ->
    insert_exp_into_div($( "#prompt").val(),$("#root")) if key.which is 13
    #eviter la propagation de la touche "entrée"

  #inserer un draggable dans un droppable - construction par glisser/déposer
  inserer_direct = (symbole, droppable,mode) ->
    switch symbole
      when "("
        [color , type, classe] = ["white","lambda priorite", ".lambda.priorite"]
        lambda = $('<div/>').html("<div id='#{id++}' class='#{type} dropped' data-variable='#{symbole}' data-color='#{color}' ></div>").contents()
        $( "#vieux-svg").clone().contents().prependTo $(lambda)
      else
        if ALPHABET.indexOf(symbole) > -1
          [color , type, classe] = ["#{var_tab[symbole[0]]}","variable", ".variable"]
          $( "#egg-svg").find(".skin").css("fill",color)
          lambda = $('<div/>').html("<div id='#{id++}' class='#{type} dropped' data-variable='#{symbole[0]}' data-color='#{color}' ></div>").contents()
          $( "#egg-svg").clone().contents().prependTo $(lambda)
        else
          [color , type, classe] = ["#{var_tab[symbole[1]]}","lambda", ".lambda"]
          $( "#open-svg").find(".skin").css("fill",color)
          lambda = $('<div/>').html("<div id='#{id++}' class='#{type} dropped' data-variable='#{symbole[1]}' data-color='#{color}' ></div>").contents()
          $( "#open-svg").clone().contents().prependTo $(lambda)
    if mode is "definition"
      droppable = droppable.append($(lambda)).children(classe).first()
    else
      droppable = droppable.after($(lambda)).next(classe)
  
  
  inserer = (draggable, droppable) ->
    if draggable.hasClass("vieux-croco")
      [variable, color] = ["(", "white"]
    else 
      [variable, color] = [$("#choose-color").attr("data-variable"), $("#choose-color").attr("data-color")]
    if draggable.hasClass("egg")
      type = "variable"
    else if draggable.hasClass("croco")
        type = "lambda"
    else
      type ="lambda priorite"
    lambda = "<div id='#{id++}' class='#{type} dropped' data-variable='#{variable}' data-color='#{color}' ><div class='application_drop'></div></div>"
    lambda = $('<div/>').html(lambda).contents()
    if type isnt "variable"
      $( lambda ).prepend "<div class='definition_drop'></div>"
    switch type
      when "variable"
        $( "#egg-svg").find(".skin").css("fill",color)
        $( "#egg-svg").clone().contents().prependTo $(lambda)
      when "lambda"
        $( "#open-svg").find(".skin").css("fill",color)
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
    ahead_vars =[]
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
        ahead_vars.push pointer.attr("data-variable")
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
        ahead_vars.push pointer.attr("data-variable")
        pointer = pointer.next()
        continue
      #rien ne va plus
      alert "no if detected. breakin' !" if local_debug
      stay = false

    if (pointer.hasClass "lambda") and (pointer.attr("data-color") isnt "white") and (pointer.next().length > 0)
      #Paré pour la regle de la couleur, on a la couleur de base et l'ensemble de couleurs reservées !
      ahead_vars = ahead_vars.unique()
      variable = pointer.attr("data-variable")
      # On recupere l'application, eventuellement on change de couleur et on la clone parce qu'elle va degager
      application = pointer.next()
      do color_rule_check = (pointer, application) ->
        get_vars = (tree) ->
          palette = []
          tree.find( "[data-variable]" ).andSelf().filter("[data-variable]").not(".lambda.priorite").each -> palette.push $( this ).data("variable")
          palette.unique()
        #On va lister les variables utilisées dans la definition de la fonction
        pointer_vars = get_vars pointer
        #On verifie en suite que chacune des couleurs de la fonction ne se retrouve pas dans l'application
        for $var in pointer_vars
          application_items = application.find( "[data-variable='#{$var}']").andSelf().filter("[data-variable='#{$var}']")
          # Aie ! On en a trouvé
          if application_items.length
            alert "Règle de la couleur !(Color rule)" if not speed
            #Alors on va lister toutes les couleurs de l'application
            application_vars = get_vars application
            #On fabrique donc un ensemble de couleurs qu'on ne peut pas utiliser
            used_vars = (pointer_vars.concat application_vars.concat ahead_vars).unique()
            #Et on prend autant de couleurs dans la palette qu'il y en a dans la fonction
            difference = (item for item in ALPHABET when item not in used_vars)
            difference = difference[0..application_vars.length-1]
            #Pour chacune des couleurs de la fonction on va echanger dans l'application avec une couleur disponible de la palette
            for new_var in difference
              application.find( "[data-variable=#{new_var}]").andSelf().filter("[data-variable=#{new_var}]").each ->
                if $( this ).attr("data-variable") not in ahead_vars
                  $( this ).attr("data-variable", new_var)
                  $( this ).attr("data-variable", application_colors[new_var])
                  $( this ).find("svg").first().find(".skin").css("fill", application_colors[new_var])
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
  
  # Gestion du jeu
  $( "#console" ).toggle()     
  $( "#toggle-console" ).on "click", -> $( "#console" ).toggle()
  #Exercice
  $( "#exercice").hide()
  $( ".exercice").on "click", () ->
    i = $( this ).attr( "data-id" )
    $( "#exercice > .panel-button.exercice").attr( "data-id", $( this ).attr( "data-id" ))
    if EXERCICES["#{i}"]["lambda"] isnt ""
      insert_exp_into_div(EXERCICES["#{i}"]["lambda"],$("#root"))
    else
      $("#root" ).empty().append "<div id='root_definition' class='definition_drop'></div>"
    solution = EXERCICES["#{i}"]["solution"]
    insert_exp_into_div(solution,$("#solution"))
    $( "#exercice" ).attr("data-solution", solution)
    [titre, texte] = [EXERCICES["#{i}"]["titre"], EXERCICES["#{i}"]["texte"]]
    $( "#exercice > .titre" ).html("<h1>#{titre}</h1>")
    $( "#exercice > .texte" ).html("<p>#{texte}</p>")
    $( "#exercice").show().draggable()
  
  $( "#exercice > .check" ).on "click", ->
    local_debug = true
    solution = $( "#exercice" ).attr("data-solution")
    resultat = get_lambda_from $("#root")
    if resultat is solution
      alert "Super ! Si tu as tout compris, passe à l'exo suivant. Sinon rejoue !"
    else
      alert "Raté ! Essaye encore, n'oublie pas de cliquer sur 'rejouer'"
      alert "[debug soluce : #{solution} ; eleve : #{resultat}]" if local_debug
    

  #Pour l'article
  $("#play").on "click", -> $("#game-container").dialog("open")

  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)
