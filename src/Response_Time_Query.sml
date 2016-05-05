(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)
(* Plexil Timing Analysis - Sample Trigger to Response Time Query *)
(* Author: Pranav Srinivas Kumar *)
(* Date: 2016.04.06 *)
(* Plexil Plan: Drive to Target *)
(*--------------------------------------------------------------------*)
(*--------------------------------------------------------------------*)

(* Predicate Function to find if target is in view *)
fun isTargetInView [] = false 
  | isTargetInView ({name=name, node_type=node_type, 
    				state=state, parent=parent, assignments=assignments, 
    				commands=commands, outcome=outcome}
    				::other_nodes) = 

  		if (name = "StopForTarget" andalso state = "Executing") then
  			true
  		else
  			(isTargetInView other_nodes);

(* Wrapper around predicate function to find if StopForTarget node has executed *)
fun Find_Target_in_View_Nodes n = (isTargetInView (hd (Mark.Plexil_Analysis'Plexil_Nodes 1 n)));

fun FindReponsePlexilNode [] = []
  | FindReponsePlexilNode ({name=name, node_type=node_type, 
                    state=state, parent=parent, assignments=assignments, 
                    commands=commands, outcome=outcome}
                    ::other_nodes) = 

    if (name = "StopForTarget") then
      [{name=name, node_type=node_type, 
            state=state, parent=parent, assignments=assignments, 
            commands=commands, outcome=outcome}]
    else 
      (FindReponsePlexilNode other_nodes);

(* State space search function to search the state space and identify all state 
  space nodes where StopForTarget has executed *)  
val Target_in_View_Nodes = 
          SearchNodes (
              EntireGraph,
              fn n => (Find_Target_in_View_Nodes n),
              NoLimit,
              fn n => (FindReponsePlexilNode (hd (Mark.Plexil_Analysis'Plexil_Nodes 1 n))),
              [],
              op ::);   

(* State space search function to find clock values on all states where target is in view *)  
val Response_Completion_Times = 
          SearchNodes (
              EntireGraph,
              fn n => (Find_Target_in_View_Nodes n),
              NoLimit,
              fn n => (hd (Mark.Plexil_Analysis'Clock 1 n)),
              [],
              op ::); 

fun FindTriggerEvent [] = []
  | FindTriggerEvent ({name=name, min_iat=min_iat, max_iat=max_iat, 
                  updates=updates, firing_time=firing_time}::other_events) = 
      if (name = "Target_Detected") then 
        [firing_time]
      else
        (FindTriggerEvent other_events);

(* State space search function to find clock values on all states where target is in view *)  
val TriggerEventTimes = 
          SearchNodes (
              EntireGraph,
              fn n => (Find_Target_in_View_Nodes n),
              NoLimit,
              fn n => (hd (FindTriggerEvent (hd (Mark.Plexil_Analysis'Processed_Events 1 n)))),
              [],
              op ::); 

val Trigger_Time = (hd (sort INT.lt TriggerEventTimes));
val Response_Time = (hd (sort INT.lt Response_Completion_Times));
val Trigger_to_Response_Time = Response_Time - Trigger_Time;

(*
fun Get_Trigger_to_Response_Times triggers [] = []
  | Get_Trigger_to_Response_Times [] responses = []
  | Get_Trigger_to_Response_Times (first_trigger::other_triggers) (first_response::other_responses) = 
    (first_response - first_trigger)::(Get_Trigger_to_Response_Times other_triggers other_responses);

fun Largest [] = raise Empty 
 | Largest [x] = x
 | Largest (x::xs) =
      let 
        val y = Largest xs
      in
        if x > y then x else y
      end

val Trigger_to_Response_Times = (Get_Trigger_to_Response_Times Trigger_Times Response_Times);
val Worst_Case_Response_Time = (Largest Trigger_to_Response_Times);
*)



