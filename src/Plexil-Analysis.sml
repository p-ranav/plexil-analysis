(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* Plexil Timing Analysis *)
(* Author: Pranav Srinivas Kumar *)
(* Date: 2016.04.06 *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)

val clock_limit = 100;

(* Helper Function to remove element from list *)
fun RemoveElem elem myList = filter (fn x => x <> elem) myList;

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* SHOULD WE UPDATE THE FIRING TIME OF THE EVENT? *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun FiringGuard clock {name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time} = 
	if (clock >= firing_time) then true else false;

fun UpdateFiringGuard clock [] = false
  | UpdateFiringGuard clock (event::other_events) = 
  		if ((FiringGuard clock event) = true) then true
  		else false orelse (UpdateFiringGuard clock other_events);

fun CalculateFiringTime clock {name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time} = 
	if (clock >= firing_time) then
		{name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time + (Real.floor (uniform((Real.fromInt min_iat), (Real.fromInt max_iat))))}
	else	
		{name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time};

fun UpdateFiringTime clock [] = []
  | UpdateFiringTime clock (event::other_events) = 
		(CalculateFiringTime clock event)::(UpdateFiringTime clock other_events);
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* EVENT FIRING GUARD - IS ANY EVENT IN THE EVENTS_LIST READY TO FIRE? *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun ClockGuard clock = 
  if (clock < clock_limit) then 
    true
  else
    false;

fun EventGuard clock {name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time} = 
	if (clock < firing_time) then
		true
	else
		false;	

fun EventsGuard clock [] = false
  | EventsGuard clock (event::other_events) = 
      if (ClockGuard clock) then 
  		  if ((EventGuard clock event) = true) then
  			 true
  		  else
  			 false orelse (EventsGuard clock other_events)
      else
        false;

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* FIND EARLIEST EVENT AND UPDATE CLOCK TO THIS VALUE *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun EarliestEvent [{name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}] = firing_time
  | EarliestEvent ({name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}
  ::{name=name2, min_iat=min_iat2, max_iat=max_iat2, updates=({name=var_name2, new_value=var_value2}::other_updates2), firing_time=firing_time2}::other_events) = 
  if (firing_time < firing_time2) then 
  (EarliestEvent ({name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}::other_events))
  else
  (EarliestEvent ({name=name2, min_iat=min_iat2, max_iat=max_iat2, updates=({name=var_name2, new_value=var_value2}::other_updates2), firing_time=firing_time2}::other_events));

(* Update by shortest time *)
fun UpdateClock clock events = (EarliestEvent events);

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* ENQUEUE EARLIEST EVENT ONTO EVENT QUEUE *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun FindEarliestEvent [{name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}] = 
		[{name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}]
  | FindEarliestEvent ({name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}
  ::{name=name2, min_iat=min_iat2, max_iat=max_iat2, updates=({name=var_name2, new_value=var_value2}::other_updates2), firing_time=firing_time2}::other_events) = 
  if (firing_time < firing_time2) then 
  (FindEarliestEvent ({name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}::other_events))
  else
  (FindEarliestEvent ({name=name2, min_iat=min_iat2, max_iat=max_iat2, updates=({name=var_name2, new_value=var_value2}::other_updates2), firing_time=firing_time2}::other_events));

fun EnqueueEvent event_queue event_list = 
	event_queue^^(FindEarliestEvent event_list);

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* UPDATE FIRING TIME OF ENQUEUED EVENT *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun SameEvent {name=name, min_iat=min_iat, max_iat=max_iat, updates=({name=var_name, new_value=var_value}::other_updates), firing_time=firing_time}
  {name=name2, min_iat=min_iat2, max_iat=max_iat2, updates=({name=var_name2, new_value=var_value2}::other_updates2), firing_time=firing_time2} = 
      if (name = name2 andalso firing_time=firing_time2) then true else false;
 
fun UpdateEventList clock earliest_event [] = []
  | UpdateEventList clock earliest_event (event::event_list) = 
    if ( (SameEvent event earliest_event) = true) then
    (CalculateFiringTime (UpdateClock clock [earliest_event]) event)::(UpdateEventList clock earliest_event event_list)
    else
     event::(UpdateEventList clock earliest_event event_list);

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* UPDATING ENVIRONMENT VARIABLE LIST WHEN EVENT FIRES *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun UpdateThisVariable {name=var_name, value=var_value} [] = []
  | UpdateThisVariable {name=var_name, value=var_value} ({name=name, value=value}::other_variables) = 
    if (var_name = name) then 
        {name=var_name, value=var_value}::other_variables
    else
        {name=name, value=value}::(UpdateThisVariable {name=var_name, value=var_value} other_variables);

fun UpdateVariableList {name=name, min_iat=min_iat, max_iat=max_iat, 
          updates=[], firing_time}
          variable_list = variable_list

  | UpdateVariableList {name=name, min_iat=min_iat, max_iat=max_iat, 
          updates=({name=var_name, new_value=var_value}::other_updates), firing_time}

          variable_list = 

    (UpdateVariableList {name=name, min_iat=min_iat, max_iat=max_iat, updates=other_updates, firing_time=firing_time} 
        (UpdateThisVariable {name=var_name, value=var_value} variable_list));


(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* LOCAL Variables API - Getters and Setters *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun UpdateThisVariable {name=name, new_value=new_value} [] = []
  | UpdateThisVariable {name=name, new_value=new_value}
                      ({name=var_name, value=var_value}::other_variables) = 
          if (name = var_name) then 
              ({name=var_name, value=new_value}::other_variables)
          else
            {name=var_name, value=var_value}
              ::(UpdateThisVariable {name=name, new_value=new_value} other_variables);

fun UpdateTheseVariables [] local_variables = local_variables
  | UpdateTheseVariables ({name=name, new_value=new_value}::other_variables) local_variables = 
        (UpdateTheseVariables other_variables (UpdateThisVariable {name=name, new_value=new_value} local_variables)); 

fun GetVariableValue this_variable [] = "0"
  | GetVariableValue this_variable ({name=name, value=value}::other_variables) = 
      if (this_variable = name) then 
          value
      else
          (GetVariableValue this_variable other_variables);

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* Find plexil node by name *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun FindPlexilNode node_name ({name=name, node_type=node_type, 
    state=state, parent=parent, assignments=assignments, commands=commands, outcome=outcome}::other_nodes) = 
        if (node_name = name) then 
          {name=name, node_type=node_type, 
              state=state, parent=parent, assignments=assignments, commands=commands, outcome=outcome} 
        else
            (FindPlexilNode node_name other_nodes);

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* Can Execute Plexil Node? *)
(* Conditional expressions need to be generated for every node *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun CanExecute {name=name, node_type=node_type, 
    state=state, parent=parent, assignments=assignments, commands=commands, outcome=outcome}
               clock event_queue local_variables environment_variables = 

  case name of
   "SimpleAssignment" => true
    | _ => false;

fun CanExecuteAtleastOne [] clock 
                  event_queue local_variables environment_variables = false
  | CanExecuteAtleastOne (first_node::other_nodes) clock 
              event_queue local_variables environment_variables = 
        if (CanExecute first_node 
                clock event_queue local_variables environment_variables) then 
            true
        else 
            false orelse (CanExecuteAtleastOne 
                          other_nodes clock 
                          event_queue local_variables environment_variables);

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* Execute a single PLEXIL node *) 
(* Return the plexil node with all its post-conditions satisfied *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)

(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* Execute Guard *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
fun ExecuteGuard event_queue clock plexil_nodes local_variables environment_variables = 
    if  (event_queue != [] andalso 
        (CanExecuteAtleastOne plexil_nodes clock event_queue local_variables environment_variables))
      then 
        true
      else
        false;

fun GetAssignmentList [] clock event_queue local_variables environment_variables = []
  | GetAssignmentList ({name=name, node_type=node_type, 
    state=state, parent=parent, assignments=assignments, commands=commands, outcome=outcome}
      ::other_nodes) clock event_queue local_variables environment_variables = 

  if (CanExecute {name=name, node_type=node_type, 
    state=state, parent=parent, assignments=assignments, commands=commands, outcome=outcome}
    clock event_queue local_variables environment_variables) then 
          assignments^^(GetAssignmentList other_nodes clock event_queue local_variables environment_variables)
  else
      (GetAssignmentList other_nodes clock event_queue local_variables environment_variables);      

fun GetWCETThisCommand [] = 0
   | GetWCETThisCommand ({name=name, WCET=WCET}::other_commands) = 
        WCET + (GetWCETThisCommand other_commands);

fun GetCommandsWCET [] clock event_queue local_variables environment_variables = 0
  | GetCommandsWCET ({name=name, node_type=node_type, 
    state=state, parent=parent, assignments=assignments, commands=commands, outcome=outcome}
      ::other_nodes) clock event_queue local_variables environment_variables = 
  if (CanExecute {name=name, node_type=node_type, 
    state=state, parent=parent, assignments=assignments, commands=commands, outcome=outcome}
    clock event_queue local_variables environment_variables) then 
        (GetWCETThisCommand commands) + (GetCommandsWCET other_nodes clock event_queue local_variables environment_variables)
  else
    (GetCommandsWCET other_nodes clock event_queue local_variables environment_variables);

fun UpdateClock plexil_nodes clock event_queue local_variables environment_variables = 
  clock + (GetCommandsWCET plexil_nodes clock event_queue local_variables environment_variables);
