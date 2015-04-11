Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms

nb_exemple = 9
[debug, id] = [true, 1000]
color_tab = ['purple','blue','LightBlue','red','orange','brown','green','LightGreen','yellow','pink','grey']
var_tab = {'x':'purple','y':'blue','z':'LightBlue','m':'red','n':'orange','p':'brown','q':'green','a':'LightGreen','b':'yellow','c':'pink','s':'grey'}
lambda_exemples = ["(λx.x) (λy.y)","(λx.λy.x) (λy.y)","((λy.y) (λz.z))(λx.x)","(λx.λy. x) a b","(λx.λy. y) a b","(λa. a (λm.(λn. n ))(λp.(λq. p )))(λx.λy. y) a b","(λx.x x) (λx.x x)","λy.(λx.y (x x)) (λx.y (x x))","(λa.λs.λz.s (a s z)) (λs.λz.z) ","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s z)) (λs.λz.(s z))","(λa.λb.λs.λz.(a s (b s z))) (λs.λz.(s (s (s z)))) (λs.λz.(s (s (s (s z)))))"]
$ ->
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
    html = 
    """
      <img src='css/img/vieil-alligator-#{color}.png'/>
      <img src='css/img/alligator-#{color}.png' />
      <img src='css/img/egg-#{color}.png' />
    """
    $( "#preloaded-images" ).append html
    
  #Choix d'une couleur dans la palette
  $( ".color" ).on "click", ->
    $( "#choose-color" ).data("color", $(this).data("color"))
    $( ".color" ).removeClass("selected-color" )
    $( this ).addClass( "selected-color" )

  #On rend l'alligator et l'oeuf blanc draggable, il prendront la couleur preselectionnée 
  $( ".item" ).draggable  helper : "clone"
  
  #Achaque fois qu'on droppe un item, il y a une(variable) ou deux(lambda) zones draggables
  make_dropped_droppable = () ->
    $( ".application_drop, .definition_drop" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".croco, .vieux-croco, .egg"
      drop : ( event, ui ) ->
        $( this ).parent(":first").removeClass("parentHighlight")
        variable = if ui.draggable.hasClass("vieux-croco") then 'white' else $("#choose-color").data("color")
        if ui.draggable.hasClass("croco") or ui.draggable.hasClass("vieux-croco")
          lambda = 
          """
            <div id='#{id++}' style='background: url(css/img/alligator-#{variable}.png) top center no-repeat;' class='lambda dropped' data-variable='#{variable}' >
            <div class='definition_drop'></div>
            <div class='application_drop'></div>
            </div>
          """
        else
          lambda = 
          """
            <div id='#{id++}' style='background: url(css/img/egg-#{variable}.png) top center no-repeat;' class='variable dropped' data-variable='#{variable}' >
            <div class='application_drop'></div>
            </div>
          """
        if $( this ).hasClass( "definition_drop" )
          $(this).before lambda
        else
          $(this).parent().after lambda
        $(this).remove()
        make_dropped_droppable()

  do make_root_droppable = ->
    $("#root" ).empty()
    $( "#root" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".croco, .vieux-croco"
      drop : ( event, ui ) ->
          variable = if ui.draggable.hasClass( "croco" ) then $("#choose-color").data("color") else 'white'
          lambda = 
          """
            <div id='#{id++}' style='background: url(css/img/alligator-#{variable}.png) top center no-repeat;' class='lambda dropped' data-variable='#{variable}' >
              <div class='definition_drop'></div>
              <div class='application_drop'></div>
           </div>
          """
          $( this )
            .append(lambda)
            .droppable("destroy")
          make_dropped_droppable()
      
  $( "#clear" ).on "click", ->  make_root_droppable()
  $( "#go" ).on "click", -> 
    $( ".application_drop, .definition_drop" ).remove()   
    #Listes de couleurs reservées et donc interdites pour application
    ahead_color = ['white']
    # Top-left RULE
    pointer = $("#root > .lambda:first") 
    while (not pointer.next().length or pointer.data("variable") is 'white')
      current_color = pointer.data("variable")
      ahead_color.push current_color
      if pointer.data("variable") isnt "white"
        pointer = pointer.find(".lambda").first()
        if not pointer.length
          alert "Là ça change pas !"
          break
      else
        if pointer.children().length is 1
          pointer.css "background-image":"url(css/img/alligator-dead.png)"
          alert "Oh il ne sert plus à rien le pauvre !"
          pointer.replaceWith pointer.contents()
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
          alert "Règle de la couleur !(Color rule)"
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
                if $( this ).hasClass( "lambda" )
                  $( this ).css {"background-image": "url(css/img/alligator-#{new_color}.png)"}
                else
                  $( this ).css {"background-image": "url(css/img/egg-#{new_color}.png)"}
                $( this ).css {"background-position" : "top center no-repeat;"}
          alert "C'est vu ?"
          break       
    # On recupere l'application, eventuellement on change de couleur et on la clone parce qu'elle va degager
    application = pointer.next()
    color_rule_check(pointer, application)
    applicationClone =  application.clone()
    #Animation du croco qui bouffe
    bust_a_move = (timer, croco,j=0) ->
      images = ["alligator","vieil-alligator"]
      bustit = interval 250, -> 
        j += 1
        croco.css "background-image": "url(css/img/#{images[j%2]}-#{variable}.png)"
      delay timer, -> 
        clearInterval bustit
        croco.css {"background-image":"url(css/img/alligator-dead.png)","background-color": "#{croco.data('variable')}"}
    bust_a_move 4000, pointer
    application.css('visibility','hidden').clone().prependTo(pointer).css({"z-index" : "-1",border:"dashed black 10px",visibility:"visible",position:"absolute",top:"0px",left:"100%"}).animate {"min-width":"0px",padding:"0px", height: '50px', width: "50px", top:"50px", left:"70%"} , 4000, ->
        #On fait disparaitre l'application
        $(this).remove()
        application.remove()
        #On va faire reapparaitre l'application à chaque oeuf
        eggs = pointer.find( ".variable[data-variable=#{variable}]"  )
        n = eggs.length;
        if n>0
          eggs.each (index, element) ->        
            $(this).animate { opacity: 0} , 2000, ->
                $(this).after applicationClone.clone()
                $(this).remove()
                pointer.replaceWith pointer.contents() if index is n-1              
        else 
            alert "Aucun oeuf !(no egg)"
            pointer.replaceWith pointer.contents()
            
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
        $("#root").empty()
        $( "#prompt" ).val("")
      when "exemple"
        $("#prompt").val lambda_exemples[$(this).data("numero")]
        e = jQuery.Event("keypress")
        e.which = 13
        $('#prompt').trigger(e)
      when "auto"
         while parentheses
          expression += "</div>"
          $( "#prompt").val($( "#prompt").val() + ")")
          parentheses -= 1
  #Parser une expression
  $('#prompt').keypress (e) ->
    key = e.which;
    if key is 13
      [extra_lambda, div_open, html, exp] = [0, 0, "", $( "#prompt").val()]
      for i in [0..exp.length-1]
        if jump_on_next
          jump_on_next=false
          continue         
        switch exp[i]
          when "."," "
            continue
          when "λ"
            [jump_on_next, j] = [true, i]        
            div_open +=1
            while exp[j+3] is "λ"
              extra_lambda += 1
              j += 3
            variable = exp[i+1]
            html += "<div id='#{id++}' style='background: url(css/img/alligator-#{var_tab[exp[i+1]]}.png) top center no-repeat;' class='lambda dropped' data-variable='#{var_tab[exp[i+1]]}'>"
          when 'x','y','z','m','n','p','q','a','b','c','s'
            html += "<div id='#{id++}' style='background: url(css/img/egg-#{var_tab[exp[i]]}.png) top center no-repeat;' class='variable dropped' data-variable='#{var_tab[exp[i]]}'></div>"
          when "("
            parentheses += 1
            if exp[i+1] is "λ"
              continue
            else
              html += "<div id='#{id++}' style='background: url(css/img/alligator-white.png) top center no-repeat;' class='lambda dropped' data-variable='white'>"
          when ")"
            parentheses -= 1
            html += "</div>"
            if parentheses is 0
              while extra_lambda
                extra_lambda -= 1
                html += "</div>"
      $("#root" ).empty().append html
      return false   
  #Pour l'article 
  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)