Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
#debug = false
debug = true
id = 1000
color_tab = ['purple','blue','LightBlue','red','orange','brown','green','LightGreen','yellow','pink','grey']

$ ->
  
  $( ".color" ).on "click", ->
    $( "#choose-color" ).data("color", $(this).data("color"))
    $( ".color" ).removeClass("selected-color" )
    $( this ).addClass( "selected-color" )
    console.log "You choose " +  $("#choose-color").data("color") if debug

    
  $( ".item" ).draggable
    helper : "clone"
    appendTo : "#buttons-panel"
  
  
  make_it_droppable = () ->
     $( ".application_drop, .definition_drop" ).droppable
          hoverClass: "ui-state-hover"
          accept : ".croco, .egg"
          drop : ( event, ui ) ->
              $( this ).parent(":first").removeClass("parentHighlight")
              variable =  $("#choose-color").data("color")
              if ui.draggable.hasClass("croco")
                lambda = 
                """
                  <div id='#{id++}' style='background-color:#{variable};' class='lambda dropped' data-variable='#{variable}' >
                    <div class='definition_drop'></div>
                    <div class='application_drop'></div>
                 </div>
                """
              else
                lambda = 
                """
                  <div id='#{id++}' style='background-color:#{variable};' class='variable dropped' data-variable='#{variable}' >
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
      accept : ".croco"
      drop : ( event, ui ) ->
          variable =  $("#choose-color").data("color")
          lambda = 
          """
            <div id='#{id++}' style='background-color:#{variable};' class='lambda dropped' data-variable='#{variable}' >
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
  
  $( "#go" ).on "click", ->
    $( ".application_drop, .definition_drop" ).remove()  
    pointer = $("#root > .lambda:first") 
    # Top-left RULE
    
    while not pointer.siblings().length
      pointer = pointer.find(".lambda").first()
      if not pointer.length
        alert "over"
        break
    
    variable = pointer.data("variable")

    color_rule_check = (func, app) ->
      func_colors = []
      func.find( "[data-variable]" ).andSelf().filter("[data-variable]").each ->
        func_colors.push $( this ).data("variable")
      func_colors = func_colors.unique()
      found = false
      for color in func_colors
        app_items = app.find( "[data-variable='#{color}']").andSelf().filter("[data-variable='#{color}']")
        if app_items.length
          alert "Color Rule Alert !"
          app_colors = []
          app.find( "[data-variable]").andSelf().filter("[data-variable]").each ->
            app_colors.push $( this ).data("variable")
          app_colors = app_colors.unique()
          used_colors = (func_colors.concat app_colors).unique()
          difference = (item for item in color_tab when item not in used_colors)
          difference = difference[0..app_colors.length-1]
          for new_color, index in difference
            app.find( "[data-variable=#{app_colors[index]}]").andSelf().filter("[data-variable=#{app_colors[index]}]").each ->
              $( this ).attr("data-variable", new_color)
              $( this ).css("backgroundColor", new_color)
          alert "see?"
          break       

    application_content = pointer.siblings().first()
    color_rule_check(pointer, application_content)
    
    pointer.find( ".variable"  ).each ->
      element = $( this )
      console.log "j'ai trouvé un " + element.data("variable") if debug
      if element.data("variable") is variable
        element.before application_content.clone()
        element.remove()
    application_content.remove()
    definition_content = pointer.contents()
    pointer.after definition_content
    pointer.remove()
    
  $( "#clear" ).on "click", ->  
    $("#root" ).empty()
    make_root_droppable()

  $( "#ex-4" ).on "click", ->  
    html =
    """
  <div id="1001" style="background-color:yellow;" class="lambda dropped" data-variable="yellow">
    <div id="1002" style="background-color:yellow;" class="variable dropped" data-variable="yellow">
   
</div> <div id="1003" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1004" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1010" style="background-color:red;" class="variable dropped" data-variable="red">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1005" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1006" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1011" style="background-color:LightGreen;" class="variable dropped" data-variable="LightGreen">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1007" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1008" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1009" style="background-color:red;" class="variable dropped" data-variable="red">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
    """
    $("#root" ).empty()
    $("#root" ).append html
      
  $( "#ex-3" ).on "click", ->  
    html =
    """
  <div id="1001" style="background-color:yellow;" class="lambda dropped" data-variable="yellow">
    <div id="1002" style="background-color:yellow;" class="variable dropped" data-variable="yellow">
   
</div> <div id="1003" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1004" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1010" style="background-color:red;" class="variable dropped" data-variable="red">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1005" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1006" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1011" style="background-color:LightGreen;" class="variable dropped" data-variable="LightGreen">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1007" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1008" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1009" style="background-color:LightGreen;" class="variable dropped" data-variable="LightGreen">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
    """
    $("#root" ).empty()
    $("#root" ).append html
      
    
    
    
  $( "#ex-2" ).on "click", ->  
    html =
    """
    <div id="1005" style="background-color:purple;" class="lambda dropped" data-variable="purple">
    <div id="1006" style="background-color:orange;" class="lambda dropped" data-variable="orange">
    <div id="1013" style="background-color:purple;" class="variable dropped" data-variable="purple">
   
</div> <div id="1014" style="background-color:purple;" class="variable dropped" data-variable="purple">
   
</div> <div id="1015" style="background-color:orange;" class="variable dropped" data-variable="orange">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1007" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1008" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1011" style="background-color:LightGreen;" class="variable dropped" data-variable="LightGreen">
   
</div> <div id="1012" style="background-color:red;" class="variable dropped" data-variable="red">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1009" style="background-color:yellow;" class="lambda dropped" data-variable="yellow">
    <div id="1010" style="background-color:yellow;" class="variable dropped" data-variable="yellow">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
    """
    $("#root" ).empty()
    $("#root" ).append html
    
    
  $( "#ex-1" ).on "click", ->  
    html =
    """
    <div id="1001" style="background-color:LightGreen;" class="lambda dropped" data-variable="LightGreen">
    <div id="1002" style="background-color:red;" class="lambda dropped" data-variable="red">
    <div id="1007" style="background-color:LightGreen;" class="variable dropped" data-variable="LightGreen">
   
</div> <div id="1008" style="background-color:red;" class="variable dropped" data-variable="red">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1003" style="background-color:LightBlue;" class="lambda dropped" data-variable="LightBlue">
    <div id="1004" style="background-color:blue;" class="lambda dropped" data-variable="blue">
    <div id="1009" style="background-color:LightBlue;" class="variable dropped" data-variable="LightBlue">
   
</div> <div id="1010" style="background-color:blue;" class="variable dropped" data-variable="blue">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
   
</div> <div id="1005" style="background-color:yellow;" class="lambda dropped" data-variable="yellow">
    <div id="1006" style="background-color:yellow;" class="variable dropped" data-variable="yellow">
   <div class="application_drop ui-droppable"></div>
</div>
   <div class="application_drop ui-droppable"></div>
</div>
    """
    $("#root" ).empty()
    $("#root" ).append html
  
  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)
  