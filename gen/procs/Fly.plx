<?xml version="1.0" encoding="UTF-8"?>
<PlexilPlan xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:tr="extended-plexil-translator"
            FileName="Fly.ple">
   <GlobalDeclarations LineNo="17" ColNo="0">
      <LibraryNodeDeclaration LineNo="17" ColNo="0">
         <Name>AdjustForLostComm</Name>
      </LibraryNodeDeclaration>
      <LibraryNodeDeclaration LineNo="18" ColNo="0">
         <Name>AdjustRouteForLostComm</Name>
      </LibraryNodeDeclaration>
      <LibraryNodeDeclaration LineNo="19" ColNo="0">
         <Name>AdjustAltitudeForLostComm</Name>
      </LibraryNodeDeclaration>
      <StateDeclaration LineNo="21" ColNo="7">
         <Name>MessageFromATC</Name>
         <Return>
            <Name>_return_0</Name>
            <Type>String</Type>
         </Return>
      </StateDeclaration>
      <StateDeclaration LineNo="22" ColNo="8">
         <Name>DueEFC</Name>
         <Return>
            <Name>_return_0</Name>
            <Type>Boolean</Type>
         </Return>
      </StateDeclaration>
      <StateDeclaration LineNo="23" ColNo="8">
         <Name>AtClearanceLimit</Name>
         <Return>
            <Name>_return_0</Name>
            <Type>Boolean</Type>
         </Return>
      </StateDeclaration>
      <StateDeclaration LineNo="24" ColNo="8">
         <Name>AtFinalApproachFix</Name>
         <Return>
            <Name>_return_0</Name>
            <Type>Boolean</Type>
         </Return>
      </StateDeclaration>
      <StateDeclaration LineNo="25" ColNo="8">
         <Name>PendingRoute</Name>
         <Return>
            <Name>_return_0</Name>
            <Type>Boolean</Type>
         </Return>
      </StateDeclaration>
      <StateDeclaration LineNo="26" ColNo="8">
         <Name>NewRouteSegment</Name>
         <Return>
            <Name>_return_0</Name>
            <Type>Boolean</Type>
         </Return>
      </StateDeclaration>
      <StateDeclaration LineNo="27" ColNo="8">
         <Name>CurrentRouteSegmentAchieved</Name>
         <Return>
            <Name>_return_0</Name>
            <Type>Boolean</Type>
         </Return>
      </StateDeclaration>
      <CommandDeclaration LineNo="29" ColNo="0">
         <Name>handle_atc_message</Name>
         <Parameter>
            <Name>message</Name>
            <Type>String</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="30" ColNo="0">
         <Name>command_next_route_segment</Name>
      </CommandDeclaration>
      <CommandDeclaration LineNo="31" ColNo="0">
         <Name>adjust_altitude</Name>
      </CommandDeclaration>
      <CommandDeclaration LineNo="32" ColNo="0">
         <Name>complete_route_segment</Name>
      </CommandDeclaration>
      <CommandDeclaration LineNo="33" ColNo="0">
         <Name>check_flight_progress</Name>
      </CommandDeclaration>
      <CommandDeclaration LineNo="34" ColNo="0">
         <Name>request_further_clearance</Name>
      </CommandDeclaration>
      <CommandDeclaration LineNo="35" ColNo="0">
         <Name>handle_clearance_limit</Name>
      </CommandDeclaration>
      <CommandDeclaration LineNo="36" ColNo="0">
         <Name>squawk</Name>
         <Parameter>
            <Name>transponder_code</Name>
            <Type>Integer</Type>
         </Parameter>
      </CommandDeclaration>
      <CommandDeclaration LineNo="37" ColNo="0">
         <Name>pprint</Name>
      </CommandDeclaration>
   </GlobalDeclarations>
   <Node NodeType="NodeList" epx="Concurrence" LineNo="40" ColNo="5">
      <NodeId>Fly</NodeId>
      <Interface>
         <In>
            <DeclareVariable LineNo="41" ColNo="5">
               <Name>Time</Name>
               <Type>Integer</Type>
            </DeclareVariable>
            <DeclareVariable LineNo="42" ColNo="5">
               <Name>LostComm</Name>
               <Type>Boolean</Type>
            </DeclareVariable>
            <DeclareVariable LineNo="43" ColNo="5">
               <Name>Continue</Name>
               <Type>Boolean</Type>
            </DeclareVariable>
         </In>
      </Interface>
      <VariableDeclarations>
         <DeclareVariable LineNo="45" ColNo="2">
            <Name>RouteProcessInterval</Name>
            <Type>Integer</Type>
            <InitialValue>
               <IntegerValue>1</IntegerValue>
            </InitialValue>
         </DeclareVariable>
         <DeclareVariable LineNo="46" ColNo="2">
            <Name>LastTime</Name>
            <Type>Integer</Type>
            <InitialValue>
               <IntegerValue>0</IntegerValue>
            </InitialValue>
         </DeclareVariable>
      </VariableDeclarations>
      <ExitCondition>
         <NOT>
            <BooleanVariable>Continue</BooleanVariable>
         </NOT>
      </ExitCondition>
      <NodeBody>
         <NodeList>
            <Node NodeType="NodeList" epx="Sequence" LineNo="55" ColNo="4">
               <NodeId>HandleATC</NodeId>
               <RepeatCondition>
                  <BooleanValue>true</BooleanValue>
               </RepeatCondition>
               <InvariantCondition>
                  <NOT>
                     <AND>
                        <EQInternal>
                           <NodeOutcomeVariable>
                              <NodeRef dir="child">WaitForMessage</NodeRef>
                           </NodeOutcomeVariable>
                           <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                        </EQInternal>
                        <EQInternal>
                           <NodeStateVariable>
                              <NodeRef dir="child">WaitForMessage</NodeRef>
                           </NodeStateVariable>
                           <NodeStateValue>FINISHED</NodeStateValue>
                        </EQInternal>
                     </AND>
                  </NOT>
               </InvariantCondition>
               <NodeBody>
                  <NodeList>
                     <Node NodeType="Command" LineNo="60" ColNo="6">
                        <NodeId>WaitForMessage</NodeId>
                        <StartCondition>
                           <IsKnown>
                              <LookupOnChange>
                                 <Name>
                                    <StringValue>MessageFromATC</StringValue>
                                 </Name>
                              </LookupOnChange>
                           </IsKnown>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>handle_atc_message</StringValue>
                              </Name>
                              <Arguments LineNo="61" ColNo="26">
                                 <LookupNow>
                                    <Name>
                                       <StringValue>MessageFromATC</StringValue>
                                    </Name>
                                 </LookupNow>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                  </NodeList>
               </NodeBody>
            </Node>
            <Node NodeType="NodeList" epx="Sequence" LineNo="71" ColNo="4">
               <NodeId>ProcessRoute</NodeId>
               <RepeatCondition>
                  <BooleanValue>true</BooleanValue>
               </RepeatCondition>
               <InvariantCondition>
                  <NOT>
                     <AND>
                        <EQInternal>
                           <NodeOutcomeVariable>
                              <NodeRef dir="child">Iterate</NodeRef>
                           </NodeOutcomeVariable>
                           <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                        </EQInternal>
                        <EQInternal>
                           <NodeStateVariable>
                              <NodeRef dir="child">Iterate</NodeRef>
                           </NodeStateVariable>
                           <NodeStateValue>FINISHED</NodeStateValue>
                        </EQInternal>
                     </AND>
                  </NOT>
               </InvariantCondition>
               <NodeBody>
                  <NodeList>
                     <Node NodeType="NodeList" epx="Sequence" LineNo="74" ColNo="6">
                        <NodeId>Iterate</NodeId>
                        <StartCondition>
                           <GT>
                              <IntegerVariable>Time</IntegerVariable>
                              <IntegerVariable>LastTime</IntegerVariable>
                           </GT>
                        </StartCondition>
                        <InvariantCondition>
                           <NOT>
                              <OR>
                                 <AND>
                                    <EQInternal>
                                       <NodeOutcomeVariable>
                                          <NodeRef dir="child">ASSIGNMENT__1</NodeRef>
                                       </NodeOutcomeVariable>
                                       <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                    </EQInternal>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="child">ASSIGNMENT__1</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </AND>
                                 <AND>
                                    <EQInternal>
                                       <NodeOutcomeVariable>
                                          <NodeRef dir="child">if__2</NodeRef>
                                       </NodeOutcomeVariable>
                                       <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                    </EQInternal>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="child">if__2</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </AND>
                              </OR>
                           </NOT>
                        </InvariantCondition>
                        <NodeBody>
                           <NodeList>
                              <Node NodeType="Assignment" LineNo="75" ColNo="6">
                                 <NodeId>ASSIGNMENT__1</NodeId>
                                 <NodeBody>
                                    <Assignment>
                                       <IntegerVariable>LastTime</IntegerVariable>
                                       <NumericRHS>
                                          <IntegerVariable>Time</IntegerVariable>
                                       </NumericRHS>
                                    </Assignment>
                                 </NodeBody>
                              </Node>
                              <Node NodeType="NodeList" epx="If" LineNo="76" ColNo="6">
                                 <NodeId>if__2</NodeId>
                                 <StartCondition>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="sibling">ASSIGNMENT__1</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </StartCondition>
                                 <NodeBody>
                                    <NodeList>
                                       <Node NodeType="Empty" epx="Condition">
                                          <NodeId>ep2cp_IfTest</NodeId>
                                          <PostCondition>
                                             <LookupOnChange>
                                                <Name>
                                                   <StringValue>PendingRoute</StringValue>
                                                </Name>
                                             </LookupOnChange>
                                          </PostCondition>
                                       </Node>
                                       <Node NodeType="NodeList" epx="Then" LineNo="77" ColNo="8">
                                          <NodeId>BLOCK__3</NodeId>
                                          <InvariantCondition>
                                             <NOT>
                                                <OR>
                                                   <AND>
                                                      <EQInternal>
                                                         <NodeOutcomeVariable>
                                                            <NodeRef dir="child">if__4</NodeRef>
                                                         </NodeOutcomeVariable>
                                                         <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                                      </EQInternal>
                                                      <EQInternal>
                                                         <NodeStateVariable>
                                                            <NodeRef dir="child">if__4</NodeRef>
                                                         </NodeStateVariable>
                                                         <NodeStateValue>FINISHED</NodeStateValue>
                                                      </EQInternal>
                                                   </AND>
                                                   <AND>
                                                      <EQInternal>
                                                         <NodeOutcomeVariable>
                                                            <NodeRef dir="child">COMMAND__13</NodeRef>
                                                         </NodeOutcomeVariable>
                                                         <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                                      </EQInternal>
                                                      <EQInternal>
                                                         <NodeStateVariable>
                                                            <NodeRef dir="child">COMMAND__13</NodeRef>
                                                         </NodeStateVariable>
                                                         <NodeStateValue>FINISHED</NodeStateValue>
                                                      </EQInternal>
                                                   </AND>
                                                </OR>
                                             </NOT>
                                          </InvariantCondition>
                                          <StartCondition>
                                             <EQInternal>
                                                <NodeOutcomeVariable>
                                                   <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                </NodeOutcomeVariable>
                                                <NodeOutcomeValue>SUCCESS</NodeOutcomeValue>
                                             </EQInternal>
                                          </StartCondition>
                                          <SkipCondition>
                                             <EQInternal>
                                                <NodeFailureVariable>
                                                   <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                </NodeFailureVariable>
                                                <NodeFailureValue>POST_CONDITION_FAILED</NodeFailureValue>
                                             </EQInternal>
                                          </SkipCondition>
                                          <NodeBody>
                                             <NodeList>
                                                <Node NodeType="NodeList" epx="If" LineNo="77" ColNo="8">
                                                   <NodeId>if__4</NodeId>
                                                   <NodeBody>
                                                      <NodeList>
                                                         <Node NodeType="Empty" epx="Condition">
                                                            <NodeId>ep2cp_IfTest</NodeId>
                                                            <PostCondition>
                                                               <LookupOnChange>
                                                                  <Name>
                                                                     <StringValue>NewRouteSegment</StringValue>
                                                                  </Name>
                                                               </LookupOnChange>
                                                            </PostCondition>
                                                         </Node>
                                                         <Node NodeType="NodeList" epx="Then" LineNo="80" ColNo="10">
                                                            <NodeId>BLOCK__5</NodeId>
                                                            <InvariantCondition>
                                                               <NOT>
                                                                  <OR>
                                                                     <AND>
                                                                        <EQInternal>
                                                                           <NodeOutcomeVariable>
                                                                              <NodeRef dir="child">if__6</NodeRef>
                                                                           </NodeOutcomeVariable>
                                                                           <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                                                        </EQInternal>
                                                                        <EQInternal>
                                                                           <NodeStateVariable>
                                                                              <NodeRef dir="child">if__6</NodeRef>
                                                                           </NodeStateVariable>
                                                                           <NodeStateValue>FINISHED</NodeStateValue>
                                                                        </EQInternal>
                                                                     </AND>
                                                                     <AND>
                                                                        <EQInternal>
                                                                           <NodeOutcomeVariable>
                                                                              <NodeRef dir="child">COMMAND__8</NodeRef>
                                                                           </NodeOutcomeVariable>
                                                                           <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                                                        </EQInternal>
                                                                        <EQInternal>
                                                                           <NodeStateVariable>
                                                                              <NodeRef dir="child">COMMAND__8</NodeRef>
                                                                           </NodeStateVariable>
                                                                           <NodeStateValue>FINISHED</NodeStateValue>
                                                                        </EQInternal>
                                                                     </AND>
                                                                  </OR>
                                                               </NOT>
                                                            </InvariantCondition>
                                                            <StartCondition>
                                                               <EQInternal>
                                                                  <NodeOutcomeVariable>
                                                                     <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                                  </NodeOutcomeVariable>
                                                                  <NodeOutcomeValue>SUCCESS</NodeOutcomeValue>
                                                               </EQInternal>
                                                            </StartCondition>
                                                            <SkipCondition>
                                                               <EQInternal>
                                                                  <NodeFailureVariable>
                                                                     <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                                  </NodeFailureVariable>
                                                                  <NodeFailureValue>POST_CONDITION_FAILED</NodeFailureValue>
                                                               </EQInternal>
                                                            </SkipCondition>
                                                            <NodeBody>
                                                               <NodeList>
                                                                  <Node NodeType="NodeList" epx="If" LineNo="80" ColNo="10">
                                                                     <NodeId>if__6</NodeId>
                                                                     <NodeBody>
                                                                        <NodeList>
                                                                           <Node NodeType="Empty" epx="Condition">
                                                                              <NodeId>ep2cp_IfTest</NodeId>
                                                                              <PostCondition>
                                                                                 <BooleanVariable>LostComm</BooleanVariable>
                                                                              </PostCondition>
                                                                           </Node>
                                                                           <Node NodeType="LibraryNodeCall" epx="Then">
                                                                              <NodeId>LibraryCall__7</NodeId>
                                                                              <StartCondition>
                                                                                 <EQInternal>
                                                                                    <NodeOutcomeVariable>
                                                                                       <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                                                    </NodeOutcomeVariable>
                                                                                    <NodeOutcomeValue>SUCCESS</NodeOutcomeValue>
                                                                                 </EQInternal>
                                                                              </StartCondition>
                                                                              <SkipCondition>
                                                                                 <EQInternal>
                                                                                    <NodeFailureVariable>
                                                                                       <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                                                    </NodeFailureVariable>
                                                                                    <NodeFailureValue>POST_CONDITION_FAILED</NodeFailureValue>
                                                                                 </EQInternal>
                                                                              </SkipCondition>
                                                                              <NodeBody>
                                                                                 <LibraryNodeCall>
                                                                                    <NodeId>AdjustForLostComm</NodeId>
                                                                                 </LibraryNodeCall>
                                                                              </NodeBody>
                                                                           </Node>
                                                                        </NodeList>
                                                                     </NodeBody>
                                                                  </Node>
                                                                  <Node NodeType="Command" LineNo="80" ColNo="10">
                                                                     <NodeId>COMMAND__8</NodeId>
                                                                     <StartCondition>
                                                                        <EQInternal>
                                                                           <NodeStateVariable>
                                                                              <NodeRef dir="sibling">if__6</NodeRef>
                                                                           </NodeStateVariable>
                                                                           <NodeStateValue>FINISHED</NodeStateValue>
                                                                        </EQInternal>
                                                                     </StartCondition>
                                                                     <NodeBody>
                                                                        <Command>
                                                                           <Name>
                                                                              <StringValue>command_next_route_segment</StringValue>
                                                                           </Name>
                                                                        </Command>
                                                                     </NodeBody>
                                                                  </Node>
                                                               </NodeList>
                                                            </NodeBody>
                                                         </Node>
                                                         <Node NodeType="Empty" epx="ElseIf">
                                                            <NodeId>ep2cp_ElseIf-1</NodeId>
                                                            <StartCondition>
                                                               <EQInternal>
                                                                  <NodeFailureVariable>
                                                                     <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                                  </NodeFailureVariable>
                                                                  <NodeFailureValue>POST_CONDITION_FAILED</NodeFailureValue>
                                                               </EQInternal>
                                                            </StartCondition>
                                                            <SkipCondition>
                                                               <EQInternal>
                                                                  <NodeOutcomeVariable>
                                                                     <NodeRef dir="sibling">ep2cp_IfTest</NodeRef>
                                                                  </NodeOutcomeVariable>
                                                                  <NodeOutcomeValue>SUCCESS</NodeOutcomeValue>
                                                               </EQInternal>
                                                            </SkipCondition>
                                                            <PostCondition>
                                                               <LookupOnChange>
                                                                  <Name>
                                                                     <StringValue>CurrentRouteSegmentAchieved</StringValue>
                                                                  </Name>
                                                               </LookupOnChange>
                                                            </PostCondition>
                                                         </Node>
                                                         <Node NodeType="Command" epx="Then" LineNo="83" ColNo="10">
                                                            <NodeId>COMMAND__10</NodeId>
                                                            <StartCondition>
                                                               <EQInternal>
                                                                  <NodeOutcomeVariable>
                                                                     <NodeRef dir="sibling">ep2cp_ElseIf-1</NodeRef>
                                                                  </NodeOutcomeVariable>
                                                                  <NodeOutcomeValue>SUCCESS</NodeOutcomeValue>
                                                               </EQInternal>
                                                            </StartCondition>
                                                            <SkipCondition>
                                                               <NOT>
                                                                  <EQInternal>
                                                                     <NodeOutcomeVariable>
                                                                        <NodeRef dir="sibling">ep2cp_ElseIf-1</NodeRef>
                                                                     </NodeOutcomeVariable>
                                                                     <NodeOutcomeValue>SUCCESS</NodeOutcomeValue>
                                                                  </EQInternal>
                                                               </NOT>
                                                            </SkipCondition>
                                                            <NodeBody>
                                                               <Command>
                                                                  <Name>
                                                                     <StringValue>complete_route_segment</StringValue>
                                                                  </Name>
                                                               </Command>
                                                            </NodeBody>
                                                         </Node>
                                                         <Node NodeType="Command" epx="Else" LineNo="86" ColNo="10">
                                                            <NodeId>COMMAND__12</NodeId>
                                                            <StartCondition>
                                                               <EQInternal>
                                                                  <NodeFailureVariable>
                                                                     <NodeRef dir="sibling">ep2cp_ElseIf-1</NodeRef>
                                                                  </NodeFailureVariable>
                                                                  <NodeFailureValue>POST_CONDITION_FAILED</NodeFailureValue>
                                                               </EQInternal>
                                                            </StartCondition>
                                                            <SkipCondition>
                                                               <OR>
                                                                  <EQInternal>
                                                                     <NodeOutcomeVariable>
                                                                        <NodeRef dir="sibling">ep2cp_ElseIf-1</NodeRef>
                                                                     </NodeOutcomeVariable>
                                                                     <NodeOutcomeValue>SKIPPED</NodeOutcomeValue>
                                                                  </EQInternal>
                                                                  <EQInternal>
                                                                     <NodeOutcomeVariable>
                                                                        <NodeRef dir="sibling">ep2cp_ElseIf-1</NodeRef>
                                                                     </NodeOutcomeVariable>
                                                                     <NodeOutcomeValue>SUCCESS</NodeOutcomeValue>
                                                                  </EQInternal>
                                                               </OR>
                                                            </SkipCondition>
                                                            <NodeBody>
                                                               <Command>
                                                                  <Name>
                                                                     <StringValue>check_flight_progress</StringValue>
                                                                  </Name>
                                                               </Command>
                                                            </NodeBody>
                                                         </Node>
                                                      </NodeList>
                                                   </NodeBody>
                                                </Node>
                                                <Node NodeType="Command" LineNo="89" ColNo="8">
                                                   <NodeId>COMMAND__13</NodeId>
                                                   <StartCondition>
                                                      <EQInternal>
                                                         <NodeStateVariable>
                                                            <NodeRef dir="sibling">if__4</NodeRef>
                                                         </NodeStateVariable>
                                                         <NodeStateValue>FINISHED</NodeStateValue>
                                                      </EQInternal>
                                                   </StartCondition>
                                                   <NodeBody>
                                                      <Command>
                                                         <Name>
                                                            <StringValue>adjust_altitude</StringValue>
                                                         </Name>
                                                      </Command>
                                                   </NodeBody>
                                                </Node>
                                             </NodeList>
                                          </NodeBody>
                                       </Node>
                                    </NodeList>
                                 </NodeBody>
                              </Node>
                           </NodeList>
                        </NodeBody>
                     </Node>
                  </NodeList>
               </NodeBody>
            </Node>
            <Node NodeType="NodeList" epx="Sequence" LineNo="99" ColNo="4">
               <NodeId>HandleLostComm</NodeId>
               <RepeatCondition>
                  <BooleanValue>true</BooleanValue>
               </RepeatCondition>
               <InvariantCondition>
                  <NOT>
                     <OR>
                        <AND>
                           <EQInternal>
                              <NodeOutcomeVariable>
                                 <NodeRef dir="child">InitiateLostComm</NodeRef>
                              </NodeOutcomeVariable>
                              <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                           </EQInternal>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="child">InitiateLostComm</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </AND>
                        <AND>
                           <EQInternal>
                              <NodeOutcomeVariable>
                                 <NodeRef dir="child">CancelLostComm</NodeRef>
                              </NodeOutcomeVariable>
                              <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                           </EQInternal>
                           <EQInternal>
                              <NodeStateVariable>
                                 <NodeRef dir="child">CancelLostComm</NodeRef>
                              </NodeStateVariable>
                              <NodeStateValue>FINISHED</NodeStateValue>
                           </EQInternal>
                        </AND>
                     </OR>
                  </NOT>
               </InvariantCondition>
               <NodeBody>
                  <NodeList>
                     <Node NodeType="NodeList" epx="Sequence" LineNo="105" ColNo="6">
                        <NodeId>InitiateLostComm</NodeId>
                        <StartCondition>
                           <AND>
                              <BooleanVariable>LostComm</BooleanVariable>
                              <NOT>
                                 <LookupOnChange>
                                    <Name>
                                       <StringValue>AtFinalApproachFix</StringValue>
                                    </Name>
                                 </LookupOnChange>
                              </NOT>
                           </AND>
                        </StartCondition>
                        <EndCondition>
                           <OR>
                              <NOT>
                                 <BooleanVariable>LostComm</BooleanVariable>
                              </NOT>
                              <LookupOnChange>
                                 <Name>
                                    <StringValue>AtFinalApproachFix</StringValue>
                                 </Name>
                              </LookupOnChange>
                           </OR>
                        </EndCondition>
                        <InvariantCondition>
                           <NOT>
                              <OR>
                                 <AND>
                                    <EQInternal>
                                       <NodeOutcomeVariable>
                                          <NodeRef dir="child">COMMAND__14</NodeRef>
                                       </NodeOutcomeVariable>
                                       <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                    </EQInternal>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="child">COMMAND__14</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </AND>
                                 <AND>
                                    <EQInternal>
                                       <NodeOutcomeVariable>
                                          <NodeRef dir="child">COMMAND__15</NodeRef>
                                       </NodeOutcomeVariable>
                                       <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                    </EQInternal>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="child">COMMAND__15</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </AND>
                                 <AND>
                                    <EQInternal>
                                       <NodeOutcomeVariable>
                                          <NodeRef dir="child">LibraryCall__16</NodeRef>
                                       </NodeOutcomeVariable>
                                       <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                                    </EQInternal>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="child">LibraryCall__16</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </AND>
                              </OR>
                           </NOT>
                        </InvariantCondition>
                        <NodeBody>
                           <NodeList>
                              <Node NodeType="Command" LineNo="107" ColNo="6">
                                 <NodeId>COMMAND__14</NodeId>
                                 <NodeBody>
                                    <Command>
                                       <Name>
                                          <StringValue>pprint</StringValue>
                                       </Name>
                                       <Arguments LineNo="108" ColNo="14">
                                          <StringValue>Initiating Lost Comms procedure at time </StringValue>
                                          <IntegerVariable>Time</IntegerVariable>
                                       </Arguments>
                                    </Command>
                                 </NodeBody>
                              </Node>
                              <Node NodeType="Command" LineNo="108" ColNo="6">
                                 <NodeId>COMMAND__15</NodeId>
                                 <StartCondition>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="sibling">COMMAND__14</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </StartCondition>
                                 <NodeBody>
                                    <Command>
                                       <Name>
                                          <StringValue>squawk</StringValue>
                                       </Name>
                                       <Arguments LineNo="109" ColNo="13">
                                          <IntegerValue>7600</IntegerValue>
                                       </Arguments>
                                    </Command>
                                 </NodeBody>
                              </Node>
                              <Node NodeType="LibraryNodeCall">
                                 <NodeId>LibraryCall__16</NodeId>
                                 <StartCondition>
                                    <EQInternal>
                                       <NodeStateVariable>
                                          <NodeRef dir="sibling">COMMAND__15</NodeRef>
                                       </NodeStateVariable>
                                       <NodeStateValue>FINISHED</NodeStateValue>
                                    </EQInternal>
                                 </StartCondition>
                                 <NodeBody>
                                    <LibraryNodeCall>
                                       <NodeId>AdjustForLostComm</NodeId>
                                    </LibraryNodeCall>
                                 </NodeBody>
                              </Node>
                           </NodeList>
                        </NodeBody>
                     </Node>
                     <Node NodeType="Command" LineNo="116" ColNo="6">
                        <NodeId>CancelLostComm</NodeId>
                        <StartCondition>
                           <AND>
                              <EQInternal>
                                 <NodeStateVariable>
                                    <NodeRef dir="sibling">InitiateLostComm</NodeRef>
                                 </NodeStateVariable>
                                 <NodeStateValue>FINISHED</NodeStateValue>
                              </EQInternal>
                              <NOT>
                                 <BooleanVariable>LostComm</BooleanVariable>
                              </NOT>
                           </AND>
                        </StartCondition>
                        <SkipCondition>
                           <AND>
                              <EQInternal>
                                 <NodeStateVariable>
                                    <NodeRef dir="sibling">InitiateLostComm</NodeRef>
                                 </NodeStateVariable>
                                 <NodeStateValue>FINISHED</NodeStateValue>
                              </EQInternal>
                              <LookupOnChange>
                                 <Name>
                                    <StringValue>AtFinalApproachFix</StringValue>
                                 </Name>
                              </LookupOnChange>
                           </AND>
                        </SkipCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>pprint</StringValue>
                              </Name>
                              <Arguments LineNo="117" ColNo="14">
                                 <StringValue>Terminating Lost Comms procedure at time </StringValue>
                                 <IntegerVariable>Time</IntegerVariable>
                              </Arguments>
                           </Command>
                        </NodeBody>
                     </Node>
                  </NodeList>
               </NodeBody>
            </Node>
            <Node NodeType="NodeList" epx="Sequence" LineNo="128" ColNo="4">
               <NodeId>HandleEFC</NodeId>
               <RepeatCondition>
                  <BooleanValue>true</BooleanValue>
               </RepeatCondition>
               <InvariantCondition>
                  <NOT>
                     <AND>
                        <EQInternal>
                           <NodeOutcomeVariable>
                              <NodeRef dir="child">RequestFurtherClearance</NodeRef>
                           </NodeOutcomeVariable>
                           <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                        </EQInternal>
                        <EQInternal>
                           <NodeStateVariable>
                              <NodeRef dir="child">RequestFurtherClearance</NodeRef>
                           </NodeStateVariable>
                           <NodeStateValue>FINISHED</NodeStateValue>
                        </EQInternal>
                     </AND>
                  </NOT>
               </InvariantCondition>
               <NodeBody>
                  <NodeList>
                     <Node NodeType="Command" LineNo="133" ColNo="6">
                        <NodeId>RequestFurtherClearance</NodeId>
                        <StartCondition>
                           <LookupOnChange>
                              <Name>
                                 <StringValue>DueEFC</StringValue>
                              </Name>
                           </LookupOnChange>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>request_further_clearance</StringValue>
                              </Name>
                           </Command>
                        </NodeBody>
                     </Node>
                  </NodeList>
               </NodeBody>
            </Node>
            <Node NodeType="NodeList" epx="Sequence" LineNo="143" ColNo="4">
               <NodeId>HandleClearanceLimit</NodeId>
               <RepeatCondition>
                  <BooleanValue>true</BooleanValue>
               </RepeatCondition>
               <InvariantCondition>
                  <NOT>
                     <AND>
                        <EQInternal>
                           <NodeOutcomeVariable>
                              <NodeRef dir="child">WaitForClearanceLimit</NodeRef>
                           </NodeOutcomeVariable>
                           <NodeOutcomeValue>FAILURE</NodeOutcomeValue>
                        </EQInternal>
                        <EQInternal>
                           <NodeStateVariable>
                              <NodeRef dir="child">WaitForClearanceLimit</NodeRef>
                           </NodeStateVariable>
                           <NodeStateValue>FINISHED</NodeStateValue>
                        </EQInternal>
                     </AND>
                  </NOT>
               </InvariantCondition>
               <NodeBody>
                  <NodeList>
                     <Node NodeType="Command" LineNo="146" ColNo="6">
                        <NodeId>WaitForClearanceLimit</NodeId>
                        <StartCondition>
                           <LookupOnChange>
                              <Name>
                                 <StringValue>AtClearanceLimit</StringValue>
                              </Name>
                           </LookupOnChange>
                        </StartCondition>
                        <NodeBody>
                           <Command>
                              <Name>
                                 <StringValue>handle_clearance_limit</StringValue>
                              </Name>
                           </Command>
                        </NodeBody>
                     </Node>
                  </NodeList>
               </NodeBody>
            </Node>
         </NodeList>
      </NodeBody>
   </Node>
</PlexilPlan>