Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms
#globals
[color_tab, ahead_vars, var_tab, debug, infobox, tags, id, delta] = [ [], [], {}, false, false, true, 0, 550 ]

ALPHABET = "abcdefghijklmnopqrstuvwxyz?"
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
  "Y"          : "(λr. ((λf.λg.λx. (f g g) x) r) ((λf.λg.λx. (f g g) x) r))"
  "FACT"       : " λr.((λf.(λg.(λx.( (f g g ) x ) ) ) r ) (λf.(λg.(λx.( (f g g ) x ) ) ) r ) ) λk.(λj.(((( λn.(n λx.(λa.(λb.(b ) ) ) λa.(λb.(a ) ) ) j ) λi.( λh.(λl.(h l ) ) ) λi.(( λs.(λt.(λu.( s (t u ) ) ) ) ) (r ( λc.(λd.(λe.(c λk.(λo.(o (k d ) ) ) λq.(e ) λq.(q ) ) ) ) n ) ) ) ) ) ) ) "
EXERCICES =
  "a" :
    "titre"            : 'Les items : "Le vieil alligator & les œufs"'
    "texte"            : "<p>Voilà un vieil alligator avec des œufs ! Le vieil alligator n'a plus faim, il a assez mangé.</p><p>Tous ce qu'il fait, c'est prendre soin de sa famille : ici ce sont des œufs !</p><p>Les œufs vont éclore et donner de nouvelles familles d'alligators.</p><p>Fais glisser un vieil alligator dans le panel, puis fais glisser le premier œuf sur le bout de la queue. Enfin, un à un, glisse des œufs les uns sur les autres pour les ajouter !</p>"
    "contenu-exercice" : "(f g h i i )"
    "contenu-eleve"    : ""
    "compte-rendu"     : "λ?"
    "solution"         : "(f g h i i ) "

  "b" :
    "titre"            : 'Les items : "Les alligators affamés"'
    "texte"            : "<p>Voilà des alligators affamés...Les alligators affamés sont voraces. Ils vont manger tout ce qui est en devant eux (au point de mourir d'indigestion)! Mais ils sont aussi des alligators responsables, et comme les vieux alligators, ils gardent leurs familles.</p><p>Allez fais glisser !</p>"
    "contenu-exercice" : "λx.(λy.(λz.() ) ) "
    "contenu-eleve"    : "λx.()"
    "compte-rendu"     : "λ?"
    "solution"         : "λx.(λy.(λz.() ) ) "

  "c" :
    "titre"            : 'Les familles (1)'
    "texte"            : "<p>Voici une petite famille : un alligator garde son œuf !</p><p>Peux tu la recréer ?</p>"
    "contenu-exercice" : "λe.e"
    "contenu-eleve"    : ""
    "compte-rendu"     : "λ?"
    "solution"         : "λe.(e ) "

  "d" :
    "titre"            : 'Les familles (2)'
    "texte"            : "<p>Voici une petite famille un peu plus grande.</p><p>Un alligator garde un autre alligator qui garde deux œufs. Ou on peut dire qu'un alligator garde un autre alligator qui est gardien des deux œufs.</p><p>Peux tu la recréer ?</p>"
    "contenu-exercice" : "λe.λf.e f"
    "contenu-eleve"    : ""
    "compte-rendu"     : "λ?"
    "solution"         : "λe.(λf.(e f ) ) "
    
  "e" :
    "titre"            : 'Les familles (3)'
    "texte"            : "<p>Voici une grande famille ! Nous avons un alligator jaune, un vert et un rose qui gardent cette famille. Ils gardent trois choses : un œuf vert, un vieux crocodile , et un œuf rose. Le vieil alligator, lui, garde un œuf jaune et un œuf vert.</p><p>Note bien que les œufs n'utilisent que les couleurs des alligators qui les surveillent . On ne peut pas avoir un œuf bleu sans qu'il y ait un alligator bleu au-dessus pour le garder.</p><p>Peux recréer cette famille ?</p>"
    "contenu-exercice" : "λh.λe.λg.(e (h e) g)"
    "contenu-eleve"    : "λh.λe.λg.(e (h e) g)"
    "compte-rendu"     : "λ?"
    "solution"         : "λh.(λe.(λg.(e (h e ) g ) ) ) "

  "f" :
    "titre"            : 'Manger'
    "texte"            : "<p>Attention, ça va se compliquer !</p><p>Voici deux familles, l'une à coté de l'autre. L'alligator vert est affamé, et il y a cette famille jaune juste en face de lui... Comme elle semble appétissante! La suite, tu la connais ?! Appuye sur le bouton (&#9658;).</p><p>Malheureusement , les yeux du crocodile vert étaient plus grands que son ventre. Il trop a mangé ! En mourant, il s'en va au paradis des alligator (ouf !). Mais, l'histoire ne se arrête pas là ; parce qu'une fois l'alligator vert mort, l'oeuf vert commence à éclore... Et étonnamment, il éclot exactement en ce que l'alligator vert avait mangé. C'est le miracle de la vie ! Maintenant, nous avons une nouvelle famille: un crocodile rouge gardant un alligator jaune et un oeuf rouge, et l'alligator jaune qui garde son œuf jaune. Mais cet alligator jaune à faim , et il y a un bel œuf rouge en face de lui. On y va encore une fois (&#9658;).</p><p>Pauvre alligator. Même un seul œuf est trop gros pour son estomac! L'alligator jaune meurt... mais encore une fois , l'œuf jaune commence à éclore ...Et il éclot dans exactement ce que l'alligator jaune avait mangé !</p><p>Maintenant, il n'y a plus rien pour quiconque à manger, donc nous pouvons arrêter là.</p>"
    "contenu-exercice" : "λe.(λf.(e f ) ) λh.(h ) "
    "contenu-eleve"    : ""
    "solution"         : "λf.(f ) "
    "animation"        : "yes"

  "g" :
    "titre"            : 'La règle du "je te mange"'
    "texte"            : "<p>La règle de l'alimentation dit que s'il y a des familles côte-à-côté, l'alligator le plus en haut à gauche de la famille mange à sa droite.Puis , ce crocodile meurt . Mais si il gardait des oeufs de la même couleur que lui, chacun de ces oeufs va éclorent en ce qu'il a mangé</p>.<p>En continuant, l'alligator orange, mange la famille jaune. Ensuite, l'alligator vert en haut à gauche veut manger la famille à sa droite. Mais avant qu'elle ne puisse le faire , nous devons nous pencher sur la règle de couleur !</p><p>La règle de couleur dit que si un alligator est sur ​​le point de manger une famille, et que s'il y a une couleur qui apparaît dans les deux familles, nous devons changer cette couleur dans une famille avec une autre couleur. Ici, vert et rouge apparaissent à la fois la première et la seconde famille. Le changement de couleur est automatique. Une fois qu'ils ne partagent plus les mêmes couleurs, nous pouvons manger! Et manger!Et manger! Et manger, jusqu'à ce qu'il n'y ai rien de plus qui puisse être mangé .</p>"
    "contenu-exercice" : "λz.(λe.(z z e ) ) λe.(λf.(e f ) ) λh.(h ) "
    "contenu-eleve"    : ""
    "solution"         : "λc.(c ) "
    "animation"        : "yes"

  "h" :
    "titre"            : 'La règle du vieil alligator'
    "texte"            : "<p>Il ne reste plus qu'une seule règle dans ce jeu, et elle est en lien avec les vieux alligators :</p>
<p>L'alligator supérieur gauche ici n'a pas faim. Il ne va rien manger du tout. Tout ce dont il se soucie est sa famille. Alors, comment meurt-il?</p>
<p>Il meurt quand il garde seulement une seule chose. À l'heure actuelle, Il est à la fois gardien d'une famille verte et d'une famille rouge. Ils ont besoin de lui pour prendre soin d'eux. Mais l'alligator vert a faim: il mange la famille rouge ...</p>
<p>Maintenant , le vieux crocodile ne garde plus qu'une seule famille. Cette famille peut prendre soin d'elle-même. Il n'est par conséquent plus nécessaire. Donc , il vieillit et meurt: C'est la vieille règle de l'âge!</p>
<p>Lorsque un vieux crocodile est juste gardait une seule chose , il meurt.</p><p>Pour finir, l'alligator rouge mange la famille jaune, et il ne reste plus rien qui puisse être mangé.</p>"
    "contenu-exercice" : "(λe.(e ) λf.(f ) ) λe.(e ) "
    "contenu-eleve"    : ""
    "solution"         : "λe.(e ) "
    "animation"        : "yes"

  "i" :
    "titre"            : 'Challenge !'
    "texte"            : "<p>Voici deux familles. Elles s'appellent «Vrai» et «Faux» :</p><insert λe.(λf.(e ) ) λe.(λf.(f ) ) ><p>Et ici, une famille appelée «Non» : <insert λh.(h λe.(λf.( ? ) ) λe.(λf.( ? ) ) ) ></p><p>Lorsque «Non» mange «Vrai», il produit «Faux». Et lorsque «Non» mange «Faux», il produit «Vrai». De quelles couleurs devraient être les deux œufs?</p>"
    "contenu-exercice" : ""
    "contenu-eleve"    : "λh.(h λe.(λf.( ? ) ) λe.(λf.( ? ) ) ) (λe.λf.e) "
    "compte-rendu"     : "λh.(h λe.(λf.( ? ) ) λe.(λf.( ? ) ) ) "
    "solution"         : "λh.(h λe.(λf.( f ) ) λe.(λf.( e ) ) ) "
    "parse"            : "yes"

$ ->
   #########################################################################################################################################################
  #Preparation html - Construction de la console
  ###########################################################################################################################################################
  for letter,index in ALPHABET
    color_tab.push CSS_COLOR_NAMES[index]
    var_tab["#{letter}"] = CSS_COLOR_NAMES[index]
  $( "#exercices" ).append "<option value='#{key}'  data-id='#{key}'>Exercice #{key}</button>" for key of EXERCICES
  $( "#console"   ).append "<button id='#{key}' class='panel-button' data-type='fonction' data-lambda='#{value}'>#{key}</button>" for key,value of FUNCTION
  $( "#choose-color" ).append "<option value='#{ALPHABET[index]}' data-color='#{color}' data-class='ui-icon-script' >#{ALPHABET[index]}</option>" for color,index in color_tab
  
  $( "button" ).button()
  $( "#checkboxes" ).buttonset()
  
  $.widget "ui.selectmenu", $.extend {}, $.ui.selectmenu.prototype,
    _renderItem : ( ul, item ) ->
        color = var_tab[item.value]
        li = $( "<li>", { text: item.value } ).css( "background-color", color  )
        s = "display: block;width:100%;height:50%;background:#{color};border:solid black 1px"
        $( "<span>", style: s).appendTo( li )
        return li.appendTo( ul )
    _renderMenu : ( ul, items ) ->
        that = this
        $.each items, ( index, item ) ->
          that._renderItemData( ul, item )
          $("#color").css("background" , item.element.attr("data-color")).attr("data-variable",item.value).attr "data-color", item.element.attr "data-color"
    
  $( "#choose-color" )
    .selectmenu
      appendTo : "#top-panel"
      open  : -> $("#game-container").addClass("stop-scrolling")
      close : -> $("#game-container").removeClass("stop-scrolling")
  $( "#choose-color" ).on "selectmenuchange", ( event, ui ) ->
    [color, variable] = [ui.item.element.attr("data-color"),ui.item.value]
    $( "#panel-lambda" ).attr("data-variable", variable).html("λ#{variable}")
    $( "#panel-variable").attr("data-variable", variable).html("#{variable}")
    $( "#egg-svg, #open-svg" ).find(".skin").css("fill", color)
    $("#color")
      .css( "background"   , color )
      .attr("data-variable", variable)
      .attr("data-color"   , color )
  
  $( "#exercices" )
    .selectmenu
      appendTo : "body"
      
  $( "#exercices" ).on "selectmenuchange", ( event, ui ) ->  
    i = ui.item.element.attr( "data-id" )
    $( "#replay").attr "data-id", i
    preparer_exercice i
    
  $.get "css/svg/egg.svg", (rawSvg) -> 
    $("#egg-svg").append(document.importNode rawSvg.documentElement,true)
    $("#egg-svg svg")[0].setAttribute('viewBox', '0 0 118 80')
    $( "#choose-color" ).selectmenu().val("?").selectmenu('refresh')
  , "xml"
  
  $.get "css/svg/open.svg", (rawSvg) -> 
    $("#open-svg").append(document.importNode rawSvg.documentElement,true)
    $("#open-svg svg")[0].setAttribute('viewBox', '0 0 300 124')
  , "xml"
  $.get "css/svg/vieux.svg", (rawSvg) -> 
    $("#vieux-svg").append(document.importNode rawSvg.documentElement,true)
    $("#vieux-svg svg")[0].setAttribute('viewBox', '0 0 300 124')
  , "xml"
  
  $( "#slider-animation" ).slider
    range: "max",
    min: 50,
    max: 6000,
    step: 500,
    value: 2000,
    slide: ( event, ui ) -> 
      $( "#amount-animation" ).html( ui.value )
      delta = ui.value
      
  $( "#amount-animation" ).html( $( "#slider-animation" ).slider( "value" ) )
  
  resize = () ->
    value = parseInt $( "#amount-zoom" ).html()
    [simple, double] = ["#{value}px", "#{2*value}px"]
    s =
    """
    .lambda.priorite.dropped, .lambda.dropped { 
      min-width  : #{double};
      min-height : #{simple};
      padding-top: #{simple};
    }
    
    .variable.dropped { 
      width  : #{double};
      height : #{simple};
    }
    .lambda.priorite.dropped > svg, .variable.dropped > svg, .lambda.dropped > svg {
      height : #{simple};
    }
    
    .definition_drop, .application_drop {
      width : #{simple};
      height: #{simple};
    }
    """
    $( "#restyler" ).text s
    
  $( "#slider-zoom" ).slider
    range: "max"
    min   : 1
    max   : 100
    step  : 1
    value : 60
    slide : ( event, ui ) -> 
      $( "#amount-zoom" ).html( ui.value )
      resize()
       
  $( "#amount-zoom" ).html( $( "#slider-zoom" ).slider( "value" ) )
  
  $( "#command-panel" ).draggable( {containment: "#game-container"})
  
  $( ".item" ).draggable
    helper : "clone"
    start:  (event, ui) -> $(ui.helper).addClass("ui-draggable-helper")
    stop : (event, ui) ->  $(this).show()
    #cursorAt : {top :  50, left : 150}
  ###########################################################################################################################################################
  #Initialisation des items, dialog, couleurs et panels
  ###########################################################################################################################################################
  #items oeuf, croco, vieux croco draggable
  $( "#infobox" ).on "click", (element) -> 
    infobox = $(this).toggle(this.checked).prop( "checked" )
  
  $( "#tags" ).on "click", -> 
    tags = $(this).toggle(this.checked).prop( "checked" )
    if not tags
      $(".variable.dropped, .lambda.dropped").addClass( "hide_pseudo" )
    else
      $(".variable.dropped, .lambda.dropped").removeClass( "hide_pseudo" )
  $( "#tags" ).trigger "click"   
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
   
  $('#prompt').keypress (key) -> insert_exp_into_div($( "#prompt").val(),$("#root")) if key.which is 13

 #########################################################################################################################################################
  #Parser une expression
###########################################################################################################################################################
  get_lambda_from = (root) ->
    exp = root.clone()
    exp.find("svg, .definition_drop, .application_drop").remove()
    exp = exp.html()
    exp = exp.replace /<div(?: style="[\w \;\:\-]*")? id="\d*" class="variable[\w \_\-]*" data-variable="([\w\?])" data-color="\w+"(?: style="[\w \;\:\-]*")?>\s*<\/div>/g, "$1 "
    exp = exp.replace /<div(?: style="[\w \;\:\-]*")? id="\d*" class="lambda[\w \_\-]*" data-variable="([\w\?])" data-color="\w+"(?: style="[\w \;\:\-]*")?>/g, "λ$1.("
    exp = exp.replace /<div(?: style="[\w \;\:\-]*")? id="\d*" class="lambda priorite[\w \_\-]*" data-variable="\(" data-color="white"(?: style="[\w \;\:\-]*")?>/g, "("
    exp = exp.replace(/<\/div>/g , ") ")
    exp = exp.replace(/\s{2,}/g, " ")
 ###########################################################################################################################################################
  #Inserer une expression
  ###########################################################################################################################################################
  insert_exp_into_div = (exp, root) ->
    expression = exp
    id = 0
    #make it easy to retrieve variables
    expression = expression.replace /([.( ])(([\w\?]))/g, "$1woot$2" 
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
    reg = /woot([\w\?])/g
    expression = expression.replace reg, "<div id='' class='variable dropped' data-variable='$1' data-color='' ></div>"
      #? inconnues
    #if expression.match /\?/
    #  expression = expression.replace /\?/g, "<div id='' class='lambda definition_drop' data-variable='?'></div>"
    expression = $('<div/>').html( expression ).contents()
    root.empty().append $( expression )
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
      $(this).addClass("definition_dropped") if variable is "?"
    make_dropped_droppable()
  ###########################################################################################################################################################
  #Construction graphique
  ###########################################################################################################################################################
  inserer = (draggable, droppable) ->
    if draggable.hasClass("vieux-croco")
      [variable, color] = ["(", "white"]
    else 
      [variable, color] = [$("#color").attr("data-variable"), $("#color").attr("data-color")]
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
    if droppable.attr("data-variable") is "?" 
        droppable.find("> svg").remove()
        droppable.after($(lambda))
        droppable.remove()
    else
      if droppable.hasClass( "definition_drop" )
        droppable.before $(lambda)
      else
        droppable.parent().after $(lambda)
      droppable.remove()

    
  make_dropped_droppable = () ->
    $( ".application_drop, .definition_drop, [data-variable='?']" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".item"
      drop : ( event, ui ) ->
        inserer ui.draggable, $(this)
        make_dropped_droppable()

  make_dropped_droppable()
  ###########################################################################################################################################################
  #gestion d'une etape
  ###########################################################################################################################################################  

  looping = false
  $( "#animation" ).on "click", (event) ->
    event.stopPropagation()
    event.preventDefault()
    go_one_step( "#contenu-exercice" )
  
  $("#stop").click () -> 
    $( ".animation" ).prop("disabled",false)  
    looping = false
    $( "#slider-animation" ).slider( "option", "disabled", false )    
            
  $( "#go" ).on "click", (event) ->
    event.stopPropagation()
    event.preventDefault()
    $( ".animation" ).prop("disabled",true)
    looping = false
    go_one_step("#root")
  
  $( "#repeat" ).on "click", ->
    $( ".animation" ).prop("disabled",true)
    looping = true
    go_one_step("#root")
        
  $( "#help" ).dialog
    autoOpen    : false
    dialogClass : "noTitleStuff"
    width       : "auto"
    minHeight   : 0
    open        : (event, ui) -> delay 1000, -> $( "#help" ).dialog( "close" )
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
    
  go_one_step = (root, button) ->
    local_debug = false
    $( ".animation" ).prop("disabled",true)
    $( "#{root} .application_drop, #{root} .definition_drop" ).remove()
    $(root).find( ".dropped" ).each (i = 0) -> $(this).attr "id", id+=1
   
    step1 = $.Deferred()
    step2 = $.Deferred()
    step3 = $.Deferred()
    step4 = $.Deferred()
    
    #STEP 1 : 
    action_croco = find_action_pointer root
    if action_croco.length > 0
      step1.resolve(action_croco)
    else
      alert "Plus rien à faire !"
   
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
        palette = (item for item in ALPHABET[0..24] when item not in function_vars.concat application_vars)
        palette = palette[0..intersection.length-1]    
        #Pour chacune des couleurs de la fonction on va echanger dans l'application avec une couleur disponible de la palette
        for $var, index in intersection
          found = application.find( "[data-variable='#{$var}']").andSelf().filter("[data-variable='#{$var}']")
          n = found.length
          found.attr("data-variable", palette[index])
          found.find("> svg").each ( index2 ) ->
            help( "Règle de la couleur", $(this).closest(".dropped").attr("id") ) if infobox
            $(this).hide().show delta, ->
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
          .css({border:"dashed black 1px",visibility:"visible",position:"absolute",top:"0px",left:"100%"})
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
        if looping
          go_one_step(root)
        else 
          $( ".animation" ).prop("disabled",false)
  
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
          
        $.when(def_egg,def_clone).done -> 
          if looping
            go_one_step(root)
          else 
            $( ".animation" ).prop("disabled",false)
      else
        help( "Aucun oeuf", pointer.attr "id") if infobox
        pointer.find("> svg").remove()
        pointer.replaceWith pointer.contents()
        if looping
          go_one_step(root)
        else 
          $( ".animation" ).prop("disabled",false)
  ###########################################################################################################################################################
  # Gestion du jeu
  ###########################################################################################################################################################  
  $( "#console" ).draggable().toggle()
     
  $( "#toggle-console" ).on "click", -> $( "#console" ).toggle()
  
  #Exercice
  preparer_exercice = (id) ->
    $( ".animation" ).prop("disabled",false)
    exo = EXERCICES[id]   
    $( "#replay").attr "data-id", id
    $( "#exercice").attr "data-solution", exo["solution"]
    $( "#exercice").find("> .titre" ).html("<h1>#{exo['titre']}</h1>")   
    if exo["contenu-eleve"] isnt ""
      insert_exp_into_div(exo["contenu-eleve"], $("#root"))
    else
      $("#root" ).empty().append "<div id='root_definition' class='definition_drop'></div>"   
    if exo["contenu-exercice"] isnt "" then insert_exp_into_div exo["contenu-exercice"], $( "#contenu-exercice" )   
    if exo["animation"] is "yes" then $( "#animation").show() else $( "#animation").hide()    
    texte = exo['texte'] 
    reg = /<insert ([λ().\w\? ]*)>/
    while texte.match reg
      lambda = reg.exec(texte)
      insert_exp_into_div lambda[1], $("#exercice-texte")
      texte = texte.replace reg, $("#exercice-texte").html()
    $( "#exercice-texte" ).html("<p>#{texte}</p>")   
    if ("compte-rendu" of exo)
      texte = exo["compte-rendu"]
      insert_exp_into_div texte, $("#compte-rendu")
    $( "#exercice").show()
      
  $( "#exercice").hide()
  $("#close-exercice").on "click", ->  $("#exercice").hide()  
  $( "#replay").on "click", () -> preparer_exercice $( this ).attr( "data-id" ) 
  
  $( "#exercice .check" ).on "click", ->
    local_debug = true
    solution = $( "#exercice" ).attr("data-solution")
    resultat = get_lambda_from $("#compte-rendu")
    if resultat is solution
      alert "Super ! Si tu as tout compris, passe à l'exo suivant. Sinon rejoue !"
    else
      alert "Raté ! Essaye encore, n'oublie pas de cliquer sur 'rejouer'"
      alert "[debug soluce : #{solution} ; eleve : #{resultat}]" if local_debug

  #Pour l'article
  $( "#theory" ).toggle()
  $( "#toggle-theory" ).on("click", -> $( "#theory" ).toggle())
  $("#play").on "click", -> $("#game-container").dialog("open")

  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)
