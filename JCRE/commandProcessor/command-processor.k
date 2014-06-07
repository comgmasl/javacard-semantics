require "manageChannel/openCommand/check-open-command.k"
require "manageChannel/closeCommand/check-close-command.k"
require "selectFile/select-file-command.k"
require "otherCommands/other-commands.k"


module COMMAND-PROCESSOR
  imports SELECT-FILE-COMMAND
  imports CHECK-OPEN-COMMAND
  imports CHECK-CLOSE-COMMAND
  imports OTHER-COMMANDS
	
	syntax Exp ::= "receiveCommand" "(" ")"
               | "sendCommand" "(" ")"
	
	syntax Stmts ::= "processAPDUCommand" "(" String ")"  
				        | "'runAPDUCommand" "[" Int "]"
                | "'getLogicalChannelFromCommand"
  	

  /* ************************************************************************************************* */
  /*                               Accepting input                                                     */
  /* ************************************************************************************************* */


  /* ************************************************************************************************* */
  /*                               Reading CLA byte                                                    */
  /* ************************************************************************************************* */
  rule <k> receiveCommand() => HexStringToInt(substrString(I,0,(lengthString(I) -Int 1) )) ...</k>
   	  <in> ListItem(I:String) => . ...</in>
  		<apduCommand>
         ...
  		 	<CLA> S:String => substrString(I,0,(lengthString(I) -Int 1) ) </CLA>
        <dataField> _ =>  0 </dataField>
  		 	...
  		</apduCommand>	
  		<byteNoAPDU> No:Int => No +Int 1 </byteNoAPDU>
  		 when No ==Int 0


  /* ************************************************************************************************* */
  /*                               Reading INS byte                                                    */
  /* ************************************************************************************************* */
  rule <k> receiveCommand() => HexStringToInt(substrString(I,0,(lengthString(I) -Int 1) )) ...</k>
  		<in> ListItem(I:String) => . ...</in>
  		<apduCommand>
  		 	<INS> S:String => substrString(I,0,(lengthString(I) -Int 1) ) </INS>
  		 	...
  		</apduCommand>	
  		<byteNoAPDU> No:Int => No +Int 1 </byteNoAPDU>
  		 when No ==Int 1


  /* ************************************************************************************************* */
  /*                               Reading P1 byte                                                     */
  /* ************************************************************************************************* */
  rule <k> receiveCommand() => HexStringToInt(substrString(I,0,(lengthString(I) -Int 1) )) ...</k>
  		<in> ListItem(I:String) => . ...</in>
  		<apduCommand>
  		 	<P1> S:String => substrString(I,0,(lengthString(I) -Int 1) ) </P1>
  		 	...
  		</apduCommand>	
  		<byteNoAPDU> No:Int => No +Int 1 </byteNoAPDU>
  		 when No ==Int 2


  /* ************************************************************************************************* */
  /*                               Reading P2 byte                                                     */
  /* ************************************************************************************************* */
  rule <k> receiveCommand() => HexStringToInt(substrString(I,0,(lengthString(I) -Int 1) )) ...</k>
     	<in> ListItem(I:String) => . ...</in>
  		<apduCommand>
  		 	<P2> S:String => substrString(I,0,(lengthString(I) -Int 1) ) </P2>
  		 	...
  		</apduCommand>	
  		<byteNoAPDU> No:Int => No +Int 1 </byteNoAPDU>
  		 when No ==Int 3


  /* ************************************************************************************************* */
  /*                               Reading LC byte                                                     */
  /* ************************************************************************************************* */
  rule <k> receiveCommand() => HexStringToInt(substrString(I,0,(lengthString(I) -Int 1) )) ...</k>
  		<in> ListItem(I:String) => . ...</in>
  		<apduCommand>
  		 	<Lc> S:String => substrString(I,0,(lengthString(I) -Int 1) ) </Lc>
  		 	...
  		</apduCommand>	
  		<byteNoAPDU> No:Int => No +Int 1 </byteNoAPDU>
  		 when No ==Int 4


  /* ************************************************************************************************* */
  /*                               Reading data field bytes                                            */
  /* ************************************************************************************************* */
  rule <k> receiveCommand() => HexStringToInt(substrString(I,0,(lengthString(I) -Int 1) )) ...</k>
  		<in> ListItem(I:String) => . ...</in>
  		<apduCommand>
        ...
        <Lc> Lc:String </Lc>
  		 	<dataField> Df:Int => Df *Int 10 +Int HexStringToInt(substrString(I,0,(lengthString(I) -Int 1))) </dataField>
  		 	...
  		</apduCommand>	
  		<byteNoAPDU> No:Int => No +Int 1 </byteNoAPDU>
  		 when No <Int (5 +Int HexStringToInt(Lc))


  /* ************************************************************************************************* */
  /*                               Reading Le bytes                                                    */
  /* ************************************************************************************************* */
  rule <k> receiveCommand() => HexStringToInt(substrString(I,0,(lengthString(I) -Int 1) ))...</k>
  		<in> ListItem(I:String) => . ...</in>
  		<apduCommand>
        ...
        <Lc> Lc:String </Lc>
  		 	<Le> S:String => substrString(I,0,(lengthString(I) -Int 1) ) </Le>
  		 	...
  		</apduCommand>	
  		<byteNoAPDU> No:Int => 0 </byteNoAPDU>
  		 when No ==Int (5 +Int HexStringToInt(Lc))


  /* ************************************************************************************************* */
  /*                               Sending command                                                     */
  /* ************************************************************************************************* */
  rule <k> sendCommand() => 'getLogicalChannelFromCommand ...</k>


  /* ************************************************************************************************* */
  /*                              Logical Channel 0                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [0] ...</k>
      <apduCommand>
        ...
          <CLA> "0x00" </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 1                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [1] ...</k>
      <apduCommand>
          ...
            <CLA> "0x01" </CLA>
          ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 2                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [2] ...</k>
      <apduCommand>
        ...
          <CLA> "0x02" </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 3                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [3] ...</k>
      <apduCommand>
        ...
          <CLA> "0x03" </CLA>
        ...
      </apduCommand>
  

  /* ************************************************************************************************* */
  /*                              Logical Channel 4                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [4] ...</k>
      <apduCommand>
        ...
          <CLA> "0x40" </CLA>
        ...
      </apduCommand>
  

  /* ************************************************************************************************* */
  /*                              Logical Channel 5                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [5] ...</k>
      <apduCommand>
        ...
          <CLA> "0x41" </CLA>
        ...
      </apduCommand>
  

  /* ************************************************************************************************* */
  /*                              Logical Channel 6                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [6] ...</k>
      <apduCommand>
        ...
          <CLA> "0x42" </CLA>
        ...
      </apduCommand>
  

  /* ************************************************************************************************* */
  /*                              Logical Channel 7                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [7] ...</k>
      <apduCommand>
        ...
          <CLA> "0x43" </CLA>
        ...
      </apduCommand>
  

  /* ************************************************************************************************* */
  /*                              Logical Channel 8                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [8] ...</k>
      <apduCommand>
        ...
          <CLA> "0x44" </CLA>
        ...
      </apduCommand>
  
  
  /* ************************************************************************************************* */
  /*                              Logical Channel 9                                                    */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [9] ...</k>
      <apduCommand>
        ...
          <CLA> "0x45" </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 10                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [10] ...</k>
      <apduCommand>
        ...
          <CLA> "0x46" </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 11                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [11] ...</k>
      <apduCommand>
        ...
          <CLA> "0x47" </CLA>
        ...
      </apduCommand>
      

  /* ************************************************************************************************* */
  /*                              Logical Channel 12                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [12] ...</k>
      <apduCommand>
        ...
          <CLA> "0x48" </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 13                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [13] ...</k>
      <apduCommand>
        ...
          <CLA> "0x49" </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 14                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [14] ...</k>
      <apduCommand>
        ...
          <CLA> Cla:String </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 15                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [15] ...</k>
      <apduCommand>
        ...
          <CLA> Cla:String </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 16                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [16] ...</k>
      <apduCommand>
        ...
          <CLA> Cla:String </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 17                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [17] ...</k>
      <apduCommand>
        ...
          <CLA> Cla:String </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 18                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [18] ...</k>
      <apduCommand>
        ...
          <CLA> Cla:String </CLA>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*                              Logical Channel 19                                                   */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'runAPDUCommand [19] ...</k>
      <apduCommand>
        ...
          <CLA> Cla:String </CLA>
        ...
      </apduCommand>


  // ------------------------------------------ SELECT FILE ----------------------------------------- //

  /* ************************************************************************************************* */
  /*                                                                                                   */
  /*                                        SELECT FILE                                                */
  /*                                                                                                   */
  /* ************************************************************************************************* */
  rule <k> 'runAPDUCommand[LCNo:Int] => 'executeSelectFileGivenChannel [LCNo] ...</k>
      <apduCommand>
          ...
            <INS> Ins:String </INS>
          ...
      </apduCommand>
        when Ins ==String "0xa4" orBool Ins ==String "0xA4" 



 //------------------------------------ MANAGE CHANNEL CLOSE ------------------------------------------- //

  /* ************************************************************************************************* */
  /*                                                                                                   */
  /*                              MANAGE CHANNEL CLOSE                                                 */
  /*                                                                                                   */
  /* ************************************************************************************************* */

  /* ************************************************************************************************* */
  /*      If the MANAGE CHANNEL command is issued with P1 not equal 0 or 0x80,                         */
  /*        the Java Card RE responds with status code 0x6A81 (SW_FUNC_NOT_SUPPORTED).                 */
  /* ************************************************************************************************* */
  rule <k>'runAPDUCommand[LCNo:Int] => 'response ...</k>
      <apduCommand>
        ...
          <INS> "0x70" </INS>
          <P1> P1Value:String </P1>
        ...
      </apduCommand>
      <response>
        ...
          <sw1> _ => "6A" </sw1>
          <sw2> _ =>"81" </sw2>
        ...
      </response>
        when P1Value =/=String "0x80" andBool P1Value =/=String "0"


   rule <k> 'runAPDUCommand[LCNo:Int] => 'checkCloseLogicalChannel [ LCNo ,  String2Int(P2) ] ...</k>
        <apduCommand>
            ...
            <INS> "0x70" </INS>
            <P1> "0x80" </P1>
            <P2> P2:String </P2>
            ...
        </apduCommand>


  //--------------------------------------------- MANAGE CHANNEL OPEN ------------------------------------ //

  /* ************************************************************************************************* */
  /*                                                                                                   */
  /*                              MANAGE CHANNEL OPEN                                                  */
  /*                                                                                                   */
  /* ************************************************************************************************* */
  rule <k> 'runAPDUCommand[LCNo:Int] => 'checkOpenLogicalChannel [ LCNo , String2Int(P2) ] ...</k>
      <apduCommand>
        ...
        <INS> "0x70" </INS>
        <P1> "0" </P1>
        <P2> P2:String </P2>
        ...
      </apduCommand>


  /* ************************************************************************************************* */
  /*              If the MANAGE CHANNEL OPEN command has non-zero secure messaging                     */
  /*              bits (b4,b3*) in the CLA byte when the origin logical channel is 0-3 or              */
  /*              non-zero bit (b6*) when the origin logical channel is 4-19, the Java Card RE         */
  /*              responds with status code 0x6882 (SW_SECURE_MESSAGING_NOT_SUPPORTED).                */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'response ...</k>
      <apduCommand>
        ...
        <INS> "0x70" </INS>
        <P1> "0" </P1>
        <P2> P2:String </P2>
        ...
      </apduCommand>
      <response>
        ...
          <sw1> _ => "68" </sw1>
          <sw2> _ => "82" </sw2>
        ...
      </response>
      when P2 =/=String "0"


  /* ************************************************************************************************* */
  /*              If the MANAGE CHANNEL OPEN command has non-zero secure messaging                     */
  /*              bits (b4,b3*) in the CLA byte when the origin logical channel is 0-3 or              */
  /*              non-zero bit (b6*) when the origin logical channel is 4-19, the Java Card RE         */
  /*              responds with status code 0x6882 (SW_SECURE_MESSAGING_NOT_SUPPORTED).                */
  /* ************************************************************************************************* */
  rule <k> 'getLogicalChannelFromCommand => 'response ...</k>
      <apduCommand>
        ...
        <INS> "0x70" </INS>
        <P1> "0x80" </P1>
        ...
      </apduCommand>
      <response>
        ...
          <sw1> _ => "68" </sw1>
          <sw2> _ => "82" </sw2>
        ...
      </response>




//---------------------------------------------------OTHER COMMANDS---------------------------------------//


  rule <k> 'runAPDUCommand [LCNo:Int] => 'generalCommand [LCNo:Int] ...</k>
       <logicalChannel>
          ...
            <channelNumber> LCNo </channelNumber>
          ...
       </logicalChannel>


  /* ************************************************************************************************* */
  /*            When the Java Card RE receives an APDU other than a SELECT FILE or MANAGE              */
  /*            CHANNEL command with either of the following:                                          */
  /*              ■ An unsupported logical channel number in the CLA byte                              */
  /*              ■ An unopened logical channel number in the CLA byte                                 */
  /*        It shall respond to the APDU with status code 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED).   */
  /* ************************************************************************************************* */
  // when the logical channel number is unsupported
  rule <k> 'getLogicalChannelFromCommand => 'response ...</k>
       <response>
        ...
          <sw1> _ => "68" </sw1>
          <sw2> _ => "81" </sw2>
        ...
      </response>


  //when the given channel number is unopened
  rule <k> 'runAPDUCommand[LCNo:Int] => 'response ...</k>
        <response>
        ...
          <sw1> _ => "68" </sw1>
          <sw2> _ => "81" </sw2>
        ...
        </response>


endmodule