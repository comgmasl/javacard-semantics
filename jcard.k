require "JCRE/defaultApplets/default-applets-initialization.k"
require "JCRE/basicLogicalChannel/basic-logical-channel.k"
require "syntax/jcard-syntax.k"
require "semantics/jcard-semantics.k"


module JCARD
  imports JCARD-SYNTAX
  imports DEFAULT-APPLETS-INITIALIZATION
  imports BASIC-LOGICAL-CHANNEL
  imports JCARD-SEMANTICS

/*@ \subsection{Configuration}

*/

  configuration <T color="red">
                  <thread color="orange">
                      <k color="green"> ($PGM:Stmts ~> execute) </k>
                      <br/>
                      <control color="cyan">
                        <fstack color="blue"> .List </fstack>
                        <xstack color="purple"> .List </xstack>
                        <return color="LimeGreen"> void </return>  // KOOL
                        <br/>
                        <crntObj color="Fuchsia">  // KOOL
                           <crntClass> Object </crntClass>
                           <envStack> .List </envStack>
                           <location multiplicity="?"> .K </location>
                        </crntObj>
                      </control>
                      <br/>
                      <env color="violet"> .Map </env>
                  </thread>
                  <br/>
                  <store color="white"> .Map </store>
                  <in color="magenta" stream="stdin"> .List </in>
                  <out color="brown" stream="stdout"> .List </out>
                  <nextLoc color="gray"> 0 </nextLoc>
                  <br/>
                  <classes color="Fuchsia">        // KOOL
                     <class multiplicity="*" color="Fuchsia">
                        <className color="Fuchsia"> Main </className>
                        <extends color="Fuchsia"> Object </extends>
                        <declarations color="Fuchsia"> .K </declarations>
                        <finalM> .K </finalM>
                        <staticM> .K </staticM>
                        <accesM> .K </accesM>
                        <abstractM> .K </abstractM>
                        <instructions> .Map </instructions>
                        <noIns> 0 </noIns>
                        <classRid> 0 </classRid>
                        <classPix> 0 </classPix>
                        <implements> .List </implements>
                        <staticEnv> .Map </staticEnv>
                     </class>
                  </classes>
                  <crntApplet> .K </crntApplet>
                  <rid> 10000 </rid>
                  <pix> 0 </pix>
                  <package> .List </package> 
                  <importing> .List </importing>  
                  <card>
                    <logicalChannels>
                      <logicalChannel  multiplicity="*">
                        <selectedApplet> -1 </selectedApplet>
                        <state>  "open" </state>
                        <channelNumber> 0 </channelNumber>
                      </logicalChannel>
                    </logicalChannels>
                    <unusedLCNo>
                      ListItem(1)
                      ListItem(2)
                      ListItem(3)
                      ListItem(4)
                      ListItem(5)
                      ListItem(6)
                      ListItem(7)
                      ListItem(8)
                      ListItem(9)
                      ListItem(10)
                      ListItem(11)
                      ListItem(12)
                      ListItem(13)
                      ListItem(14)
                      ListItem(15)
                      ListItem(16)
                      ListItem(17)
                      ListItem(18)
                      ListItem(19)
                    </unusedLCNo>
                    <defaultApplets>
                      .Map
                    </defaultApplets>
                    <installFunction> .Map </installFunction>
                    <appletNo> 0 </appletNo>
                    <initApplets> 0 </initApplets>
                    <tableApplets> .Map </tableApplets>
                  </card>
                  <parsing> true </parsing>
                  <globalIns> .Map </globalIns>
                  <globalnoIns> 0 </globalnoIns>
                  
                  <command>      
                    <response>
                      <datalength> 0 </datalength>
                      <dataResponse> "" </dataResponse>
                      <sw1> "90" </sw1>
                      <sw2> "00" </sw2>
                    </response>
                    <apduCommand>
                      <CLA> "" </CLA>
                      <INS> "" </INS>
                      <P1> "" </P1>
                      <P2> "" </P2>
                      <Lc> "" </Lc>
                      <dataField> 0 </dataField>
                      <Le> "" </Le>
                    </apduCommand>                  
                    <byteNoAPDU>
                      0
                    </byteNoAPDU>
                  </command>
                </T>  

endmodule