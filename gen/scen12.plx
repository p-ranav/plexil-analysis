<?xml version="1.0" encoding="UTF-8"?>
<PlexilPlan xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:tr="extended-plexil-translator"
            FileName="scen12.ple">
   <GlobalDeclarations LineNo="7" ColNo="0">
      <LibraryNodeDeclaration LineNo="7" ColNo="0">
         <Name>Fly</Name>
         <Interface LineNo="7" ColNo="19">
            <In>
               <DeclareVariable LineNo="6" ColNo="19">
                  <Name>Time</Name>
                  <Type>Integer</Type>
               </DeclareVariable>
               <DeclareVariable LineNo="6" ColNo="36">
                  <Name>Continue</Name>
                  <Type>Boolean</Type>
               </DeclareVariable>
               <DeclareVariable LineNo="6" ColNo="57">
                  <Name>LostComm</Name>
                  <Type>Boolean</Type>
               </DeclareVariable>
            </In>
         </Interface>
      </LibraryNodeDeclaration>
      <LibraryNodeDeclaration LineNo="10" ColNo="0">
         <Name>Clock</Name>
         <Interface LineNo="10" ColNo="21">
            <In>
               <DeclareVariable LineNo="9" ColNo="41">
                  <Name>Continue</Name>
                  <Type>Boolean</Type>
               </DeclareVariable>
            </In>
            <InOut>
               <DeclareVariable LineNo="9" ColNo="21">
                  <Name>Time</Name>
                  <Type>Integer</Type>
               </DeclareVariable>
            </InOut>
         </Interface>
      </LibraryNodeDeclaration>
      <CommandDeclaration LineNo="13" ColNo="0">
         <Name>fp_altitude</Name>
         <Parameter>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="14" ColNo="0">
         <Name>fp_append_waypoint</Name>
         <Parameter>
            <Type>String</Type>
         </Parameter>
      </CommandDeclaration>
      <LibraryNodeDeclaration LineNo="15" ColNo="0">
         <Name>SharedFlightPlan</Name>
      </LibraryNodeDeclaration>
      <CommandDeclaration LineNo="18" ColNo="0">
         <Name>append_altitude</Name>
         <Parameter>
            <Name>qualifier</Name>
            <Type>String</Type>
         </Parameter>
         <Parameter>
            <Name>altitude</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="19" ColNo="0">
         <Name>append_waypoint</Name>
         <Parameter>
            <Name>waypoint</Name>
            <Type>String</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="20" ColNo="0">
         <Name>append_rv</Name>
         <Parameter>
            <Name>waypoint</Name>
            <Type>String</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="21" ColNo="0">
         <Name>append_efc_time_climb</Name>
         <Parameter>
            <Name>time</Name>
            <Type>Integer</Type>
         </Parameter>
         <Parameter>
            <Name>altitude</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="22" ColNo="0">
         <Name>append_efc_time_descend</Name>
         <Parameter>
            <Name>time</Name>
            <Type>Integer</Type>
         </Parameter>
         <Parameter>
            <Name>altitude</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="23" ColNo="0">
         <Name>append_efc_waypoint_climb</Name>
         <Parameter>
            <Name>waypoint</Name>
            <Type>String</Type>
         </Parameter>
         <Parameter>
            <Name>altitude</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="24" ColNo="0">
         <Name>append_efc_wayapoint_descend</Name>
         <Parameter>
            <Name>waypoint</Name>
            <Type>String</Type>
         </Parameter>
         <Parameter>
            <Name>altitude</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="25" ColNo="0">
         <Name>clearance_limit</Name>
         <Parameter>
            <Name>waypoint</Name>
            <Type>String</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="28" ColNo="0">
         <Name>turn</Name>
         <Parameter>
            <Name>angle</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="29" ColNo="0">
         <Name>right_turn</Name>
         <Parameter>
            <Name>angle</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="30" ColNo="0">
         <Name>left_turn</Name>
         <Parameter>
            <Name>angle</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="31" ColNo="0">
         <Name>climb</Name>
         <Parameter>
            <Name>altitude_feet</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="32" ColNo="0">
         <Name>descend</Name>
         <Parameter>
            <Name>altitude_feet</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="33" ColNo="0">
         <Name>direct</Name>
         <Parameter>
            <Name>waypoint</Name>
            <Type>String</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="36" ColNo="0">
         <Name>reach_waypoint</Name>
         <Parameter>
            <Type>String</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="39" ColNo="0">
         <Name>pprint</Name>
      </CommandDeclaration>
   </GlobalDeclarations>
   <Node NodeType="NodeList" epx="Sequence" LineNo="45" ColNo="2">
      <NodeId>scen12</NodeId>
      <GuardWCET>300</GuardWCET>
      <ActionWCET>725</ActionWCET>
      <VariableDeclarations>
         <DeclareVariable LineNo="44" ColNo="2">
            <Name>Time</Name>
            <Type>Integer</Type>
            <InitialValue>
               <IntegerValue>0</IntegerValue>
            </InitialValue>
         </DeclareVariable>
         <DeclareVariable LineNo="45" ColNo="2">
            <Name>Continue</Name>
            <Type>Boolean</Type>
            <InitialValue>
               <BooleanValue>true</BooleanValue>
            </InitialValue>
         </DeclareVariable>
         <DeclareVariable LineNo="46" ColNo="2">
            <Name>LostComm</Name>
            <Type>Boolean</Type>
            <InitialValue>
               <BooleanValue>false</BooleanValue>
            </InitialValue>
         </DeclareVariable>
      </VariableDeclarations>
      <InvariantCondition>
         <NOT>
            <OR>
               <AND>
                  <EQInternal>
                     <NodeOutcomeVariable>
                        <NodeRef dir="child">Init</NodeRef>
                     </NodeOutcomeVariable>
                     <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                  </EQInternal>
                  <EQInternal>
                     <NodeStateVariable>
                        <NodeRef dir="child">Init</NodeRef>
                     </NodeStateVariable>
                     <NodeStateValue>FINISHED</NodeStateValue>
                  </EQInternal>
               </AND>
               <AND>
                  <EQInternal>
                     <NodeOutcomeVariable>
                        <NodeRef dir="child">Events</NodeRef>
                     </NodeOutcomeVariable>
                     <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                  </EQInternal>
                  <EQInternal>
                     <NodeStateVariable>
                        <NodeRef dir="child">Events</NodeRef>
                     </NodeStateVariable>
                     <NodeStateValue>FINISHED</NodeStateValue>
                  </EQInternal>
               </AND>
            </OR>
         </NOT>
      </InvariantCondition>
      <NodeBody>
         <NodeList>
            <Node NodeType="NodeList" epx="Sequence" LineNo="51" ColNo="4">
               <NodeId>Init</NodeId>
	       <GuardWCET>547</GuardWCET>
	       <ActionWCET>1146</ActionWCET>
               <InvariantCondition>
                  <NOT>
                     <OR>
                        <AND>
                           <EQInternal>
                              <NodeOutcomeVariable>
                                 <NodeRef dir="child">LibraryCall__0</NodeRef>
                              </NodeOutcomeVariable>
                              <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                           </EQInternal>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="child">LibraryCall__0</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </AND>
                        <AND>
                           <EQInternal>
                              <NodeOutcomeVariable>
                                 <NodeRef dir="child">COMMAND__1</NodeRef>
                              </NodeOutcomeVariable>
                              <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                           </EQInternal>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="child">COMMAND__1</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </AND>
                        <AND>
                           <EQInternal>
                              <NodeOutcomeVariable>
                                 <NodeRef dir="child">COMMAND__2</NodeRef>
                              </NodeOutcomeVariable>
                              <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                           </EQInternal>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="child">COMMAND__2</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </AND>
                        <AND>
                           <EQInternal>
                              <NodeOutcomeVariable>
                                 <NodeRef dir="child">COMMAND__3</NodeRef>
                              </NodeOutcomeVariable>
                              <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                           </EQInternal>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="child">COMMAND__3</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </AND>
                        <AND>
                           <EQInternal>
                              <NodeOutcomeVariable>
                                 <NodeRef dir="child">COMMAND__4</NodeRef>
                              </NodeOutcomeVariable>
                              <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                           </EQInternal>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="child">COMMAND__4</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </AND>
                     </OR>
                  </NOT>
               </InvariantCondition>
               <NodeBody>
                  <NodeList>
                     <Node NodeType="LibraryNodeCall">
                        <NodeId>LibraryCall__0</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <NodeBody>
                           <LibraryNodeCall>
                              <NodeId>SharedFlightPlan</NodeId>
                           </LibraryNodeCall>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="51" ColNo="4">
                        <NodeId>COMMAND__1</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="sibling">LibraryCall__0</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>append_altitude</StringValue>
                              </Name>
                              <Arguments LineNo="52" ColNo="21">
                                 <StringValue>Climb</StringValue>
                                 <IntegerValue>6000</IntegerValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="52" ColNo="4">
                        <NodeId>COMMAND__2</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="sibling">COMMAND__1</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>append_rv</StringValue>
                              </Name>
                              <Arguments LineNo="53" ColNo="15">
                                 <StringValue>SCK</StringValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="53" ColNo="4">
                        <NodeId>COMMAND__3</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="sibling">COMMAND__2</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>append_waypoint</StringValue>
                              </Name>
                              <Arguments LineNo="54" ColNo="21">
                                 <StringValue>SJC</StringValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="54" ColNo="4">
                        <NodeId>COMMAND__4</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="sibling">COMMAND__3</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>clearance_limit</StringValue>
                              </Name>
                              <Arguments LineNo="55" ColNo="21">
                                 <StringValue>SJC</StringValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                  </NodeList>
               </NodeBody>
            </Node>
            <Node NodeType="NodeList" epx="Concurrence" LineNo="58" ColNo="10">
               <NodeId>Events</NodeId>
	       <GuardWCET>2405</GuardWCET>
	       <ActionWCET>873</ActionWCET>
               <StartCondition>
                  <EQInternal>
                     <NodeStateVariable>
                        <NodeRef dir="sibling">Init</NodeRef>
                     </NodeStateVariable>
                     <NodeStateValue>FINISHED</NodeStateValue>
                  </EQInternal>
               </StartCondition>
               <NodeBody>
                  <NodeList>
                     <Node NodeType="LibraryNodeCall">
                        <NodeId>LibraryCall__5</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <NodeBody>
                           <LibraryNodeCall>
                              <NodeId>Clock</NodeId>
                              <Alias>
                                 <NodeParameter>Time</NodeParameter>
                                 <IntegerVariable>Time</IntegerVariable>
                              </Alias>
                              <Alias>
                                 <NodeParameter>Continue</NodeParameter>
                                 <BooleanVariable>Continue</BooleanVariable>
                              </Alias>
                           </LibraryNodeCall>
                        </NodeBody>
                     </Node>
                     <Node NodeType="LibraryNodeCall">
                        <NodeId>LibraryCall__6</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <NodeBody>
                           <LibraryNodeCall>
                              <NodeId>Fly</NodeId>
                              <Alias>
                                 <NodeParameter>Time</NodeParameter>
                                 <IntegerVariable>Time</IntegerVariable>
                              </Alias>
                              <Alias>
                                 <NodeParameter>Continue</NodeParameter>
                                 <BooleanVariable>Continue</BooleanVariable>
                              </Alias>
                              <Alias>
                                 <NodeParameter>LostComm</NodeParameter>
                                 <BooleanVariable>LostComm</BooleanVariable>
                              </Alias>
                           </LibraryNodeCall>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="65" ColNo="6">
                        <NodeId>E1</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQNumeric>
                              <IntegerVariable>Time</IntegerVariable>
                              <IntegerValue>4</IntegerValue>
                           </EQNumeric>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>right_turn</StringValue>
                              </Name>
                              <Arguments LineNo="66" ColNo="18">
                                 <IntegerValue>30</IntegerValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="70" ColNo="6">
                        <NodeId>E2</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQNumeric>
                              <IntegerVariable>Time</IntegerVariable>
                              <IntegerValue>8</IntegerValue>
                           </EQNumeric>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>left_turn</StringValue>
                              </Name>
                              <Arguments LineNo="71" ColNo="17">
                                 <IntegerValue>20</IntegerValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="75" ColNo="6">
                        <NodeId>E3</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQNumeric>
                              <IntegerVariable>Time</IntegerVariable>
                              <IntegerValue>10</IntegerValue>
                           </EQNumeric>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>climb</StringValue>
                              </Name>
                              <Arguments LineNo="76" ColNo="12">
                                 <IntegerValue>7000</IntegerValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="80" ColNo="6">
                        <NodeId>E4</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQNumeric>
                              <IntegerVariable>Time</IntegerVariable>
                              <IntegerValue>16</IntegerValue>
                           </EQNumeric>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>direct</StringValue>
                              </Name>
                              <Arguments LineNo="81" ColNo="14">
                                 <StringValue>SCK</StringValue>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Assignment" LineNo="86" ColNo="6">
                        <NodeId>E5</NodeId>
			<GuardWCET>1</GuardWCET>
			<ActionWCET>2</ActionWCET>
                        <StartCondition>
                           <EQNumeric>
                              <IntegerVariable>Time</IntegerVariable>
                              <IntegerValue>30</IntegerValue>
                           </EQNumeric>
                        </StartCondition>
                        <NodeBody>
                           <Assignment>
                              <BooleanVariable>Continue</BooleanVariable>
                              <BooleanRHS>
                                 <BooleanValue>false</BooleanValue>
                              </BooleanRHS>
                           </Assignment>
                        </NodeBody>
                     </Node>
                  </NodeList>
               </NodeBody>
            </Node>
         </NodeList>
      </NodeBody>
   </Node>
</PlexilPlan>
