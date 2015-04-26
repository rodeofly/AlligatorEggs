Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms

CSS_COLOR_NAMES = ["Blue","Brown","BurlyWood","CadetBlue","Chartreuse","Chocolate","Coral","Yellow","Crimson","Cyan","DarkBlue","DarkCyan","DarkGoldenRod","DarkGray","DarkGreen","DarkKhaki","DarkMagenta","DarkOliveGreen","Darkorange","DarkOrchid","DarkRed","DarkSalmon","DarkSeaGreen","DarkSlateBlue","DarkSlateGrey","DeepPink","DeepSkyBlue","DimGray","DimGrey","DodgerBlue","FireBrick","FloralWhite","ForestGreen","Fuchsia","Gainsboro","GhostWhite","Gold","GoldenRod","Gray","Grey","Green","GreenYellow","HoneyDew","HotPink","IndianRed","Indigo","Ivory","Khaki","Lavender","LavenderBlush","LawnGreen","LemonChiffon","LightBlue","LightCoral","LightCyan","LightGoldenRodYellow","LightGray","LightGrey","LightGreen","LightPink","LightSalmon","LightSeaGreen","LightSkyBlue","LightSlateGray","LightSlateGrey","LightSteelBlue","LightYellow","Lime","LimeGreen","Linen","Magenta","Maroon","MediumAquaMarine","MediumBlue","MediumOrchid","MediumPurple","MediumSeaGreen","MediumSlateBlue","MediumSpringGreen","MediumTurquoise","MediumVioletRed","MidnightBlue","MintCream","MistyRose","Moccasin","NavajoWhite","Navy","OldLace","Olive","OliveDrab","Orange","OrangeRed","Orchid","PaleGoldenRod","PaleGreen","PaleTurquoise","PaleVioletRed","PapayaWhip","PeachPuff","Peru","Pink","Plum","PowderBlue","Purple","Red","RosyBrown","RoyalBlue","SaddleBrown","Salmon","SandyBrown","SeaGreen","SeaShell","Sienna","Silver","SkyBlue","SlateBlue","SlateGray","SlateGrey","Snow","SpringGreen","SteelBlue","Tan","Teal","Thistle","Tomato","Turquoise","Violet","Wheat","White","WhiteSmoke","YellowGreen"]
FUNCTION =
  "ZERO"  : "(λf.λx.x)"
  "ONE"   : "(λf.λx.(f x))"
  "TWO"   : "(λf.λx.(f(f x)))"
  "THREE" : "(λf.λx.(f(f(f x))))"
  "FOUR"  : "(λf.λx.(f(f(f(f x)))))"
  "FIVE"  : "(λf.λx.(f(f(f(f(f x))))))"
  "SUCC"  : "(λn.λf.λx.f (n f x))"
  "PLUS"  : "(λm.λn.λf.λx.m f (n f x))"
  "MULT"  : "(λm.λn.λf.m (n f))"
  "POW"   : "(λb.λe.e b)"
  "PRED"  : "(λa.λf.λx.a (λg.λh.h (g f)) (λu.x) (λu.u))"
  "SUB"   : "(λm.λa. (a  (λn.λf.λx. n (λg.λh.h (g f)) (λu.x) (λu.u))) m)"
  "TRUE"  : "(λa.λb.a)"
  "FALSE" : "(λa.λb.b)"
  "AND"   : "(λp.λq.p q p)"
  "OR"    : "(λp.λq.p p q)"
  "NOT"   : "(λp.λa.λb.p b a)"
  "IFTHENELSE" : "(λp.λa.λb.p a b)"
  "ISZERO"     : "(λn.n (λx.(λa.λb.b)) (λa.λb.a))"
  "LEQ"        : "(λc.λp. (λq.q (λx.(λd.λe.e)) (λd.λe.d)) ((λm.λa. (a  (λn.λf.λx. n (λg.λh.h (g f)) (λu.x) (λu.u))) m) c p))"

EXERCICES =
  "0" :
    "titre"            : 'Les items (1): "Le vieil alligator & les oeufs"'
    "texte"            : "<p>Voilà un vieil alligator avec des oeufs ! Le vieil alligator n'a plus faim, il a assez mangé.</p><p>Tous ce qu'il fait, c'est prendre soin de sa famille : ici ce sont des oeufs !</p><p>Les oeufs vont éclorent et donner de nouvelles familles d'alligators.</p><p>Fais glisser un vieil alligator dans le panel, puis fais glisser le premier oeuf sur le bout de la queue. Enfin, un à un, glisse des oeufs les uns sur les autres pour les ajouter !</p>"
    "contenu-exercice" : "(f g h i i )"
    "contenu-eleve"    : ""
    "solution"         : "(f g h i i ) " 

  "1" :
    "titre"            : 'Les items (2) : "Les alligators affamés"'
    "texte"            : "<p>Voilà des alligators affamés...Les alligators affamés ont faim. Ils vont manger tout ce qui est en face d'eux! Mais ils sont aussi des alligators responsables, et comme les vieux alligators, ils gardent leurs familles.</p><p>Allez fais glisser !</p>"
    "contenu-exercice" : "λx.(λy.(λz.() ) ) "
    "contenu-eleve"    : ""
    "solution"         : "λx.(λy.(λz.() ) ) "

  "2" :
    "titre"            : 'Les familles (1)'
    "texte"            : "<p>Voici une petite famille : un alligator garde son oeuf !</p><p>Peux tu la recréer ?</p>"
    "contenu-exercice" : "λe.e"
    "contenu-eleve"    : ""
    "solution"         : "λe.(e ) "

  "3" :
    "titre"            : 'Les familles (2)'
    "texte"            : "<p>Voici une petite famille un peu plus grande.</p><p>Un alligator garde un autre alligator qui gardent deux oeufs. Ou tu pourrez dire qu'un alligator garder un autre alligator qui est gardien des deux oeufs.</p><p>Peux tu la recréer ?</p>"
    "contenu-exercice" : "λe.λf.e f"
    "contenu-eleve"    : ""
    "solution"         : "λe.(λf.(e f ) ) "
    
  "4" :
    "titre"            : 'Les familles (3)'
    "texte"            : "<p>Voici une énorme famille ! Nous avons un alligator jaune, vert et rouge qui gardent cette famille. Ils gardent trois choses : un oeuf vert, un vieux crocodile , et un oeuf rouge. Le vieil alligator, lui, garde un œuf jaune et un oeuf vert.</p><p>Note bien que les œufs n'utilisent que les couleurs des alligators qui les surveillent . Vous ne pouvez pas avoir un œuf bleu sans qu'il y ait un alligator bleu autour pour le garder.</p><p>Peux recréer cette famille ?</p>"
    "contenu-exercice" : "λh.λe.λf.(e (h e) f)"
    "contenu-eleve"    : ""
    "solution"         : "λh.(λe.(λf.(e (h e ) f ) ) ) "

  "5" :
    "titre"            : 'Manger'
    "texte"            : "<p>Attention, ça va se compliquer !</p><p>Voici deux familles, l'une à coté de l'autre. L'alligator vert est affamé, c'est sur et il y a cette famille jaune juste en face de lui... Comme elle semble appétissante ! La suite, tu la connais ?! Appuye sur le bouton 'Animer'.</p>"
    "contenu-exercice" : "(λh.λe.h e) (λa.a)"
    "contenu-eleve"    : ""
    "solution"         : "λe.(e ) "
    "animation"        : "yes"

  "5" :
    "titre"            : 'Manger'
    "texte"            : "<p>Attention, ça va se compliquer !</p><p>Voici deux familles, l'une à coté de l'autre. L'alligator vert est affamé, c'est sur et il y a cette famille jaune juste en face de lui... Comme elle semble appétissante ! La suite, tu la connais ?! Appuye sur le bouton 'Animer'.</p>"
    "contenu-exercice" : "λe.(λf.(e f ) ) λh.(h ) "
    "contenu-eleve"    : ""
    "solution"         : "λe.(e ) "
    "animation"        : "yes"
ALPHABET = "abcdefghijklmnopqrstuvwxyz"
[color_tab, var_tab, debug, infobox, id, parentheses, delta] = [ [], {}, false, true, 0, 0, 500 ]
ahead_vars = []
$ ->
  ###########################################################################################################################################################
  #Preparation html - Construction de la console
  ###########################################################################################################################################################
  do initialize_html = ->
    for key of EXERCICES
      $( '#exercices' ).append "<button class='panel-button exercice'  data-id='#{key}'>Ex#{key}</button>"
    for letter,index in ALPHABET[0..25]
      color_tab.push CSS_COLOR_NAMES[index]
      var_tab["#{letter}"] = CSS_COLOR_NAMES[index]
    html= ""
    for key,value of FUNCTION
      html += "<button id='#{key}' class='panel-button' data-type='fonction' data-lambda='#{value}'>#{key}</button>"
    $( "#console" ).prepend "#{html}<br>"
    html= ""
    for color,index in color_tab
      html+= "<div id='#{color}' class='color' style='background-color:#{color};' data-color='#{color}' data-variable='#{ALPHABET[index]}'>#{ALPHABET[index]}</div>"
    $( "#items" ).before html
    s = {"egg" : "0 0 116 80", "open" : "-25 0 330 150", "vieux" : "0 0 228 78"}
    
    $.get "css/svg/egg.svg", (rawSvg) -> 
      $("#egg-svg").append(document.importNode rawSvg.documentElement,true)
      $("#egg-svg svg")[0].setAttribute('viewBox', '0 0 116 80')
      $(".color:first()" ).trigger "click"
    , "xml"
    
    $.get "css/svg/open.svg", (rawSvg) -> 
      $("#open-svg").append(document.importNode rawSvg.documentElement,true)
      $("#open-svg svg")[0].setAttribute('viewBox', '-25 0 330 150')
      $(".color:first()" ).trigger "click"
    , "xml"
    $.get "css/svg/vieux.svg", (rawSvg) -> 
      $("#vieux-svg").append(document.importNode rawSvg.documentElement,true)
      $("#vieux-svg svg")[0].setAttribute('viewBox', '0 0 228 78')
    , "xml"
  ###########################################################################################################################################################
  #Initialisation des items, dialog, couleurs et panels
  ###########################################################################################################################################################
  #items oeuf, croco, vieux croco draggable
  $( "#infobox" ).on "click", -> 
    infobox = this.checked
    $(this).val(this.checked ? 1 : 0)
    
  $( "#slider-range-max" ).slider
    range: "max",
    min: 50,
    max: 6000,
    step: 500,
    value: 2000,
    slide: ( event, ui ) -> 
      $( "#amount" ).val( ui.value )
      delta = ui.value
  $( "#amount" ).val( $( "#slider-range-max" ).slider( "value" ) )
  
  $( "#command-panel" ).draggable()
  
  $( ".item" ).draggable
    helper : "clone"
    start:  (event, ui) -> $(ui.helper).addClass("ui-draggable-helper")
    stop : (event, ui) ->  $(this).show()
    #cursorAt : {top :  50, left : 150}
  #Conteneur de jeu
  $("#game-container").dialog
    show:  {effect: 'fade', duration: 2000}
    hide: "size"
    width : "100%"
    draggable: false
    height:  Math.floor(100 * $(window).height() / 100)
    open: -> $("body").addClass("stop-scrolling")
    close: -> $("body").removeClass("stop-scrolling")
  #Choix d'une couleur dans la palette
  $( ".color" ).on "click",  ->
    [color, variable] = [$(this).attr("data-color"),$(this).attr("data-variable")]
    $( "#choose-color" ).attr("data-variable", variable)
    $( "#choose-color" ).attr("data-color", color)
    $( "#panel-lambda" ).attr("data-variable", variable).html("λ#{variable}")
    $("#panel-variable").attr("data-variable", variable).html("#{variable}")
    $( "#egg-svg, #open-svg" ).find(".skin").css("fill", color)
    $( ".color" ).removeClass("selected-color" )
    $(this).addClass( "selected-color" )

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
      when "read"
        $("#prompt").val get_lambda_from $("#root")
   
  $('#prompt').keypress (key) ->
    insert_exp_into_div($( "#prompt").val(),$("#root")) if key.which is 13
    return false
  ###########################################################################################################################################################
  #Parser une expression
  ###########################################################################################################################################################
  get_lambda_from = (root) ->
    exp = root.clone()
    exp.find("svg").remove()
    exp.find(".definition_drop").remove()
    exp.find(".application_drop").remove()
    exp = exp.html()
    exp = exp.replace /<div id="\d*" class="variable dropped" data-variable="(\w+)" data-color="\w+"[ style="opacity: 1;"]*>\s*<\/div>/g, "$1 "
    exp = exp.replace /<div id="\d*" class="lambda dropped" data-variable="(\w+)" data-color="\w+"[ style="opacity: 1;"]*>/g, "λ$1.("
    exp = exp.replace /<div id="\d*" class="lambda priorite dropped" data-variable="\(" data-color="white"[ style="opacity: 1;"]*>/g, "("
    exp = exp.replace(/<\/div>/g , ") ")
  ###########################################################################################################################################################
  #Inserer une expression
  ###########################################################################################################################################################
  insert_exp_into_div = (exp, root) ->
    expression = exp
    id = 0
    #make it easy to retrieve variables
    expression = expression.replace /([.( ])([a-z])/g, "$1woot$2" 
    #lambdas
    local_debug = false
    while expression.match /λ/
      λ_index = 0
      while expression[λ_index] isnt "λ"
        λ_index += 1  
      λ_variable = λ_index+1
      current_index = λ_index+3
      switch expression[λ_index-1]     
        when "("
          alert "prototype : (λx. lambda ) = #{expression}" if local_debug
          parentheses = 1
          while ((parentheses > 0) and (current_index < expression.length) and (expression[current_index] isnt "<"))
            switch expression[current_index]
              when "("
                parentheses +=1
              when ")"
                parentheses -=1
            current_index +=1
          alert "I got this : #{expression.substring(λ_index-1,current_index)}" if local_debug
          expression = expression.replace expression.substring(λ_index-1, current_index), "<div id='' class='lambda dropped' data-variable='#{expression[λ_variable]}' data-color=''>#{expression.substring(λ_index+3,current_index-1)}</div>"
          continue
        else 
          switch expression[current_index]
            when "("
              alert "prototype : λx.(lambda) = #{expression}" if local_debug
              parentheses = 1
              while ((parentheses > 0) and (current_index < expression.length) and (expression[current_index] isnt "<"))
                current_index += 1
                switch expression[current_index]
                  when "("
                    parentheses +=1
                    continue
                  when ")"
                    parentheses -=1
                    continue
                  else
                    continue
              alert "I got this : #{expression.substring(λ_index,current_index+1)}" if local_debug
              expression = expression.replace expression.substring(λ_index,current_index+1), "<div id='' class='lambda dropped' data-variable='#{expression[λ_variable]}' data-color=''>#{expression.substring(λ_index+4,current_index)}</div>"
              continue 
            else
              alert "prototype : λx.lambda = #{expression}" if local_debug
              
              while ((expression[current_index] isnt "<") and (current_index < expression.length))
                current_index += 1
              alert "I got this : #{expression.substring(λ_index,current_index)}" if local_debug
              expression = expression.replace expression.substring(λ_index,current_index), "<div id='' class='lambda dropped' data-variable='#{expression[λ_variable]}' data-color=''>#{expression.substring(λ_index+3,current_index)}</div>"
              continue           
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
      $( this ).attr "id", "#{id += 1}"
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

  ###########################################################################################################################################################
  #Construction graphique
  ###########################################################################################################################################################
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
  ###########################################################################################################################################################
  #gestion d'une etape
  ###########################################################################################################################################################  
  
  promises = []  

  looping = false
 
  $( "#go" ).on "click", -> 
    looping = false
    go_one_step("#root")
  
  $( "#repeat" ).on "click", ->
    looping = true
    go_one_step("#root")
  
  $("#stop").click () ->   
    looping = false
    $( "#slider-range-max" ).slider( "option", "disabled", false )    
        
  
        
  $( "#help" ).dialog
    autoOpen    : false
    dialogClass : "noTitleStuff"
    width       : "auto"
    minHeight   : 0
    open        : -> delay Math.floor (delta/2), -> $( "#help" ).dialog( "close" )
    autoResize: true
  help = (message, element) ->
    $( "#help" ).dialog "option",
      position :
        my: "left bottom"
        at: "center top"
        of: "##{element}"
    $( "#help" ).html message
    $( "#help" ).dialog( "open")    

  
  find_action_pointer = (root) ->
    local_debug = false
    ahead_vars = []
    pointer = $(root).children(".lambda:first()")
    stay = true
    # Top-left RULE
    while ((stay) and (pointer.length))
      alert "stay for a loop with #{pointer.attr('data-variable')}" if local_debug
      #On tombe sur un croco blanc
      if (pointer.hasClass "priorite")
        alert "Croco blanc !" if local_debug
        #il y a des crocos de couleurs dessous
        if pointer.children(":not(svg)").length is 1
          #il n'y en a qu'un -> ce croco blanc ne sert à rien
          stay = false
        else
          pointer = pointer.children(".lambda:first()")
        continue
      #On tombe sur un croco de couleur
      if (pointer.hasClass "lambda") and (not pointer.hasClass "priorite")
        alert "Croco #{pointer.attr('data-variable')} !" if local_debug
        ahead_vars.push pointer.attr("data-variable")
        if pointer.next().length > 0
          ahead_vars.pop()
          stay = false
        else
          if pointer.find(".lambda").length > 0
              pointer = pointer.find(".lambda").first()
        continue
      # On tombe sur un oeuf
      if (pointer.hasClass "variable")      
        alert "Oeuf #{pointer.attr('data-variable')} !" if local_debug
        ahead_vars.push pointer.attr("data-variable")  
        pointer = pointer.next()
        continue
    return pointer
  
  color_rule_check = (pointer) ->
    application = pointer.next()
    get_vars = (tree) ->
      palette = []
      tree.find( "[data-variable]" ).andSelf().filter("[data-variable]").not(".lambda.priorite").each -> 
        palette.push $( this ).attr("data-variable")
      palette.unique()
    [function_vars, application_vars] = [get_vars( pointer ), get_vars( application )]
    #On regarde s'il y a des couleurs en commun
    intersect = (a,b) -> a.filter (n) -> b.indexOf(n) isnt -1
    intersection = intersect(application_vars, function_vars)
    
    #Mais on ne doit pas prendre celle qui se trouvaient au dessus dans la fonction
    intersection = (item for item in intersection when item not in ahead_vars)  
    #alert "[#{function_vars}], [#{application_vars}], [#{intersection}]"
    return [function_vars, application_vars, intersection]
    
  go_one_step = (root) ->
    root = "#root"
    local_debug = false 
    $( "#{root} .application_drop, #{root} .definition_drop" ).remove()
    $(root).find( ".dropped" ).each (i = 0) -> $(this).attr "id", id+=1
    
    step1 = $.Deferred()
    step2 = $.Deferred()
    step3 = $.Deferred()
    step4 = $.Deferred()
    
    #STEP 2 : regle du vieil alligator inutile
    step1.done (pointer) ->  
      if (pointer.hasClass "priorite") and (pointer.children(":not(svg)").length < 2)
        help( "Ce vieil alligator ne sert plus à rien !", pointer.attr "id") if infobox
        pointer.find("svg").first().find("g#layer1").attr("transform", "rotate(180,140,65)").animate {opacity : 0 }, delta, ->
          $(this).closest(".lambda.priorite").replaceWith $(this).closest(".lambda.priorite").contents()
          $(this).closest("svg").remove()
          step2.resolve(pointer)
      else
        step2.resolve(pointer)

    
    #STEP 3 : regle de la couleur
    step2.done (pointer) ->
      [function_vars, application_vars, intersection] = color_rule_check(pointer)
      if intersection.length > 0
        application = pointer.next()
        palette = (item for item in ALPHABET when item not in function_vars.concat application_vars)
        palette = palette[0..intersection.length-1]    
        #Pour chacune des couleurs de la fonction on va echanger dans l'application avec une couleur disponible de la palette
        for $var, index in intersection
          found = application.find( "[data-variable='#{$var}']").andSelf().filter("[data-variable='#{$var}']")
          n = found.length
          found.attr("data-variable", palette[index])
          found.find("> svg").each ( index2 ) ->
            help( "Règle de la couleur", $(this).closest(".dropped").attr("id") ) if infobox
            $(this).hide().show "slow", ->
              step3.resolve(pointer) if index2 is n-1 
            $(this).find(".skin").css("fill", var_tab[palette[index]]) 
      else
        step3.resolve(pointer)
    #STEP 4 : regle du mangeage d'application
    step3.done (pointer) ->
      if (pointer.hasClass "lambda") and (pointer.attr("data-color") isnt "white") and (pointer.next().length > 0)
        #on retire la variable courante des variables precedemment rencontrées
        ahead_vars.pop()
        variable = pointer.attr("data-variable")
        application = pointer.next()
        applicationClone = application.clone()
        help("Manger", pointer.attr "id") if infobox
        j = 0
        if delta > 0
          bust_a_move = interval 50, -> pointer.children("svg").css("z-index":"9000").find("#jaw").attr("transform", "rotate(#{-10+Math.floor 6*Math.cos(j++)}) translate(-100,20)")
        application = pointer.next()
        application.css('visibility','hidden')
          .clone().prependTo(pointer)
          .css({"z-index" : "-1",border:"dashed black 1px",visibility:"visible",position:"absolute",top:"0px",left:"100%"})
          .animate {"min-width":"0px",padding:"0px", height: '1vw', width: "1vw", top:"0", left:"60%"} , delta, ->
            #On fait disparaitre l'application et son clone
            $(this).find("> svg").remove() 
            $(this).remove() 
            application.find("> svg").remove() 
            application.remove()
            clearInterval bust_a_move if delta > 0
            pointer.children("svg").find("g#layer1").attr("transform", "rotate(180 125 75)")
            help("Partir", pointer.attr "id") if infobox
            pointer.children("svg").animate {"opacity" : 0}, delta, ->
              $(this).closest("svg").remove()
              step4.resolve(pointer, applicationClone)
      else
        go_one_step(root) if looping
      
    
    #STEP 5 : regle de l'eclosion des oeufs
    step4.done (pointer, application) ->
      #On va faire reapparaitre l'application à chaque oeuf
      variable = pointer.attr "data-variable"
      help("éclosion", pointer.attr "id") if infobox
      eggs = pointer.find( ".variable[data-variable=#{variable}]"  )
      n = eggs.length
      if n>0
        def_clone = $.Deferred()
        def_egg = $.Deferred()
        eggs.each (index, element) ->
          $(this).animate { opacity: 0} , delta, ->
            $(this).find("> svg").remove() 
            $(this).remove()
            if index is n-1
              def_egg.resolve()  
          $(this).after application.clone().css(opacity: 0).animate {opacity: 1}, delta, ->
            if index is n-1
              pointer.find("> svg").remove() 
              pointer.replaceWith pointer.contents()
              def_clone.resolve()
          
        $.when(def_egg,def_clone).done -> go_one_step(root) if looping
      else
        help( "Aucun oeuf", pointer.attr "id") if infobox
        pointer.find("> svg").remove()
        pointer.replaceWith pointer.contents()
        go_one_step(root) if looping

    #STEP 1 : 
    action_croco = find_action_pointer root
    if action_croco.length > 0
      step1.resolve(action_croco)
    else
      alert "over"
    
      
      ###########################################################################################################################################################
  # Gestion du jeu
  ###########################################################################################################################################################  
  $( "#console" ).toggle()     
  $( "#toggle-console" ).on "click", -> $( "#console" ).toggle()
  #Exercice
  $( "#exercice").hide()
  $( ".exercice").on "click", () ->
    i = $( this ).attr( "data-id" )
    exo = EXERCICES[i]
    $( "#exercice").find(" > .panel-button.exercice").attr "data-id", i
    $( "#exercice").attr "data-solution", exo["solution"]
    $( "#exercice").find("> .titre" ).html("<h1>#{exo['titre']}</h1>")
    $( "#exercice").find(" > .texte" ).html("<p>#{exo['texte']}</p>")
    if exo["contenu-eleve"] isnt ""
      insert_exp_into_div(exo["contenu-eleve"], $("#root"))
    else
      $("#root" ).empty().append "<div id='root_definition' class='definition_drop'></div>"
    insert_exp_into_div exo["contenu-exercice"], $( "#contenu-exercice" ) if exo["contenu-exercice"] isnt "" 
    if exo["animation"] is "yes" then $( "#animation").show() else $( "#animation").hide()
  
    $( "#exercice").show().draggable()
  
    $( "#animation" ).on "click", -> go_one_step( "#contenu-exercice" )
       
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
