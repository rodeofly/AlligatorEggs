Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms
sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms
nb_exemple = 9
[debug, id] = [true, 1000]
color_tab = ['purple','blue','LightBlue','red','orange','brown','green','LightGreen','yellow','pink','grey']

$ ->
  for i in [1..nb_exemple]
    $( "#buttons-panel").append "<button id='ex-#{i}' class='load-example' data-div='exemple-#{i}'>Ex #{i}</button>"
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
    console.log "You choose " +  $("#choose-color").data("color") if debug

  #On rend l'alligator et l'oeuf blanc draggable, il prendront la couleur preselectionnée 
  $( ".item" ).draggable
    helper : "clone"
    appendTo : "#buttons-panel"
  
  #Achaque fois qu'on droppe un item, il y a une(variable) ou deux(lambda) zones draggables
  make_it_droppable = () ->
    $( ".application_drop, .definition_drop" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".croco, .vieux-croco, .egg"
      drop : ( event, ui ) ->
        $( this ).parent(":first").removeClass("parentHighlight")
        if ui.draggable.hasClass("vieux-croco")
          variable = 'white'
        else 
          variable =  $("#choose-color").data("color")
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
        console.log "a " + $( lambda ).data("variable") + " has been dropped !" if debug
        make_it_droppable()

  make_root_droppable = ->  
    $( "#root" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".croco, .vieux-croco"
      drop : ( event, ui ) ->
          if ui.draggable.hasClass( "croco" )
            variable =  $("#choose-color").data("color")
          else
            variable = 'white'
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
          console.log "a " + $( lambda ).data("variable") + " has been dropped !" if debug
          make_it_droppable()
  make_root_droppable()
      
  $( "#clear" ).on "click", ->  
    $("#root" ).empty()
    make_root_droppable()
    
  $( "#go" ).on "click", ->
    $( ".application_drop, .definition_drop" ).remove()  
    
    # Top-left RULE
    ahead_color = ['white']
    pointer = $("#root > .lambda:first") 
    while (not pointer.siblings().length or pointer.data("variable") is 'white')
      current_color = pointer.data("variable")
      ahead_color.push current_color
      if pointer.data("variable") isnt "white"
        pointer = pointer.find(".lambda").first()
        if not pointer.length
          alert "Là ça change pas !"
          break
      else
        if pointer.children().length is 1
          alert "creve pourriture communiste !"
          pointer.after pointer.children()
          pointer.remove()
          pointer = $("#root > .lambda:first") 
        else
          pointer = pointer.find(".lambda").first()
    ahead_color = ahead_color.unique()
    variable = pointer.data("variable")
    
    color_rule_check = (func, app) ->
      get_colors = (tree) ->
        palette = []
        tree.find( "[data-variable]" ).andSelf().filter("[data-variable]").each ->
          palette.push $( this ).data("variable")
        palette.unique()
      #On va lister les couleurs utilisées dans la definition de la fonction
      func_colors = get_colors func
      #On verifie en suite que chacune des couleurs de la fonction ne se retrouve pas dans l'application
      for color in func_colors
        app_items = app.find( "[data-variable='#{color}']").andSelf().filter("[data-variable='#{color}']")
        # Aie ! On en a trouvé
        if app_items.length
          alert "Règle de la couleur !"
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
    
    application = pointer.siblings().first()
    color_rule_check(pointer, application)
    applicationClone =  application.clone()

    
    bust_a_move = (timer, croco) ->
      j=0
      images = ["alligator","vieil-alligator"]
      bustit = interval 250, -> 
        j += 1
        croco.css "background-image": "url(css/img/#{images[j%2]}-#{variable}.png)"
      delay timer, -> 
        clearInterval bustit
        croco.css
          "background-image":"url(css/img/alligator-dead.png)"
          "background-color": "#{croco.data('variable')}"
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
                if index is n-1
                  pointer.replaceWith pointer.contents()
        else 
            alert "Aucun oeuf !"
            pointer.replaceWith pointer.contents()
        
  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)

    
  $( ".load-example" ).on "click", ->  
    div = $(this).attr("data-div")
    $("#root" ).empty().append $( "##{div}" ).html()
     
  