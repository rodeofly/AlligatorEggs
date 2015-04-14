Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms
nb_exemple = 9
[debug, id] = [true, 1000]
CSS_COLOR_NAMES = ["Blue","BlueViolet","Brown","BurlyWood","CadetBlue","Chartreuse","Chocolate","Coral","CornflowerBlue","Cornsilk","Crimson","Cyan","DarkBlue","DarkCyan","DarkGoldenRod","DarkGray","DarkGreen","DarkKhaki","DarkMagenta","DarkOliveGreen","Darkorange","DarkOrchid","DarkRed","DarkSalmon","DarkSeaGreen","DarkSlateBlue","DarkSlateGray","DarkSlateGrey","DarkTurquoise","DarkViolet","DeepPink","DeepSkyBlue","DimGray","DimGrey","DodgerBlue","FireBrick","FloralWhite","ForestGreen","Fuchsia","Gainsboro","GhostWhite","Gold","GoldenRod","Gray","Grey","Green","GreenYellow","HoneyDew","HotPink","IndianRed","Indigo","Ivory","Khaki","Lavender","LavenderBlush","LawnGreen","LemonChiffon","LightBlue","LightCoral","LightCyan","LightGoldenRodYellow","LightGray","LightGrey","LightGreen","LightPink","LightSalmon","LightSeaGreen","LightSkyBlue","LightSlateGray","LightSlateGrey","LightSteelBlue","LightYellow","Lime","LimeGreen","Linen","Magenta","Maroon","MediumAquaMarine","MediumBlue","MediumOrchid","MediumPurple","MediumSeaGreen","MediumSlateBlue","MediumSpringGreen","MediumTurquoise","MediumVioletRed","MidnightBlue","MintCream","MistyRose","Moccasin","NavajoWhite","Navy","OldLace","Olive","OliveDrab","Orange","OrangeRed","Orchid","PaleGoldenRod","PaleGreen","PaleTurquoise","PaleVioletRed","PapayaWhip","PeachPuff","Peru","Pink","Plum","PowderBlue","Purple","Red","RosyBrown","RoyalBlue","SaddleBrown","Salmon","SandyBrown","SeaGreen","SeaShell","Sienna","Silver","SkyBlue","SlateBlue","SlateGray","SlateGrey","Snow","SpringGreen","SteelBlue","Tan","Teal","Thistle","Tomato","Turquoise","Violet","Wheat","White","WhiteSmoke","Yellow","YellowGreen"]
ALPHABET = "abcdefghijklmnopqrstuvwxyz"
color_tab = []
var_tab = {}
lambda_exemples = ["(λx.x) (λy.y)","(λx.λy.x) (λy.y)","((λy.y) (λz.z))(λx.x)","(λx.λy. x) a b","(λx.λy. y) a b","(λa. a (λm.(λn. n ))(λp.(λq. p )))(λx.λy. y) a b","(λx.x x) (λx.x x)","λy.(λx.y (x x)) (λx.y (x x))","(λa.λs.λz.s (a s z)) (λs.λz.z) ","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s z)) (λs.λz.(s z))","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s (s (s z)))) (λs.λz.(s (s (s (s z)))))"]
$ ->
  for letter,index in ALPHABET[0..25]
    color_tab.push CSS_COLOR_NAMES[index]
    var_tab["#{letter}"] = CSS_COLOR_NAMES[index]

  $.get "css/img/egg.svg", (rawSvg) -> 
    importedSVGRootElement = document.importNode rawSvg.documentElement,true
    $("#egg-svg").hide().append(importedSVGRootElement)
  , "xml"
  
  $.get "css/img/open.svg", (rawSvg) -> 
    importedSVGRootElement = document.importNode rawSvg.documentElement,true
    $("#open-svg").hide().append(importedSVGRootElement)
  , "xml"
  
  $.get "css/img/vieux.svg", (rawSvg) -> 
    importedSVGRootElement = document.importNode rawSvg.documentElement,true
    $("#vieux-svg").hide().append(importedSVGRootElement)
  , "xml"

  #Preparation html
  #Construction du panel
  html = ""
  html+= "<button class='panel-button' data-type='lambda' data-variable='#{key}'>λ#{key}</button>" for key,value of var_tab
  html+= "<br>"
  html+= "<button class='panel-button' data-type='variable' data-variable='#{key}'>#{key}</button>" for key,value of var_tab
  $( "#lambda-panel" ).append html
  html= "<br>"
  html += "<button id='ex-#{i}' class='panel-button' data-type='exemple' data-numero='#{i}'>Ex #{i}</button>" for i in [0..lambda_exemples.length-1]
  $( "#lambda-panel" ).append html
  $( "#lambda-panel").dialog
    width : "auto"
  #Et pour faire apparaitre le panel
  $( "#prompt-mode" ).on "click", -> $( "#lambda-panel").dialog("open")  
  #Préchargement des images
  for color in color_tab
    $( "#choose-color" ).append "<div class='color' style='background-color:#{color};' data-color='#{color}'></div>"
    ###html = 
    """
      <img src='css/img/vieil-alligator-#{color}.png'/>
      <img src='css/img/alligator-#{color}.png' />
      <img src='css/img/egg-#{color}.png' />
    """
    $( "#preloaded-images" ).append html
   ### 
  #Choix d'une couleur dans la palette
  $( ".color" ).on "click", ->
    $( "#choose-color" ).data("color", $(this).data("color"))
    $( ".color" ).removeClass("selected-color" )
    $( this ).addClass( "selected-color" )
    
  $( ".item" ).draggable  helper : "clone"
  
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
  
  #Achaque fois qu'on droppe un item, il y a une(variable) ou deux(lambda) zones draggables
  make_dropped_droppable = () ->
    $( ".application_drop, .definition_drop" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".croco, .vieux-croco, .egg"
      drop : ( event, ui ) ->
        inserer ui.draggable, $(this)
        make_dropped_droppable()

  make_dropped_droppable()
          
  speed = false
  $( "#go" ).on "click", -> 
    delta = if speed then 500 else 2000
    $( ".application_drop, .definition_drop" ).remove()   
    #Listes de couleurs reservées et donc interdites pour application
    ahead_color = ['white']
    # Top-left RULE
    pointer = $("#root > .lambda:first") 
    while (not pointer.next(":not(svg)").length or pointer.data("variable") is 'white')
      current_color = pointer.data("variable")
      ahead_color.push current_color
      if pointer.data("variable") isnt "white"
        pointer = pointer.find(".lambda").first()
        if not pointer.length
          alert "Là ça change pas !" if not speed
          break
      else
        if pointer.children(":not(svg)").length is 1
          pointer.children("svg").find("g#layer1").attr("transform", "rotate(180 149 60)")
          alert "Oh il ne sert plus à rien le pauvre !" if not speed
          pointer.children().unwrap().siblings("svg").remove()
          pointer = $("#root > .lambda:first") 
        else
          pointer = pointer.find(".lambda").first()
    
    #Paré pour la regle de la couleur, on a la couleur de base et l'ensemble de coueleurs reservées !
    ahead_color = ahead_color.unique()
    variable = pointer.data("variable")
    
    color_rule_check = (func, app) ->
      get_colors = (tree) ->
        palette = []
        tree.find( "[data-variable]" ).andSelf().filter("[data-variable]").each -> palette.push $( this ).data("variable")
        palette.unique()
      #On va lister les couleurs utilisées dans la definition de la fonction
      func_colors = get_colors func
      #On verifie en suite que chacune des couleurs de la fonction ne se retrouve pas dans l'application
      for color in func_colors
        app_items = app.find( "[data-variable='#{color}']").andSelf().filter("[data-variable='#{color}']")
        # Aie ! On en a trouvé
        if app_items.length
          alert "Règle de la couleur !(Color rule)" if not speed
          #Alors on va lister toutes les couleurs de l'application
          app_colors = get_colors app
          #On fabrique donc un ensemble de couleurs qu'on ne peut pas utiliser
          used_colors = (func_colors.concat app_colors.concat ahead_color).unique()
          #Et on prend autant de couleurs dans la palette qu'il y en a dans la fonction
          difference = (item for item in color_tab when item not in used_colors)
          difference = difference[0..app_colors.length-1]
          #Pour chacune des couleurs de la fonction on va echanger dans l'application avec une couleur disponible de la palette
          for new_color, index in difference            
            app.find( "[data-variable=#{app_colors[index]}]").andSelf().filter("[data-variable=#{app_colors[index]}]").each ->
              if $( this ).attr("data-variable") not in ahead_color
                $( this ).attr("data-variable", new_color)
                $( this ).find(".skin").css("fill", new_color)
          alert "C'est vu ?" if not speed
          break       
    # On recupere l'application, eventuellement on change de couleur et on la clone parce qu'elle va degager
    application = pointer.next()
    color_rule_check(pointer, application)
    applicationClone =  application.clone()
    application.css('visibility','hidden').clone().prependTo(pointer).css({"z-index" : "-1",border:"dashed black 10px",visibility:"visible",position:"absolute",top:"0px",left:"100%"}).animate {"min-width":"0px",padding:"0px", height: '50px', width: "50px", top:"50px", left:"70%"} , delta, ->
        #On fait disparaitre l'application
        removal = (myNode)->
          while (myNode.firstChild)
            myNode.removeChild(myNode.firstChild)
          myNode.remove()
        $(this).remove()
        application.remove()
        pointer.children("svg").find("g#layer1").attr("transform", "rotate(180 150 62)")
        #On va faire reapparaitre l'application à chaque oeuf
        eggs = pointer.find( ".variable[data-variable=#{variable}]"  )
        n = eggs.length;
        if n>0
          eggs.each (index, element) ->                      
            $(this).after applicationClone.clone().css(opacity: 0).animate {opacity: 1}, delta, ->
              pointer.children().unwrap().siblings("svg").remove() if index is n-1
            $(this).animate { opacity: 0} , delta, ->
              $(this).remove()
        else 
          alert "Aucun oeuf !(no egg)" if not speed
          pointer.children().unwrap().siblings("svg").remove()




  #Gestion du panel
  [expression, parentheses] = ["",0]
  $( ".panel-button" ).on "click", ->
    switch $( this ).data("type")
      when "lambda"
        variable = $( this ).data("variable")
        expression += "<div id='#{id++}' style='background: url(css/img/alligator-#{var_tab[variable]}.png) top center no-repeat;' class='lambda dropped' data-variable='#{var_tab[variable]}'>"
        $( "#prompt").val($( "#prompt").val() + "(λ#{variable}.")
        parentheses += 1
      when "variable"
        variable = $( this ).data("variable")
        expression += "<div id='#{id++}' style='background: url(css/img/egg-#{var_tab[variable]}.png) top center no-repeat;' class='variable dropped' data-variable='#{var_tab[variable]}'></div>"
        $( "#prompt").val($( "#prompt").val() + " #{variable} ")
      when "open"
        expression += "<div id='#{id++}' style='background: url(css/img/alligator-white.png) top center no-repeat;' class='lambda dropped' data-variable='white'>"
        $( "#prompt").val($( "#prompt").val() + "(")
        parentheses += 1
      when "close"
        expression += "</div>"
        $( "#prompt").val($( "#prompt").val() + ")")
        parentheses -= 1
      when "go"
        $("#root").empty().append expression
      when "clear"
        [expression, parentheses] = ["",0]
        $("#root" ).empty().append "<div id='root_definition' class='definition_drop'></div>"
        make_dropped_droppable()
        $( "#prompt" ).val("")
      when "exemple"
        $("#prompt").val lambda_exemples[$(this).data("numero")]
        e = jQuery.Event("keypress")
        e.which = 13
        $('#prompt').trigger(e)
      when "autoclose"
         while parentheses
          expression += "</div>"
          $( "#prompt").val($( "#prompt").val() + ")")
          parentheses -= 1
      when "speed"
        if $(this).data "speed"
          speed = false
          $(this).data "speed", false
          $(this).html "Go Slow"
        else
          speed = true
          $(this).data "speed", true
          $(this).html "Go Fast"

  
  inserer_direct = (type, droppable,mode) ->  
    variable = if type is "lambda priorite" then 'white' else $("#choose-color").attr("data-color")
    lambda = "<div id='#{id++}' class='#{type} dropped' data-variable='#{variable}' ></div>"
    lambda = $('<div/>').html(lambda).contents()
    switch type
      when "variable"
        $( "#egg-svg").find(".skin").css("fill",variable)
        $( "#egg-svg").clone().contents().prependTo $(lambda)
      when "lambda"
        $( "#open-svg").find(".skin").css("fill",variable)
        $( "#open-svg").clone().contents().prependTo $(lambda)
      when "lambda priorite"
        $( "#vieux-svg").clone().contents().prependTo $(lambda)       
    if mode is "definition"
      droppable.append $(lambda)
    else
      droppable.after $(lambda)
      
  #Parser une expression
  $('#prompt').keypress (e) ->
    local_debug = false
    key = e.which;
    if key is 13
      $("#root" ).empty()
      exp = $( "#prompt").val()
      pointer = $("#root" )
      alert "start: " + pointer.attr("id") if local_debug
      first =true
      parentheses = []
      symbol = ""
      previous = "none"
      for i in [0..exp.length-1]
        symbol += exp[i]
        alert symbol if local_debug
        switch symbol
          when "(","λa.","λb.","λc.","λd.","λe.","λf.","λg.","λh.","λi.","λj.","λk.","λl.","λm.","λn.","λo.","λp.","λq.","λr.","λs.","λt.","λu.","λv.","λw.","λx.","λy.","λz.","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
            if symbol is "("
              if previous is "("
                parentheses.push pointer
                alert "skip (, pushed current pointer:"+ pointer.attr("id") if local_debug
                previous = symbol
                symbol = ""
                continue
                
              $( "#choose-color" ).attr("data-color", "white")
              type = "lambda priorite"
              classe = ".lambda.priorite"
            else if ALPHABET.indexOf(symbol) > -1
              $( "#choose-color" ).attr("data-color", var_tab[symbol[0]])
              type = "variable"
              classe = ".variable"  
            else     
              $( "#choose-color" ).attr("data-color", var_tab[symbol[1]])
              type = "lambda"
              classe = ".lambda"
            alert "previous is : #{previous}" if local_debug
            switch previous
              when "(","λa.","λb.","λc.","λd.","λe.","λf.","λg.","λh.","λi.","λj.","λk.","λl.","λm.","λn.","λo.","λp.","λq.","λr.","λs.","λt.","λu.","λv.","λw.","λx.","λy.","λz."       
                alert "1" if local_debug
                inserer_direct type, pointer, "definition"
                alert "before error #{type} pointer is:"+ pointer.attr("id") if local_debug
                pointer = pointer.children().last(classe)
              when ")"
                alert "2"+pointer.attr("id") if local_debug
                inserer_direct type, pointer, "application"
                pointer = pointer.next(classe)
                alert "new pointer is:"+ pointer.attr("id") if local_debug
              else
                if first
                  alert "3" if local_debug
                  inserer_direct type, pointer, "definition"
                  pointer = pointer.find(classe).first()
                  first=false
                else
                  alert "4" if local_debug
                  inserer_direct type, pointer, "application"
                  pointer = pointer.next(classe)
            if symbol is "("
              parentheses.push pointer 
              alert "pushed current pointer:"+ pointer.attr("id") if local_debug
            alert "new pointer is:"+ pointer.attr("id") if local_debug
            previous = symbol
            symbol = ""
          when ")"
            alert ") pointer is:"+ pointer.attr("id") if local_debug
            pointer = parentheses.pop()
            alert ") pointer changed:"+ pointer.attr("id") if local_debug
            previous = symbol
            symbol = ""
          when " "
            symbol = ""
            continue
          else
            continue     
      return false   
  #Pour l'article 
  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)